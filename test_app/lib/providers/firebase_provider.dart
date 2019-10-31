import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/utils/utils.dart';

class FireStoreProvider {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  FireStoreProvider(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<QuerySnapshot> getListWhere(String table, String id) {
    return ref.where(table, isEqualTo: id).getDocuments();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map<String, dynamic> data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map<String, dynamic> data, String id) {
    return ref.document(id).updateData(data);
  }

  Future update(Map<String, dynamic> data, String id) async {
     try {
       await ref.document(id).setData(data, merge: true);
       printSuccess('Document inserted...');
     } catch (e) {
       printError('Inserted error...');
       printError(e.toString());
     }
  }
}