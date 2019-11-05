import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_provider.dart';
import 'package:test_app/models/report_model.dart';

class ReportsProvider {
  //DB instance
  final FireStoreProvider _db = FireStoreProvider('reports');
  //firestore instance
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://progreso-acb2c.appspot.com');
  StorageUploadTask _uploadTask;

  Future<String> uploadFile(File image) async {
    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.jpg';
    StorageReference storageReference = _storage.ref().child(filePath);
    _uploadTask = storageReference.putFile(image);
    await _uploadTask.onComplete;
    print('File Uploaded');
    String url = await storageReference.getDownloadURL();
    return url;
  }

  //CRUD
  Future<bool> create(Report report) async {
    try {
      await _db.addDocument(report.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Report> getOne(String id) async {
    var report = new Report();
    report.id = '1';
    report.photoUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxUC64VZctJ0un9UBnbUKtj-blhw02PeDEQIMOqovc215LWYKu&s';
    report.ubication = 'ubication';
    report.description = 'decription';
    var getReport = await _db.getDocumentById(id);
    print(getReport);
    return report;
  }

  Future<List<Report>> getAll() async {
    List<Report> reports = new List();
    var listReport = await _db.getDataCollection();
    print('GET ALL');
    print(listReport.documents.length);
    listReport.documents.forEach((document) {
      final report = new Report();
      report.id = document.documentID;
      report.photoUrl = document.data['photoUrl'];
      report.ubication = document.data['ubication'];
      report.description = document.data['description'];
      reports.add(report);
    });
    return reports;
  }

  Future<bool> update(Report data, String id) async {
    await _db.update(data.toJson(), id);
    return true;
  }

  Future<bool> delete(String id, String filePath) async {
    StorageReference storageReference =
        await _storage.getReferenceFromUrl(filePath);
    try {
      await storageReference.delete();
      await _db.removeDocument(id);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
