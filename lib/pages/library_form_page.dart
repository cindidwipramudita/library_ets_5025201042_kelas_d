import 'package:flutter/material.dart';
import '../model/library_item.dart';
import '../db/library_database.dart';

class AddLibraryItemPage extends StatefulWidget {
  const AddLibraryItemPage({Key? key}) : super(key: key);

  @override
  _AddLibraryItemPageState createState() => _AddLibraryItemPageState();
}

class _AddLibraryItemPageState extends State<AddLibraryItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Tittle'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _saveLibraryItem(context),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveLibraryItem(BuildContext context) async {
    final name = _nameController.text.trim();
    final date = _dateController.text.trim() ;
    final description = _descriptionController.text.trim();
    final imageUrl = _imageUrlController.text.trim();

    if (name.isNotEmpty && date.isNotEmpty) {
      final newItem = LibraryItem(
        name: name,
        date: date,
        description: description,
        imageUrl: imageUrl,
      );

      await LibraryDatabase.instance.create(newItem);

      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter valid name and date.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
