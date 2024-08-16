import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/model/todomodel.dart';

class DatabaseServices {
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection("todos");

  User? user = FirebaseAuth.instance.currentUser;

  //Add todo task
  Future<DocumentReference> addToDoItem(
      String title, String description) async {
    return await todoCollection.add({
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
      'uid': user!.uid
    });
  }

  //Update todo task
  Future<void> updateTodoItem(
      String id, String title, String description) async {
    final updateTodoCollection =
        FirebaseFirestore.instance.collection("todos").doc(id);
    return await updateTodoCollection.update({
      'title': title,
      'description': description,
    });
  }

  //update todo task status

  Future<void> updateTodoStatus(String id, bool status) async {
    return await todoCollection.doc(id).update({'completed': status});
  }

  //Delete todo task

  Future<void> deleteTodoItem(String id) async {
    return await todoCollection.doc(id).delete();
  }

  //get pending todo task
  Stream<List<ToDo>> get todos {
    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  //get complete todo task
  Stream<List<ToDo>> get completedtodos {
    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  List<ToDo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ToDo(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        completed: doc['completed'],
        timestamp: doc['createdAt'],
      );
    }).toList();
  }
}
