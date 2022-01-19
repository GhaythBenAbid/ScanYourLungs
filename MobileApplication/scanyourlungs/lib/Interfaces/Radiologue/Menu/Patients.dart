import 'package:flutter/material.dart';
import 'package:scanyourlungs/Widgets/AppBarWidget.dart';
import 'package:scanyourlungs/Widgets/CustomRectTween.dart';
import 'package:scanyourlungs/Widgets/PopupWidget.dart';
import 'package:scanyourlungs/model/Patient.dart';
import 'package:scanyourlungs/store/PatientStore.dart';
import 'package:scanyourlungs/store/ReportStore.dart';
import 'package:scanyourlungs/store/ScanStore.dart';
import 'package:scoped_model/scoped_model.dart';

class Patients extends StatefulWidget {
  final PatientStore model;

  const Patients(this.model);
  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  PatientStore patientStore = new PatientStore();
  void initState() {
    super.initState();
    widget.model.getAllPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: ScopedModelDescendant<PatientStore>(
        builder: (context, child, model) {
          if (model.patients.length == 0) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: model.patients.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(HeroDialogRoute(
                          builder: (BuildContext context) =>
                              _AddTodoPopupCard(index, model.patients[index])));
                    },
                    child: Hero(
                      tag: _heroAddTodo + index.toString(),
                      createRectTween: (Rect begin, Rect end) {
                        return CustomRectTween(begin: begin, end: end);
                      },
                      child: Material(
                        child: Dismissible(
                          key: Key(model.patients[index].id.toString()),
                          onDismissed: (direction) {
                            model.deletePatient(model.patients[index].id);
                          },
                          child: ListTile(
                            title: Text(model.patients[index].nom),
                            subtitle: Text(model.patients[index].email),
                          ),
                          background: Container(
                              color: Colors.blue,
                              child: Icon(Icons.delete, color: Colors.white)),
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

const String _heroAddTodo = 'add-todo-hero';

class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  final int index;
  final Patient patient;
  const _AddTodoPopupCard(this.index, this.patient);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
            tag: _heroAddTodo + index.toString(),
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin, end: end);
            },
            child: Material(
              child: ListTile(
                title: Text(patient.nom),
                subtitle: Text(patient.email),
              ),
            )),
      ),
    );
  }
}
