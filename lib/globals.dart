import 'package:covid19_wt_drawer/pages/SearchForCountry.dart';
import 'package:covid19_wt_drawer/pages/countryList.dart';
import 'package:covid19_wt_drawer/pages/listSavedCountry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/components/button/gf_icon_button.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:link/link.dart';
import 'api/worldApi.dart';
import 'db/favourite.dart';
import 'icons/custom_icon_icons.dart';

List<List<String>> list;
List<List<String>> filtredList;
String selectedCountry;
List<SavedCountry> savedCountryRaw;
Set<String> savedCountry = {};
TextEditingController textController = TextEditingController();
var daoo;
Map<String, WorldData> countryFromName = new Map();
BuildContext menuContext;
List countriesName = new List();
Map<int, Map<String, WorldData>> map = new Map();
List<String> nameList = new List();
var worldDeaths = 0;
var worldCases = 0;
double w;
int pos = 0;
List<bool> isFav = new List(215);

void assign() {
  savedCountry = {};
  savedCountryRaw.forEach((x) {
    savedCountry.add(x.country);
  });
}

Widget worldCard() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                colors: <Color>[Colors.black, Colors.grey[600]],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  color: Colors.grey[800]),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Container()),
                  Column(
                    children: <Widget>[
                      Text(
                        "TODAY",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: 'COLLEGES'),
                      ),
                      Text(
                        "WORLD STATS",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 48,
                            fontFamily: 'COLLEGES'),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.local_hospital,
                            color: Colors.white,
                          ),
                          Container(
                            width: 5,
                          ),
                          Text(
                            "CASES: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Aller_Bd',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${worldCases.toString()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Aller_Bd',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.white,
                          ),
                          Container(
                            width: 5,
                          ),
                          Text(
                            "DEATHS: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Aller_Bd',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        worldDeaths.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Aller_Bd',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ));
  }

Widget myMenuBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Spacer(),
          Icon(
            CustomIcon.iconfinder_world7_216380,
            size: 300,
            color: Colors.blueAccent,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: worldCard(),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget myAppBar(GlobalKey<ScaffoldState> s) {
    return GradientAppBar(
      backgroundColorEnd: Colors.grey[600],
      backgroundColorStart: Colors.black,
      leading: GFIconButton(
        icon: Container(
          child: Icon(
            Icons.menu,
            size: 45,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          s.currentState.openDrawer();
        },
        type: GFButtonType.transparent,
      ),
      title: Row(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.white)),
              ),
              child: SizedBox(
                height: 40,
                width: 25,
              )),
          Text("Covid - 19",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'KARNIBLA',
              )),
        ],
      ),
    );
  }

Widget myDrawer() {
    return Container(
      width: 250,
      child: Drawer(
        elevation: 10,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: 150,
                    child: DrawerHeader(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'MENU',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'KARNIBLA',
                            ),
                          ),
                          Expanded(child: Container()),
                          GFIconButton(
                            alignment: Alignment.centerRight,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {},
                            type: GFButtonType.transparent,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[Colors.black, Colors.grey[600]],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 8,
                        ),
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(menuContext);
                        Navigator.push(
                            menuContext,
                            MaterialPageRoute(
                              builder: (menuContext) => (CountryList()),
                            ));
                      },
                      child: Card(
                        elevation: 5,
                        color: Colors.black.withOpacity(.1),
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                              child: Text(
                                'Country List',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Komika_Hand',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(menuContext);
                        Navigator.push(
                            menuContext,
                            MaterialPageRoute(
                              builder: (context) => (SearchForCountry()),
                            ));
                      },
                      child: Card(
                        elevation: 5,
                        color: Colors.black.withOpacity(.1),
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                              child: Text(
                                'Search for country',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Komika_Hand',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(menuContext);
                        Navigator.push(
                            menuContext,
                            MaterialPageRoute(
                              builder: (context) => (ListSavedCountry()),
                            ));
                      },
                      child: Card(
                        elevation: 5,
                        color: Colors.black.withOpacity(.1),
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                              child: Text(
                                'Favourites',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Komika_Hand',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            exit();
                          },
                          child: ListTile(
                              leading: Icon(Icons.exit_to_app),
                              title: Text('Exit')),
                        ),
                        GestureDetector(
                          onTap: () {
                            info();
                          },
                          child: ListTile(
                              leading: Icon(Icons.info), title: Text('Info')),
                        )
                      ],
                    ))))
          ],
        ),
      ),
    );
  }

  void exit() {
    showDialog(
      context: menuContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Text(
                "Confirm Exit",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              Spacer(),
              Icon(
                Icons.info,
                size: 40,
              ),
            ],
          ),
          content: Text("Are you sure you want to exit?"),
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Exit"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void info() {
    showDialog(
      context: menuContext,
      builder: (BuildContext context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets +
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 220.0),
          duration: Duration(seconds: 5),
          child: MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 280.0),
              child: Material(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Covid19 statistics",
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(
                                  "info",
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Icon(
                            Icons.info,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    1,
                                    1,
                                    1,
                                    1,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Version:",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        " 1.2.2",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    1,
                                    1,
                                    1,
                                    1,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Questa app manipula le api del covid:",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Link(
                                      child: Text(
                                        'https://corona.lmao.ninja/v2/countries/',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.blueAccent),
                                      ),
                                      url:
                                          'https://corona.lmao.ninja/v2/countries/',
                                      onError: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Connection error!"),
                                              content:
                                                  Text("Check you connection"),
                                              actions: [
                                                Container(
                                                  child: FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      SystemNavigator.pop();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              FlatButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

void setCountryFromName() {
  map.forEach((key, value) {
    if (key != null && value != null) {
      String keys = value.keys.toString();
      WorldData values = value.values.first;
      countryFromName.putIfAbsent(keys, () => values);
    }
  });
}

WorldData getCountryFromName(String g) {
  return countryFromName.values.firstWhere((element) => element.country == g);
}
