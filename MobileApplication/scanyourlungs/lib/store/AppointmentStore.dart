import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:scanyourlungs/Interfaces/Pulmonologist/menu/AddNewAppointment.dart';
import 'package:scanyourlungs/model/Appointment.dart';
import 'package:scanyourlungs/store/Config.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class AppointmentStore extends Model {
  String _path = Config.localhost;
  LocalStorage _storage = LocalStorage('scanyourlungs');

  List<Appointment> _appointments = new List<Appointment>();
  Appointment _appointment;

  Appointment get appointment {
    return _storage.getItem('appointment');
  }

  List<Appointment> get appointments {
    _appointments = new List<Appointment>();
    var JsonData = _storage.getItem('appointments');
    if (JsonData != null) {
      for (var item in JsonData) {
        _appointments.add(Appointment.fromJson(item));
      }
    }
    return _appointments;
  }

  getAllAppointments() async {
    _appointments = new List<Appointment>();
    final response =
        await http.get(Uri.parse("${_path}/appointment"), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      await _storage.setItem('appointments', responseJson);

      notifyListeners();
    }
  }

  addNewAppointment(
      int patient_id, int pulmonologist_id, String date_appointment) async {
    final body = json.encode({
      'pulmonologist_id': pulmonologist_id,
      'patient_id': patient_id,
      'date_appointment': date_appointment,
    });

    print(body);

    final response = await http.post(Uri.parse("${_path}/appointment"),
        headers: {"Content-Type": "application/json"}, body: body);
  }
}
