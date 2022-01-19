import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:scanyourlungs/model/Patient.dart';
import 'package:scanyourlungs/store/Config.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class PatientStore extends Model {
  String _path = Config.localhost;
  String _token = Config.token;
  LocalStorage _storage = LocalStorage('scanyourlungs');
  List<Patient> _patients = new List<Patient>();
  Patient _patient;

  List<Patient> get patient {
    return _storage.getItem('patient');
  }

  List<Patient> get patients {
    _patients = new List<Patient>();
    var JsonData = _storage.getItem('patients');
    if (JsonData != null) {
      for (var item in JsonData) {
        _patients.add(Patient.fromJson(item));
      }
    }
    return _patients;
  }

  //get all patients
  getAllPatients() async {
    _patients = new List<Patient>();
    final response = await http.get(Uri.parse("${_path}/patient"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      await _storage.setItem('patients', responseJson);
      print(responseJson);
      notifyListeners();
    }
  }

  addNewPatient(String nom, String email) async {
    final body = json.encode({
      'nom': nom,
      'email': email,
    });

    final response = await http.post(Uri.parse("${_path}/patient"),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  deletePatient(int id) async {
    final response = await http.delete(Uri.parse("${_path}/patient/$id"));
    print(response.body);
  }
}
