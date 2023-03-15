import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';


class DatabaseService {
  String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future updateUserData(String title, String priority, String date, String time,
      bool status, String repetition) async {
    return await taskCollection.doc(uid).set({
      'id': Random().nextInt(1000),
      'title': title,
      'priority': priority,
      'date': date,
      'time': time,
      'status': status,
      'repetition': repetition,
    });
  }


  // task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot) {

    return snapshot.docs.map((doc) {
      return Task(
        id: doc.get('id'),
        title: doc.get('title'),
        priority: doc.get('priority'),
        date: doc.get('date'),
        time: doc.get('time') ,
        status: doc.get('status'),
        repetition: doc.get('repetition'),
      );
    }).toList();
  }

  // get task doc stream
  Stream<List<Task>> get tasks {
    Query query = taskCollection.orderBy('priority', descending: true).limit(5);
    return query.snapshots().map(_taskListFromSnapshot);
  }

  // delete task from firebase
  Future<void> deleteTask(int id) async {
    CollectionReference taskCollection =
        FirebaseFirestore.instance.collection('tasks');
    QuerySnapshot querySnapshot = await taskCollection.where('id', isEqualTo: id).get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    }
  }

  // get docs from firebase where uid == uid
  Future<DocumentSnapshot> getTask() async {
    return await taskCollection.doc(uid).get();
  }

  // add task to firebase
  void saveTaskToFirestore(Task task) async {
    // Step 1: Get a reference to the Firestore collection where you want to store the task
    CollectionReference tasksRef = FirebaseFirestore.instance.collection('tasks');

    // Step 2: Create a new document in the collection
    DocumentReference newDocRef = tasksRef.doc();

    // Step 3: Set the data for the document
    await newDocRef.set({
      'id': task.id,
      'title': task.title,
      'priority': task.priority,
      'date': task.date,
      'time': task.time,
      'status': task.status,
      'repetition': task.repetition,
    });
  }







}