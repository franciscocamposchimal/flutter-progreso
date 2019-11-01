import 'firebase_provider.dart';
import 'package:test_app/models/report_model.dart';

class ReportsProvider {
  //DB instance
  final FireStoreProvider _db = FireStoreProvider('reports');

  //CRUD
  Future<bool> create(Report report) async {
    var newReport = await _db.addDocument(report.toJson());
    print(newReport);
    return true;
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
    print(listReport);
    return reports;
  }

  Future<bool> update(Report data, String id) async {
    await _db.update(data.toJson(), id);
    return true;
  }

  Future<bool> delete(String id) async {
    await _db.removeDocument(id);
    return true;
  }
}
