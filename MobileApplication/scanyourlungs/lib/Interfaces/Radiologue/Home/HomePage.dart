import 'package:flutter/material.dart';
import 'package:scanyourlungs/Widgets/AppBarWidget.dart';
import 'package:scanyourlungs/store/AuthStore.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: <Widget>[
              ScopedModelDescendant<AuthStore>(
                builder: (context, child, model) => FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    model.logout();
                    Navigator.of(context).pushNamed("/Login");
                  },
                ),
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Text(
                //center text
                "Welcome Back, ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ScopedModelDescendant<AuthStore>(
                  builder: (context, child, model) {
                if (model.doctor == null) return CircularProgressIndicator();
                return Text(
                  "Dr . ${model.doctor.first_name} ${model.doctor.last_name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                );
              }),
              Text(
                "RadioLogue",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              MenuCards(
                image: //image of doctors from the internet
                    'https://images.pexels.com/photos/7088530/pexels-photo-7088530.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                title: 'Add New Patient',
                route: '/AddNewPatient',
              ),
              MenuCards(
                image: //image of doctors from the internet
                    'https://images.pexels.com/photos/3985163/pexels-photo-3985163.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                title: 'List of Patients',
                route: '/Patients',
              ),
              MenuCards(
                image:
                    "https://images.pexels.com/photos/590016/pexels-photo-590016.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                title: 'Reports',
                route: '/Reports',
              ),
              MenuCards(
                image:
                    "https://images.pexels.com/photos/4021779/pexels-photo-4021779.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                title: 'Settings',
                route: '/Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCards extends StatelessWidget {
  const MenuCards({
    this.image,
    this.title,
    this.route,
    Key key,
  }) : super(key: key);

  final String image;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Stack(children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(9.6),
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            ),
            height: 200.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.6),
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black,
                    ],
                    stops: [
                      0.0,
                      1.0
                    ])),
          )
        ]),
      ),
    );
  }
}
