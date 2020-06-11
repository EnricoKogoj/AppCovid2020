import 'dart:async';

import 'package:covid19_wt_drawer/api/worldApi.dart';
import 'package:covid19_wt_drawer/db/database.dart';
import 'package:covid19_wt_drawer/icons/custom_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'covidMenu.dart';
import '../globals.dart' as g;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key key}) : super(key: key);

  @override
  MainHomePageState createState() => MainHomePageState();
}

class MainHomePageState extends State<MainHomePage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    if (await canLaunch("https://www.google.com/")) {
      getWData();

      WidgetsFlutterBinding.ensureInitialized();
      final database = await $FloorAppDatabase
          .databaseBuilder('flutter_database.db')
          .build();
      g.daoo = database.savedCountryDao;
      g.savedCountryRaw = await g.daoo.findAllCountries();
      g.assign();

      var duration = new Duration(seconds: 4);
      return new Timer(duration, route);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Connection error!"),
            content: Text("Check you connection"),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CovidMenu()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 70.0, bottom: 20.0, right: 10, left: 10),
        child: Column(
          children: <Widget>[
            Spacer(),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
                      child: Text(
                        ' COVID ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'KARNIBLA',
                            fontSize: 63),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            Row(
              children: <Widget>[
                Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 2, 2),
                      child: Text(
                        ' 19 ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'KARNIBLA',
                          fontSize: 63,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            SizedBox(
              height: 272,
              child: Stack(
                children: <Widget>[
                  Icon(
                    CustomIcon
                        .iconfinder_virus_coronavirus_medical_bacterium_cell_6000203,
                    size: 250,
                    color: Colors.lime,
                  ),
                  Positioned(
                      bottom: 2,
                      right: 0,
                      child: Image.asset(
                        "images/virus_detection.png",
                        scale: 2,
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  ' - STATISTICS - ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: 'KARNIBLA',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              strokeWidth: 2,
            )),
            Container(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  void getWData() async {
    List<WorldData> dataList = await getWorldData();
    takeNames(dataList);
  }

  void takeNames(List<WorldData> dataList) {
    for (int i = 0; i < dataList.length; i++) {
      g.isFav[i] = false;
      var temp = dataList[i].country;
      g.countriesName.add(temp);
      Map<String, WorldData> tempMap = new Map();
      var cName = dataList[i].country;
      var wD = dataList[i];
      tempMap.putIfAbsent(cName, () => wD);
      g.nameList.add(cName);
      g.map[i] = tempMap;
      g.worldCases += dataList[i].cases.toInt();
      g.worldDeaths += dataList[i].deaths.toInt();
    }
    g.setCountryFromName();
  }
}
