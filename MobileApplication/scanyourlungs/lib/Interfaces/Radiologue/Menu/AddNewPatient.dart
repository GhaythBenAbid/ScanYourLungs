import 'package:flutter/material.dart';
import 'package:scanyourlungs/Widgets/AppBarWidget.dart';
import 'package:scanyourlungs/store/PatientStore.dart';
import 'package:scoped_model/scoped_model.dart';

class AddNewPatient extends StatefulWidget {
  const AddNewPatient({Key key}) : super(key: key);

  @override
  _AddNewPatientState createState() => _AddNewPatientState();
}

class _AddNewPatientState extends State<AddNewPatient> {
  //declare the text controllers
  String _patientName;
  String _patientEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                'Add New Patient',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Patient Name',
              ),
              onChanged: (value) {
                _patientName = value;
              },
            ),
            SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Patient Email',
              ),
              onChanged: (value) {
                _patientEmail = value;
              },
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ScopedModelDescendant<PatientStore>(
                  builder: (context, child, model) => RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        // print('$_patientName $_patientEmail');
                        model.addNewPatient(_patientName, _patientEmail);
                        model.getAllPatients();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text(
                              'Patient Added',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'submit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                RaisedButton(
                    onPressed: () {
                      _patientName = '';
                      _patientEmail = '';
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
