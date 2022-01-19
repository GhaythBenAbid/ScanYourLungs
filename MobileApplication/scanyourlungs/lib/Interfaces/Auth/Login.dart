import 'package:flutter/material.dart';
import 'package:scanyourlungs/Interfaces/Auth/QrAuth.dart';
import 'package:scanyourlungs/Interfaces/Pulmonologist/Home/HomePage.dart';
import 'package:scanyourlungs/Interfaces/Radiologue/Home/HomePage.dart';
import 'package:scanyourlungs/store/AuthStore.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //declare variables
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: screenHeight * .08),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "images/LogoBlue.png",
                    height: screenHeight * .15,
                    alignment: Alignment.topLeft,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.qr_code_rounded,
                        color: Colors.blue,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/QrAuth");
                      },
                    ),
                  ),
                ],
              ),
              const Text(
                "Welcome,",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * .01),
              Text(
                "Sign in to continue!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black.withOpacity(.6),
                ),
              ),
              SizedBox(height: screenHeight * .12),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.6),
                  ),
                ),
                onChanged: (value) {
                  _email = value;
                },
              ),
              SizedBox(height: screenHeight * .02),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.6),
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: screenHeight * .075,
              ),
              ScopedModelDescendant<AuthStore>(
                builder: (context, child, model) {
                  return RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () async {
                      await model.login(_email, _password);

                      if (model.isLoggedIn) {
                        if (model.isLoggedIn &&
                            model.doctor.role == "Radiologue") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PulmonologistHomePage()));
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Invalid Credentials"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: Text(
                      "Sign In", //bold text
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
