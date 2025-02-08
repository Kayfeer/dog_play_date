// ignore_for_file: unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore_for_file: library_private_types_in_public_api

class DogInfoScreen extends StatefulWidget {
  const DogInfoScreen({super.key});

  @override
  _DogInfoScreenState createState() => _DogInfoScreenState();
}

class _DogInfoScreenState extends State<DogInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _dogSex;
  bool _onLeash = true;
  XFile? _dogPhoto;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _dogPhoto = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informations sur le chien"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Sexe du chien"),
                items: ["Mâle", "Femelle"]
                    .map((sex) => DropdownMenuItem(
                          value: sex,
                          child: Text(sex),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _dogSex = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Veuillez sélectionner le sexe" : null,
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text("En laisse"),
                value: _onLeash,
                onChanged: (value) {
                  setState(() {
                    _onLeash = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text("Choisir une photo"),
              ),
              if (_dogPhoto != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.file(
                    File(_dogPhoto!.path),
                    height: 150,
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Informations enregistrées")));
                  }
                },
                child: const Text("Enregistrer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
