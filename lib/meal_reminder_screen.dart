import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class MealReminderScreen extends StatefulWidget {
  const MealReminderScreen({super.key});

  @override
  _MealReminderScreenState createState() => _MealReminderScreenState();
}

class _MealReminderScreenState extends State<MealReminderScreen> {
  List<DateTime> focusedMonths = List.generate(
      4, (index) => DateTime.now().add(Duration(days: index * 30)));

  late SharedPreferences prefs;
  int _timerDuration = 0;
  bool _isTimerRunning = false;
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
    _stopwatch = Stopwatch();
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _nextMonth() {
    setState(() {
      focusedMonths = focusedMonths
          .map((date) => date.add(const Duration(days: 30)))
          .toList();
    });
  }

  void _previousMonth() {
    setState(() {
      focusedMonths = focusedMonths
          .map((date) => date.subtract(const Duration(days: 30)))
          .toList();
    });
  }

  void _showDialog(DateTime date) {
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    final alarmData = prefs.getStringList(dateKey) ?? [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tanggal Dipilih"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (alarmData.isNotEmpty) ...[
                const SizedBox(height: 10),
                const Text("Alarm telah disetting:"),
                ...alarmData.map((alarm) => Text(alarm)).toList(),
              ],
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Tutup"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });

    _stopwatch.start();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_stopwatch.elapsed.inSeconds >= _timerDuration) {
        _stopTimer();
      } else {
        setState(() {});
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });

    _stopwatch.stop();
    _stopwatch.reset();
    _timer.cancel();
  }

  String _formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengingat Makan'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          Tooltip(
            message: 'Pengingat Makan',
            child: IconButton(
              icon: const Icon(Icons.add_alert, color: Colors.yellow),
              onPressed: () => _showDialog(DateTime.now()),
            ),
          ),
          Tooltip(
            message: 'Pengingat Minum',
            child: IconButton(
              icon: const Icon(Icons.local_drink, color: Colors.blue),
              onPressed: () => _showDialog(DateTime.now()),
            ),
          ),
          Tooltip(
            message: 'Timer',
            child: IconButton(
              icon: const Icon(Icons.timer, color: Colors.grey),
              onPressed: () async {
                final duration = await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    int? selectedDuration;
                    return AlertDialog(
                      title: const Text("Set Timer"),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Masukkan durasi dalam detik"),
                        onChanged: (value) {
                          selectedDuration = int.tryParse(value);
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(selectedDuration);
                          },
                          child: const Text("Set"),
                        ),
                      ],
                    );
                  },
                );

                if (duration != null) {
                  setState(() {
                    _timerDuration = duration;
                  });
                  _startTimer();
                }
              },
            ),
          ),
          Tooltip(
            message: 'Olahraga',
            child: IconButton(
              icon: Icon(Icons.fitness_center, color: Colors.grey.shade300),
              onPressed: () => _showDialog(DateTime.now()),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 238, 226),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _previousMonth,
                child: const Text('Kembali'),
              ),
              ElevatedButton(
                onPressed: _nextMonth,
                child: const Text('Selanjutnya'),
              ),
            ],
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: TableCalendar(
                      firstDay: DateTime.utc(2020, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: focusedMonths[index],
                      calendarStyle: const CalendarStyle(
                        canMarkersOverflow: true,
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekendStyle: TextStyle(color: Colors.black),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        leftChevronVisible: false,
                        rightChevronVisible: false,
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, date, _) {
                          if (date.weekday == DateTime.sunday) {
                            return Center(
                              child: Text(
                                '${date.day}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                      availableGestures: AvailableGestures.none,
                      onDaySelected: (selectedDay, focusedDay) {
                        _showDialog(selectedDay);
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          if (_isTimerRunning)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircularProgressIndicator(
                    value: (_timerDuration - _stopwatch.elapsed.inSeconds) /
                        _timerDuration,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Timer: ${_formatDuration(_timerDuration - _stopwatch.elapsed.inSeconds)}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _stopTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Stop Timer"),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
