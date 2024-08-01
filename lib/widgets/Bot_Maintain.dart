import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'modify.dart';
import 'package:http/http.dart' as http;

class BotMaintain extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<BotMaintain> {
  String _fileContent = "";
  String _fileName = "";
  String FilePath = "";
  Uint8List? _fileBytes;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // Get the file bytes and file name
        Uint8List? fileBytes = result.files.single.bytes;
        String? fileName = result.files.single.name;
        

        // Ensure the file bytes are not null
        if (fileBytes != null) {
          String content = utf8.decode(fileBytes, allowMalformed: true);


          // Update the state to display the file content
          setState(() {
            _fileContent = content;
            _fileName = fileName ?? '';
            _fileBytes = fileBytes;
          });

          print("File content read successfully.");
        } else {
          print("File bytes are null.");
        }
      } else {
        print("User canceled the picker.");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> _modify() async {
    if (_fileBytes != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditFilePage(
            fileContent: _fileContent,
            fileBytes: _fileBytes!,
            onSave: (newContent) async {
              // Update the file content
              setState(() {
                _fileContent = newContent;
                _fileBytes = utf8.encode(newContent) as Uint8List;
              });

              try {
      final response = await http.post(
        Uri.parse('http://localhost:5002/api/write_file'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'content': newContent}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _fileContent = newContent;
        });
        print('File content updated successfully.');
      } else {
        print('Failed to update file content: ${response.body}');
      }
    } catch (e) {
      print('Error updating file content: $e');
    }
              
            },
          ),
        ),
      );
    } else {
      print("No file bytes available.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bot Maintaining'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick Text File'),
            ),
            SizedBox(height: 20),
            if (_fileName.isNotEmpty) Text('File Name: $_fileName'),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_fileContent),
              ),
            ),
            ElevatedButton(
              onPressed: _modify,
              child: Text('Make Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
