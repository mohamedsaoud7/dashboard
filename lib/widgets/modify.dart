import 'package:flutter/material.dart';
import 'dart:typed_data';

class EditFilePage extends StatefulWidget {
  final String fileContent;
  final Uint8List fileBytes;
  final Function(String) onSave;

  EditFilePage({required this.fileContent, required this.fileBytes, required this.onSave});

  @override
  _EditFilePageState createState() => _EditFilePageState();
}

class _EditFilePageState extends State<EditFilePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.fileContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit File'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'File Content',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        widget.onSave(_controller.text);
                        Navigator.pop(context);
                      },
                      child: Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
