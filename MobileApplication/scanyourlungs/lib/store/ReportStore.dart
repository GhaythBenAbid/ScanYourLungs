import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:scanyourlungs/model/Report.dart';
import 'package:scanyourlungs/store/Config.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ReportStore extends Model {
  String _path = Config.localhost;
  LocalStorage _storage = LocalStorage('scanyourlungs');

  List<Report> _reports = new List<Report>();
  Report _report;

  Report get report {
    return _storage.getItem('report');
  }

  List<Report> get reports {
    _reports = new List<Report>();
    var JsonData = _storage.getItem('reports');
    if (JsonData != null) {
      for (var item in JsonData) {
        _reports.add(Report.fromJson(item));
      }
    }
    return _reports;
  }

  getAllReports() async {
    _reports = new List<Report>();
    final response = await http.get(Uri.parse("${_path}/report"), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      await _storage.setItem('reports', responseJson);

      notifyListeners();
    }
  }
}
