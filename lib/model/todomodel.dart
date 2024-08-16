import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final Timestamp timestamp;

  ToDo(
      {required this.id,
      required this.title,
      required this.description,
      required this.completed,
      required this.timestamp});

  factory ToDo.fromMap(Map<String, dynamic> data, String documentId) {
    return ToDo(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      completed: data['completed'] ?? false,
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
