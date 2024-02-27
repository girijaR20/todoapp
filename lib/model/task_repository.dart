import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/task.dart';

class TaskRepository {
  final _database = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks(String? owner)  {
    return _database.collection("tasks")
        .where('owner', isEqualTo: owner)
        .snapshots()
        .map((event) =>
          event.docs
              .map((doc) => Task.fromJson({...doc.data(), 'id': doc.id}))
              .toList()
        );
  }

  Stream<List<Task>> getSharedTasks(String? owner) {
    return _database.collection("tasks")
        .where('sharedWith', arrayContains: owner)
        .snapshots()
        .map((event) =>
        event.docs
            .map((doc) => Task.fromJson({...doc.data(), 'id': doc.id}))
            .toList()
    );
  }


  Future<void> addTask(Task task) async {
    task.createdAt = DateTime.now();
    await _database.collection("tasks").add(task.toJson()).then((doc) => {
      print('DocumentSnapshot added with ID: ${doc.id}')
    });
  }

  Future<void> updateTask(Task task) async {
    await _database.collection("tasks")
        .doc(task.id)
        .update(task.toJson())
        .then((doc) => {
          print("Task ${task.id} updated.")
        });
  }

  Future<void> deleteTask(String? taskId) async {
    await _database.collection("tasks").doc(taskId).delete();
  }
}