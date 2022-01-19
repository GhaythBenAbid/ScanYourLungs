import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:scanyourlungs/model/Scan.dart';
import 'package:scanyourlungs/store/Config.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class ScanStore extends Model {
  String _path = Config.localhost;
  LocalStorage _storage = LocalStorage('scanyourlungs');

  List<Scan> _scans = new List<Scan>();
  Scan _scan;

  Scan get scan {
    return _storage.getItem('scan');
  }

  List<Scan> get scans {
    _scans = new List<Scan>();
    var JsonData = _storage.getItem('scans');
    if (JsonData != null) {
      for (var item in JsonData) {
        _scans.add(Scan.fromJson(item));
      }
    }
    return _scans;
  }

  getAllScans() async {
    _scans = new List<Scan>();
    final response = await http.get(Uri.parse("${_path}/scan"), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      await _storage.setItem('scans', responseJson);

      notifyListeners();
    }
  }
}
