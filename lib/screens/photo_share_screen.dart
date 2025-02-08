import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
// ignore_for_file: library_private_types_in_public_api

class PhotoShareScreen extends StatefulWidget {
  const PhotoShareScreen({super.key});

  @override
  _PhotoShareScreenState createState() => _PhotoShareScreenState();
}

class _PhotoShareScreenState extends State<PhotoShareScreen> {
  XFile? _selectedImage;
  bool _isUploading = false;
  String _moderationResult = "";

  Future<void> _pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = photo;
    });
  }

  Future<void> _uploadAndModeratePhoto() async {
    if (_selectedImage == null) return;

    setState(() {
      _isUploading = true;
      _moderationResult = "";
    });

    File imageFile = File(_selectedImage!.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // Remplacez cette URL par celle de votre serveur sécurisé.
    var apiUrl = Uri.parse("https://votre-serveur-externe/moderate-image");

    var response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"image": base64Image}));

    setState(() {
      _isUploading = false;
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        _moderationResult = data["moderation"];
      } else {
        _moderationResult = "Erreur lors de la modération";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partager une photo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _selectedImage != null
                ? Image.file(
                    File(_selectedImage!.path),
                    height: 200,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child:
                        const Center(child: Text("Aucune image sélectionnée")),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPhoto,
              child: const Text("Sélectionner une photo"),
            ),
            const SizedBox(height: 20),
            _isUploading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _uploadAndModeratePhoto,
                    child: const Text("Uploader et modérer"),
                  ),
            const SizedBox(height: 20),
            if (_moderationResult.isNotEmpty)
              Text("Résultat de la modération : $_moderationResult"),
          ],
        ),
      ),
    );
  }
}
