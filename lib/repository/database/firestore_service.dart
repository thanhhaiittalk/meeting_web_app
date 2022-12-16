import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class FirestoreService {
  //Singleton
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    if(kDebugMode){
      print('$path: $data');
    }
    await reference.set(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    if(kDebugMode){
     print('delete: $path');
    }
    await reference.delete();
  }


  //Temporarily don't those code
  /*TODO: Re-implement stream*/

  // Stream<List<T>> collectionStream<T>({
  //   required String path,
  //   required T builder(Map<String, dynamic> data, String documentID),
  //   required Query queryBuilder(Query query),
  //   required int sort(T lhs, T rhs),
  // }) {
  //   Query query = FirebaseFirestore.instance.collection(path);
  //   if (queryBuilder != null) {
  //     query = queryBuilder(query);
  //   }
  //   final Stream<QuerySnapshot> snapshots = query.snapshots();
  //   return snapshots.map((snapshot) {
  //     final result = snapshot.docs
  //         .map((snapshot) => builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
  //         .where((value) => value != null)
  //         .toList();
  //     if (sort != null) {
  //       result.sort(sort);
  //     }
  //     return result;
  //   });
  // }

  // Stream<T> documentStream<T>({
  //   @required String path,
  //   @required T builder(Map<String, dynamic> data, String documentID),
  // }) {
  //   final DocumentReference reference = Firestore.instance.document(path);
  //   final Stream<DocumentSnapshot> snapshots = reference.snapshots();
  //   return snapshots.map((snapshot) => builder(snapshot.data, snapshot.documentID));
  // }
}