import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/todo_model.dart';

class DatabaseServices {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> createMethod(int id, String task, bool status) async {
    _collectionReference
        .doc(id.toString())
        .set({'id': id, 'task': task, 'status': status})
        .then((value) => print('Created Successfully'))
        .catchError((error) => print("Failure: $error"));
  }

  Future<List<TodoModel>> readMethod() async {
    QuerySnapshot querySnapshot = await _collectionReference.get();

    List<TodoModel> todoList = querySnapshot.docs.map((e) {
      final data = e.data() as Map<String, dynamic>;
      return TodoModel(
          id: data['id'], task: data['task'], status: data['status']);
    }).toList();

    return todoList;
  }

  Future<void> updateMethod(
      int id, String updateKey, dynamic updateValue) async {
    _collectionReference
        .doc(id.toString())
        .update({updateKey: updateValue})
        .then((value) => print('Updated Successfully'))
        .catchError((error) => print("Failure: $error"));
  }

  Future<void> deleteMethod(int id) async {
    _collectionReference
        .doc(id.toString())
        .delete()
        .then((value) => print('Deleted Successfully'))
        .catchError((error) => print("Failure: $error"));
  }
}
