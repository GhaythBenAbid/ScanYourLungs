import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scanyourlungs/Widgets/AppBarWidget.dart';
import 'package:scanyourlungs/store/AuthStore.dart';

class QrAuth extends StatefulWidget {
  final AuthStore authStore;

  const QrAuth(this.authStore);

  @override
  _QrAuthState createState() => _QrAuthState();
}

class _QrAuthState extends State<QrAuth> {
  String _scanBarcode = 'Unknown';
  bool Authenticated = null;

  var _doctor;

  @override
  void initState() {
    super.initState();

    scanQR();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    _doctor = json.decode(_scanBarcode);
    print(_doctor["email"]);
    AuthStore authStore = new AuthStore();
    await widget.authStore.login(_doctor["email"], _doctor["password"]);

    bool authenticated = widget.authStore.isLoggedIn;
    setState(() {
      Authenticated = authenticated;
    });

    if (authenticated) {
      Navigator.pushReplacementNamed(context, '/Home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Please check Settings > QrCode Page for the QR code',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Scan'),
                onPressed: () {
                  setState(() {
                    Authenticated = null;
                  });
                  scanQR();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Authenticated == null
                  ? CircularProgressIndicator()
                  : Authenticated
                      ? Text('wait a second to be redirected')
                      : Text('Please check your credentials and try again'),
            ],
          ),
        ),
      ),
    );
  }
}
