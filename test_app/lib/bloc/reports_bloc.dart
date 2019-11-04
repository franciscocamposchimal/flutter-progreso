import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:test_app/models/report_model.dart';
import 'package:test_app/providers/reports_provider.dart';

class ReportsBloc {
  final _reportsController = BehaviorSubject<List<Report>>();
  final _loadingController = BehaviorSubject<bool>();
  final _reportsProvider = ReportsProvider();

  Stream<List<Report>> get reportsStream => _reportsController.stream;
  Stream<bool> get isLoadingStream => _loadingController.stream;

  void _setIsLoading(bool isLoading) => _loadingController.add(isLoading);

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
    await _reportsProvider.create(report);
    //print("ADD REPORT FALSE");
    _setIsLoading(false);
  }

  dispose() {
    print('DISPOSE');
    _reportsController?.close();
    _loadingController?.close();
  }
}
