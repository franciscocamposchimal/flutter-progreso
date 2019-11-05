import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:test_app/models/report_model.dart';
import 'package:test_app/providers/reports_provider.dart';

class ReportsBloc {
  final _reportsController = BehaviorSubject<List<Report>>();
  final _descriptionController = BehaviorSubject<String>();
  final _loadingController = BehaviorSubject<bool>();
  final _reportsProvider = ReportsProvider();

  Stream<List<Report>> get reportsStream => _reportsController.stream;
  Stream<String> get descriptionStream => _descriptionController.stream;
  Stream<bool> get isLoadingStream => _loadingController.stream;

  Function(String) get changeDescription => _descriptionController.sink.add;
  void _setIsLoading(bool isLoading) => _loadingController.add(isLoading);

  String get _description => _descriptionController.value;

  void loadReports() async {
    final reports = await _reportsProvider.getAll();
    _reportsController.sink.add(reports);
  }

  Future<void> addReport(File image, Report report) async {
    _setIsLoading(true);
    //print("ADD REPORT TRUE");
    if (image != null) {
      String fileUrl = await _reportsProvider.uploadFile(image);
      report.photoUrl = fileUrl;
    }
    report.description = _description != null ? _description : "No description";
    await _reportsProvider.create(report);
    //print("ADD REPORT FALSE");
    _setIsLoading(false);
  }

  Future<void> deleteReport(String id, String filePath) async {
    await _reportsProvider.delete(id, filePath);
  }

  dispose() {
    print('DISPOSE');
    _reportsController?.close();
    _loadingController?.close();
    _descriptionController?.close();
  }
}
