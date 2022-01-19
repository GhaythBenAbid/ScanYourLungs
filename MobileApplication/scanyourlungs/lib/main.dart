import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scanyourlungs/Interfaces/Auth/Login.dart';
import 'package:scanyourlungs/Interfaces/Auth/QrAuth.dart';
import 'package:scanyourlungs/Interfaces/Pulmonologist/Home/HomePage.dart';
import 'package:scanyourlungs/Interfaces/Pulmonologist/menu/AddNewAppointment.dart';
import 'package:scanyourlungs/Interfaces/Pulmonologist/menu/Calender.dart';
import 'package:scanyourlungs/Interfaces/Radiologue/Home/HomePage.dart';
import 'package:scanyourlungs/Interfaces/Radiologue/Menu/AddNewPatient.dart';
import 'package:scanyourlungs/Interfaces/Radiologue/Menu/Patients.dart';
import 'package:scanyourlungs/Interfaces/Radiologue/Menu/Reports.dart';
import 'package:scanyourlungs/Interfaces/Radiologue/Menu/Settings.dart';
import 'package:scanyourlungs/model/Appointment.dart';
import 'package:scanyourlungs/store/AppointmentStore.dart';
import 'package:scanyourlungs/store/AuthStore.dart';
import 'package:scanyourlungs/store/PatientStore.dart';
import 'package:scanyourlungs/store/ReportStore.dart';
import 'package:scanyourlungs/store/ScanStore.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AuthStore authStore = AuthStore();
    final PatientStore patientStore = PatientStore();
    final ScanStore scanStore = ScanStore();
    final ReportStore reportStore = ReportStore();
    final AppointmentStore appoitmentStore = AppointmentStore();

    return ScopedModel<AppointmentStore>(
      model: appoitmentStore,
      child: ScopedModel<ReportStore>(
        model: reportStore,
        child: ScopedModel<ScanStore>(
          model: scanStore,
          child: ScopedModel<AuthStore>(
            model: authStore,
            child: ScopedModel<PatientStore>(
              model: patientStore,
              child: ScopedModelDescendant<AuthStore>(
                builder: (context, child, model) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    brightness: Brightness.light,
                    appBarTheme: AppBarTheme(
                      color: Colors.white,
                      elevation: 10,
                    ),
                  ),
                  darkTheme: ThemeData(
                    fontFamily: GoogleFonts.lato().fontFamily,
                    brightness: Brightness.dark,
                  ),
                  themeMode: model.darkTheme ? ThemeMode.dark : ThemeMode.light,
                  home: const Login(),
                  routes: {
                    '/Login': (context) => Login(),
                    '/RadioLogueHome': (context) => HomePage(),
                    '/AddNewPatient': (context) => AddNewPatient(),
                    '/Patients': (context) => Patients(patientStore),
                    '/Settings': (context) => Settings(),
                    '/Reports': (context) => Reports(reportStore),
                    '/QrAuth': (context) => QrAuth(authStore),
                    '/PulmonologistHome': (context) => PulmonologistHomePage(),
                    '/Calender': (context) => Calender(appoitmentStore),
                    '/AddNewAppointment': (context) =>
                        AddNewAppointment(patientStore, authStore),
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
