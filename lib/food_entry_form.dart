import 'package:flutter/material.dart';

class FoodEntryForm extends StatefulWidget {
  const FoodEntryForm({super.key});

  @override
  _FoodEntryFormState createState() => _FoodEntryFormState();
}

class _FoodEntryFormState extends State<FoodEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _foodNameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _foodTypeController = TextEditingController();
  final _mealTimeController = TextEditingController();
  final _notesController = TextEditingController();

  List<Map<String, String>> _foodEntries = [];

  @override
  void initState() {
    super.initState();
    _foodEntries = [
      {
        'foodName': 'Nasi Goreng',
        'calories': '300',
        'foodType': 'Makanan Utama',
        'mealTime': 'Sarapan',
        'notes': 'Pedas'
      },
      {
        'foodName': 'Ayam Bakar',
        'calories': '250',
        'foodType': 'Makanan Utama',
        'mealTime': 'Makan Siang',
        'notes': 'Dada Ayam'
      },
      {
        'foodName': 'Salad Buah',
        'calories': '150',
        'foodType': 'Cemilan',
        'mealTime': 'Siang',
        'notes': 'Tanpa Gula'
      },
      {
        'foodName': 'Roti Gandum',
        'calories': '100',
        'foodType': 'Sarapan',
        'mealTime': 'Pagi',
        'notes': 'Dengan selai kacang'
      },
      {
        'foodName': 'Sate Ayam',
        'calories': '200',
        'foodType': 'Makanan Utama',
        'mealTime': 'Makan Malam',
        'notes': '5 tusuk'
      },
      {
        'foodName': 'Smoothie',
        'calories': '180',
        'foodType': 'Minuman',
        'mealTime': 'Sore',
        'notes': 'Buah campuran'
      },
      {
        'foodName': 'Omelette',
        'calories': '220',
        'foodType': 'Sarapan',
        'mealTime': 'Pagi',
        'notes': 'Dengan keju'
      },
      {
        'foodName': 'Sup Ayam',
        'calories': '150',
        'foodType': 'Makanan Utama',
        'mealTime': 'Makan Siang',
        'notes': 'Tanpa mie'
      },
      {
        'foodName': 'Mie Goreng',
        'calories': '350',
        'foodType': 'Makanan Utama',
        'mealTime': 'Makan Malam',
        'notes': 'Pedas'
      },
      {
        'foodName': 'Jus Jeruk',
        'calories': '120',
        'foodType': 'Minuman',
        'mealTime': 'Pagi',
        'notes': 'Segar'
      }
    ];
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _caloriesController.dispose();
    _foodTypeController.dispose();
    _mealTimeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String foodName = _foodNameController.text;
      String calories = _caloriesController.text;
      String foodType = _foodTypeController.text;
      String mealTime = _mealTimeController.text;
      String notes = _notesController.text;

      setState(() {
        _foodEntries.add({
          'foodName': foodName,
          'calories': calories,
          'foodType': foodType,
          'mealTime': mealTime,
          'notes': notes,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disimpan!')),
      );

      _foodNameController.clear();
      _caloriesController.clear();
      _foodTypeController.clear();
      _mealTimeController.clear();
      _notesController.clear();
    }
  }

  void _showFoodDetails(Map<String, String> foodEntry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(foodEntry['foodName']!),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Kalori: ${foodEntry['calories']}'),
                Text('Jenis Makanan: ${foodEntry['foodType']}'),
                Text('Waktu Makan: ${foodEntry['mealTime']}'),
                Text('Catatan: ${foodEntry['notes']}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text(
              'Pencatatan Makanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 238, 226),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextFormField(
                        controller: _foodNameController,
                        label: 'Nama Makanan',
                        icon: Icons.fastfood,
                        iconColor: Colors.yellow,
                      ),
                      const SizedBox(height: 10),
                      _buildTextFormField(
                        controller: _caloriesController,
                        label: 'Jumlah Kalori',
                        icon: Icons.local_fire_department,
                        iconColor: Colors.red,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      _buildTextFormField(
                        controller: _foodTypeController,
                        label: 'Jenis Makanan',
                        icon: Icons.category,
                        iconColor: Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      _buildTextFormField(
                        controller: _mealTimeController,
                        label: 'Waktu Makan',
                        icon: Icons.access_time,
                        iconColor: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      _buildTextFormField(
                        controller: _notesController,
                        label: 'Catatan Tambahan',
                        icon: Icons.notes,
                        iconColor: Colors.grey.shade300,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: _submitForm,
                          icon: const Icon(Icons.save),
                          label: const Text('Simpan'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green,
                            side: const BorderSide(color: Colors.green),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _foodEntries.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 3 : 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio:
                            MediaQuery.of(context).size.width > 600 ? 1 : 0.75,
                      ),
                      itemCount: _foodEntries.length,
                      itemBuilder: (context, index) {
                        final entry = _foodEntries[index];
                        return GestureDetector(
                          onTap: () => _showFoodDetails(entry),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.teal, Colors.green],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 12.0,
                                  spreadRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    entry['foodName']!,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Kalori: ${entry['calories']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Jenis: ${entry['foodType']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Waktu: ${entry['mealTime']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    'Catatan: ${entry['notes']}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text('Tidak ada data')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color iconColor,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: iconColor),
        border: const OutlineInputBorder(),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap isi field ini';
        }
        return null;
      },
    );
  }
}
