import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:scanyourlungs/model/Doctor.dart';
import 'package:scanyourlungs/store/Config.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class AuthStore extends Model {
  String _path = Config.localhost;
  LocalStorage _storage = new LocalStorage('scanyourlungs');
  Doctor _doctor;
  bool _isLoggedIn = false;
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  changeTheme() {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }

  // getters
  Doctor get doctor {
    return Doctor.fromJson(_storage.getItem("doctor"));
  }

  bool get isLoggedIn => _isLoggedIn;

  //login fetch from api using http /login
  login(String email, String password) async {
    var body = json.encode({
      'email': email,
      'password': password,
    });

    final response = await http.post(Uri.parse('${_path}/auth/login'),
        body: body, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body)['user'];
      await _storage.setItem("doctor", responseJson);

      var token = json.decode(response.body)['token'];
      Config.token = token;

      _isLoggedIn = true;
      notifyListeners();
    } else {
      _isLoggedIn = false;
      notifyListeners();
    }
  }

  //update
  update(firstName, lastName, email, signature) async {
    final body = json.encode({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'signature': signature,
    });

    final response = await http.put(
        Uri.parse('http://10.0.2.2:3000/auth/${doctor.id}'),
        body: body,
        headers: {"Content-Type": "application/json"});

    print(response.body);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      var doctor = Doctor.fromJson(responseJson);
      await _storage.setItem("doctor", Doctor.fromJson(responseJson));
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  //logout
  logout() async {
    await _storage.clear();
    _isLoggedIn = false;
    Config.token = "";
    print("looogoooout");
    notifyListeners();
  }
}
