import 'package:data_kontak/widget/kontak_form.dart';
import 'package:data_kontak/widget/kontak_header.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [KontakHeader(), FormKontak()],
      ),
    );
  }
}
