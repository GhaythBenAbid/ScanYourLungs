import 'package:flutter/material.dart';
import 'package:scanyourlungs/Widgets/AppBarWidget.dart';
import 'package:scanyourlungs/store/AuthStore.dart';
import 'package:scanyourlungs/store/PatientStore.dart';
import 'package:scoped_model/scoped_model.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScopedModelDescendant<AuthStore>(
            builder: (context, child, model) => ListView(
              children: [
                AccountManagement(model, context),
                Security(model),
                ThemeMangement(model),
              ],
            ),
          ),
        ));
  }

  AccountManagement(model, context) {
    String _firstName;
    String _lastName;
    String _email;
    String _signature;

    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Account Management",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          TextFormField(
            initialValue: model.doctor.first_name,
            decoration: InputDecoration(
              labelText: "First Name",
              hintText: "First Name",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _firstName = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: model.doctor.last_name,
            decoration: InputDecoration(
              labelText: "Last Name",
              hintText: "Last Name",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _lastName = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: model.doctor.email,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Email",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _email = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: model.doctor.signature,
            decoration: InputDecoration(
              labelText: "Signature",
              hintText: "Signature",
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _signature = value;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue: model.doctor.role,
            enabled: false,
            decoration: InputDecoration(
              labelText: "Role",
              hintText: "Role",
              border: OutlineInputBorder(),
            ),
          ),
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text("Submit"),
            onPressed: () async {
              bool updated =
                  await model.update(_firstName, _lastName, _email, _signature);
              print(updated);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: updated ? Colors.blue : Colors.red,
                  content: Text(
                    updated ? 'The Account Updated Successfully' : 'Error',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Security(model) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Security",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Old Password",
              hintText: "Old Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "New Password",
              hintText: "New Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Confirm Password",
              hintText: "Confirm Password",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  ThemeMangement(model) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Theme",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          SwitchListTile(
              title: Text(
                model.darkTheme ? "Dark Mode" : "Light Mode",
              ),
              value: model.darkTheme,
              onChanged: (value) {
                model.changeTheme();
              }),
        ],
      ),
    );
  }
}
