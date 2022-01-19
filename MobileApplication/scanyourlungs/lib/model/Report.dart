import 'package:scanyourlungs/model/Doctor.dart';
import 'package:scanyourlungs/model/Patient.dart';
import 'package:scanyourlungs/model/Scan.dart';

class Report {
  int id;
  String date;
  String description;
  Doctor radiologue;
  Patient patient;
  Scan scan;

  Report(
      {this.id,
      this.date,
      this.description,
      this.radiologue,
      this.patient,
      this.scan});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    description = json['description'];
    radiologue = Doctor.fromJson(json['doctor']);
    patient = Patient.fromJson(json['patient']);
    scan = Scan.fromJson(json['scan']);
  }
}
