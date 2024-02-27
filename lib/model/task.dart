import 'package:todoapp/model/utils.dart';

class Task {
  String? id;
  String title;
  String description;
  DateTime? createdAt;
  String? createdBy;
  String? owner;
  List<String>? sharedWith;

  Task({
    required this.title,
    required this.description,
    this.createdAt,
    this.createdBy,
    this.owner,
    this.sharedWith,
    this.id,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: timestampToDateTime(json['createdAt']),
      createdBy: json['createdBy'],
      owner: json['owner'],
      sharedWith: json['sharedWith'] != null ?List<String>.from(json['sharedWith']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'owner': owner,
      'sharedWith': sharedWith,
    };
  }

}
