import 'package:flutter/material.dart';
import 'package:scanyourlungs/Widgets/AppBarWidget.dart';
import 'package:scanyourlungs/model/Doctor.dart';
import 'package:scanyourlungs/model/Patient.dart';
import 'package:scanyourlungs/store/AppointmentStore.dart';
import 'package:scanyourlungs/store/AuthStore.dart';
import 'package:scanyourlungs/store/PatientStore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:smart_select/smart_select.dart';

class AddNewAppointment extends StatefulWidget {
  final PatientStore patientStore;
  final AuthStore authStore;

  AddNewAppointment(this.patientStore, this.authStore);

  @override
  _AddNewAppointmentState createState() => _AddNewAppointmentState();
}

class _AddNewAppointmentState extends State<AddNewAppointment> {
  Doctor _doctor;
  DateTime _appointmentDate = new DateTime.now();
  int value;
  List<S2Choice<int>> options;

  @override
  void initState() {
    _doctor = widget.authStore.doctor;
    print("IDDDD :  ${_doctor.id}");
    widget.patientStore.getAllPatients();

    var patients = widget.patientStore.patients;
    setState(() {
      for (var patient in patients) {
        if (options != null) {
          options.add(S2Choice<int>(value: patient.id, title: patient.nom));
        } else {
          options = [S2Choice<int>(value: patient.id, title: patient.nom)];
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SmartSelect.single(
              title: 'Patients',
              value: value,
              choiceItems: options,
              onChange: (state) => setState(() => value = state.value)),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Patient Name',
            ),
            readOnly: true,
            controller: TextEditingController()
              ..text = _appointmentDate.toString().split(" ")[0],
            onTap: () async {
              final DateTime appointment_date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2024, 1, 1));

              setState(() {
                _appointmentDate = appointment_date;
                print(_appointmentDate);
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          ScopedModelDescendant<AppointmentStore>(
            builder: (context, child, model) => RaisedButton(
                child: Text(
                  'Add Appointment',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
                onPressed: () async {
                  await model.addNewAppointment(value, _doctor.id,
                      _appointmentDate.toString().split(" ")[0]);
                }),
          ),
        ],
      ),
    );
  }
}
