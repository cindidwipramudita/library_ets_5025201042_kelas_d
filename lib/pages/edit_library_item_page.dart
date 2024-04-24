import 'package:flutter/material.dart';
import '../db/library_database.dart';
import '../model/library_item.dart';
import '../pages/edit_library_item_page.dart';
import '../pages/library_item_detail_page.dart';
import '../widget/library_item_card_widget.dart';

class EditLibraryItemPage extends StatefulWidget {
  const EditLibraryItemPage({Key? key}) : super(key: key);

  @override
  State<EditLibraryItemPage> createState() => _EditLibraryItemPageState();
}

class _EditLibraryItemPageState extends State<EditLibraryItemPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk input fields
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Library List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tittle'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the tittle';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Tanggal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final date = _dateController.text;
                    final description = _descriptionController.text;
                    final imageUrl = _imageUrlController.text;

                    final libraryItem = LibraryItem(
                      name: name,
                      date: date,
                      description: description,
                      imageUrl: imageUrl,
                    );

                    await LibraryDatabase.instance.create(libraryItem);


                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save'),
              ),


            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}