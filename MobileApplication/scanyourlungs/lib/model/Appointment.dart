import 'package:scanyourlungs/model/Doctor.dart';
import 'package:scanyourlungs/model/Patient.dart';

class Appointment {
  int id;
  DateTime date_appointment;
  Patient patient;
  Doctor pulmonologist;

  Appointment(
      {this.id, this.date_appointment, this.patient, this.pulmonologist});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date_appointment = DateTime.parse(json['date_appointment']);
    patient = new Patient.fromJson(json['patient']);
    pulmonologist = new Doctor.fromJson(json['doctor']);
  }
}
