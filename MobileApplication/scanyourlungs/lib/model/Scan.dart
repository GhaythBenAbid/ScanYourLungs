import 'dart:ffi';

class Scan {
  int id;
  String url;
  DateTime date_scan;
  var result;

  Scan({this.id, this.url, this.date_scan, this.result});

  Scan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    date_scan = DateTime.parse(json['date_scan']);
    result = double.parse(json['result'].toString());
  }
}
