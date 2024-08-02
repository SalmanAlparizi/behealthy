import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final String nama;
  final String umur;
  final String noTelepon;
  final String username;

  const EditProfileScreen({
    super.key,
    required this.nama,
    required this.umur,
    required this.noTelepon,
    required this.username,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _namaController;
  late TextEditingController _umurController;
  late TextEditingController _noTeleponController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
    _umurController = TextEditingController(text: widget.umur);
    _noTeleponController = TextEditingController(text: widget.noTelepon);
    _usernameController = TextEditingController(text: widget.username);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _umurController.dispose();
    _noTeleponController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', _namaController.text);
    await prefs.setString('umur', _umurController.text);
    await prefs.setString('noTelepon', _noTeleponController.text);
    await prefs.setString('username', _usernameController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade300, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700)),
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan nama Anda',
                  ),
                ),
                const SizedBox(height: 16),
                Text('Umur',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700)),
                TextField(
                  controller: _umurController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan umur Anda',
                  ),
                ),
                const SizedBox(height: 16),
                Text('Nomor Telepon',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700)),
                TextField(
                  controller: _noTeleponController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan nomor telepon Anda',
                  ),
                ),
                const SizedBox(height: 16),
                Text('Username',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700)),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan username Anda',
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
