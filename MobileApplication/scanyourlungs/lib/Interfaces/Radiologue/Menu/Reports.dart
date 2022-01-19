import 'package:flutter/material.dart';
import 'package:scanyourlungs/Widgets/AppBarWidget.dart';
import 'package:scanyourlungs/Widgets/CustomRectTween.dart';
import 'package:scanyourlungs/Widgets/PopupWidget.dart';
import 'package:scanyourlungs/model/Report.dart';
import 'package:scanyourlungs/store/ReportStore.dart';
import 'package:scoped_model/scoped_model.dart';

class Reports extends StatefulWidget {
  final ReportStore reportStore;

  const Reports(this.reportStore);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  void initState() {
    super.initState();
    widget.reportStore.getAllReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: ScopedModelDescendant<ReportStore>(
        builder: (context, child, model) {
          if (model.reports.length == 0) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: model.reports.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(HeroDialogRoute(
                          builder: (BuildContext context) =>
                              _AddTodoPopupCard(index, model.reports[index])));
                    },
                    child: Hero(
                      tag: _heroAddTodo + index.toString(),
                      createRectTween: (Rect begin, Rect end) {
                        return CustomRectTween(begin: begin, end: end);
                      },
                      child: Material(
                        child: Dismissible(
                          key: Key(model.reports[index].id.toString()),
                          onDismissed: (direction) {
                            // model.deletePatient(model.patients[index].id);
                          },
                          child: ListTile(
                            title: Text(model.reports[index].patient.nom),
                            subtitle:
                                Text(model.reports[index].date.split("T")[0]),
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
  final Report report;
  const _AddTodoPopupCard(this.index, this.report);

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
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 200.0,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                child: new CircularProgressIndicator(
                                  strokeWidth: 15,
                                  value: report.scan.result,
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              ((report.scan.result * 100)).toStringAsFixed(2) +
                                  "%",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                      Text(
                        "Patient Name : ${report.patient.nom}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Date : ${report.date.split("T")[0]}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Result : ${report.scan.result}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description : ${report.description}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Scaned by : ${report.radiologue.first_name} ${report.radiologue.last_name}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
