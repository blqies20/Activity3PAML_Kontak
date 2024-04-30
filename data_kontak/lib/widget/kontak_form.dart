import 'dart:io';

import 'package:data_kontak/controller/kontak_controller.dart';
import 'package:data_kontak/screen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:data_kontak/model/kontak.dart';
import 'package:image_picker/image_picker.dart';

class FormKontak extends StatefulWidget {
  const FormKontak({super.key});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _noTeleponController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();
  String? _alamat;

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Nama", hintText: "Masukkan Nama"),
                controller: _namaController,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Email", hintText: "Masukkan Email"),
                controller: _emailController,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Alamat"),
                  _alamat == null
                      ? SizedBox(
                          width: double.infinity,
                          child: Text('Alamat Kosong'),
                        )
                      : Text('$_alamat'),
                  _alamat == null
                      ? TextButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                    onLocationSeleced: (selectedAddress) {
                                  setState(() {
                                    _alamat = selectedAddress;
                                  });
                                }),
                              ),
                            );
                          },
                          child: Text('Pilih Alamat'),
                        )
                      : TextButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                    onLocationSeleced: (selectedAddress) {
                                  setState(() {
                                    _alamat = selectedAddress;
                                  });
                                }),
                              ),
                            );
                            setState(() {});
                          },
                          child: Text('Ubah Alamat'),
                        )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "No Telepon", hintText: "Masukkan No Telepon"),
                controller: _noTeleponController,
              ),
            ),
            _image != null
                ? Image.file(_image!)
                : const Text("Tidak ada gambar yang dipilih"),
            ElevatedButton(
              onPressed: getImage,
              child: const Text("Pilih Gambar"),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var result = await KontakController().addPerson(
                      Kontak(
                          nama: _namaController.text,
                          email: _emailController.text,
                          alamat: _alamat ?? '',
                          telepon: _noTeleponController.text,
                          foto: _image!.path),
                      _image,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          result['message'],
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
