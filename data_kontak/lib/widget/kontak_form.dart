import 'dart:io';

import 'package:flutter/material.dart';
import 'package:data_kontak/model/kontak.dart';
import 'package:image_picker/image_picker.dart';
import 'package:data_kontak/main.dart';

class FormKontak extends StatefulWidget {
  const FormKontak({super.key});

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {

  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noTeleponController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
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
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Nama", hintText: "Masukkan Nama"),
                  controller: _namaController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email", hintText: "Masukkan Email"),
                  controller: _emailController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Alamat", hintText: "Masukkan Alamat"),
                  controller: _alamatController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "No Telepon", hintText: "Masukkan No Telepon"),
                  controller: _noTeleponController,
                ),
              ),
              _image == null
              ? Text("Tidak ada gambar yang dipilih")
              : Image.file(_image!),
              ElevatedButton(
                onPressed: () {},
                child: Text("Pilih Gambar"),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var result = await KontakController().addPerson(
                      Kontak(
                        nama: _namaController.text,
                        email: _emailController.text,
                        alamat: _alamatController.text,
                        telepon: _noTeleponController.text
                        foto: _image!.path
                      ),
                      _image,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'],),),);
                  }
                }, child: Text("Simpan")),
              )
            ],
          ),
        ));
  }
}
