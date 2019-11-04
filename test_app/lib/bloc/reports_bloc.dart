
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:test_app/models/report_model.dart';
import 'package:test_app/providers/reports_provider.dart';

class ReportsBloc {
  final _reportsController = BehaviorSubject<List<Report>>();
  final _loadingController  = BehaviorSubject<bool>();
  final _reportsProvider   = ReportsProvider();

  Stream<List<Report>> get reportsStream => _reportsController.stream;
  Stream<bool> get isLoading => _loadingController.stream;

  void loadReports() async {
    final reports = await _reportsProvider.getAll();
    _reportsController.sink.add( reports );
  }

  void agregarProducto( File image, Report report ) async {

    _loadingController.sink.add(true);
    String fileUrl = await _reportsProvider.uploadFile(image);
    report.photoUrl = fileUrl;
    await _reportsProvider.create( report );
    _loadingController.sink.add(false);

  }

    dispose() {
    _reportsController?.close();
    _loadingController?.close();
  }


}