import 'package:flutter/material.dart';

class LibraryItem {
  final int? id;
  final String name;
  final String date;
  final String description;
  final String imageUrl;

  LibraryItem({
    this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.imageUrl,
  });

  LibraryItem copyWith({
    int? id,
    String? name,
    String? date,
    String? description,
    String? imageUrl,
  }) {
    return LibraryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory LibraryItem.fromMap(Map<String, dynamic> map) {
    return LibraryItem(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }
}
