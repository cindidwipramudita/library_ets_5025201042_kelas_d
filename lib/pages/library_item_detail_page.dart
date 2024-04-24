import 'package:flutter/material.dart';

class LibraryItemDetailPage extends StatefulWidget {
  final int itemId;

  const LibraryItemDetailPage({Key? key, required this.itemId})
      : super(key: key);

  @override
  State<LibraryItemDetailPage> createState() =>
      _LibraryItemDetailPageState();
}

class _LibraryItemDetailPageState extends State<LibraryItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
      ),
      body: Center(
        child: Text('Book Detail Page for Item ID: ${widget.itemId}'),
      ),
    );
  }
}
