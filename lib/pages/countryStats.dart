import 'package:covid19_wt_drawer/api/worldApi.dart';
import 'package:covid19_wt_drawer/icons/custom_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SearchForCountry.dart';
import 'countryList.dart';
import 'covidMenu.dart';
import 'listSavedCountry.dart';
import '../globals.dart' as g;

class CountryStats extends StatelessWidget {
  CountryStats(this.country, [this.isR = false, this.isF = false]);

  final WorldData country;
  bool isR;
  
  bool isF;
  var name;
  var active;
  var cases;
  var casesPerOneMillion;
  var continent;
  var flag;
  var lat;
  var long;
  var iId;
  var iso2;
  var iso3;
  var critical;
  var deaths;
  var deathsPerOneMillion;
  var recovered;
  var tests;
  var testsPerOneMillion;
  var todayCases;
  var todayDeaths;
  var updated;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        appBar: g.myAppBar(scaffoldKey),
        body: myCountryBody(context),
        drawer: g.myDrawer(),
      ),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget myCountryBody(BuildContext context) {
    setVariables();
    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView(
              children: <Widget>[
                /**/
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    fontFamily: 'COLLEGES',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => lauchMap(),
                  child: Tooltip(
                      waitDuration: Duration(seconds: 1),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.rectangle),
                      verticalOffset: 5,
                      message:
                          "${country.countryInfo.flag} \n lat: $lat    long: $long \n iId: $iId    is02: $iso2    iso3: $iso3",
                      child: Stack(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Spacer(),
                              Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 15, 5, 5),
                                  child: cavalloCountryList.flagFuture(country),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Container(
                            child: continetUI(country.continent),
                          ),
                          Container(
                            child: favUI(),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 5),
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                stat(
                                    "CASES",
                                    Icon(
                                      Icons.local_hospital,
                                    ),
                                    cases),
                                SizedBox(
                                  height: 10,
                                ),
                                stat(
                                    "CRITICAL",
                                    Icon(CustomIcon.iconfinder_alert_298718),
                                    critical),
                                SizedBox(
                                  height: 10,
                                ),
                                stat(
                                    "DEATHS",
                                    Icon(CustomIcon.iconfinder_scull_461379),
                                    deaths),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                stat(
                                    "ACTIVE",
                                    Icon(CustomIcon
                                        .iconfinder_icon_ios7_bolt_211696),
                                    active),
                                SizedBox(
                                  height: 10,
                                ),
                                stat("RECOVERED", Icon(Icons.thumb_up),
                                    recovered),
                                SizedBox(
                                  height: 10,
                                ),
                                stat(
                                    "TESTS",
                                    Icon(CustomIcon
                                        .iconfinder_checkcircle_1031542),
                                    tests),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  back(context),
                  SizedBox(
                    height: 20,
                  )
                ],
              )),
        ],
      ),
    );
  }

  void setVariables() {
    name = country.country.toString();
    active = country.active.toString();
    cases = country.cases.toString();
    casesPerOneMillion = country.casesPerOneMillion.toString();
    continent = country.continent.toString();
    lat = country.countryInfo.lat.toString();
    long = country.countryInfo.long.toString();
    iId = country.countryInfo.iId.toString();
    iso2 = country.countryInfo.iso2.toString();
    iso3 = country.countryInfo.iso3.toString();
    critical = country.critical.toString();
    deaths = country.deaths.toString();
    deathsPerOneMillion = country.deathsPerOneMillion.toString();
    recovered = country.recovered.toString();
    tests = country.tests.toString();
    testsPerOneMillion = country.testsPerOneMillion.toString();
    todayCases = country.todayCases.toString();
    todayDeaths = country.todayDeaths.toString();
    updated = country.updated.toString();
  }

  lauchMap() async {
    var url = "https://www.google.it/maps/place/" + lat + "," + long;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Connection error for the url: $url!";
    }
  }

  stat(String n, Icon icon, String s) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              colors: <Color>[Colors.white, Colors.white10],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0), blurRadius: 0, color: Colors.grey[400]),
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 8, 2, 8),
        child: Column(
          children: <Widget>[
            Text(
              n,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: icon,
                  width: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(s),
                  width: 50,
                ),
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  continetUI(String n) {
    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
          onTap: () => lauchSite(continent),
          child: Tooltip(
            message: continent,
            child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    "images/" + n + ".png",
                    height: 50,
                  ),
                )),
          )),
    );
  }

  favUI() {
    return Positioned(
        bottom: 0,
        left: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white70, border: Border.all()),
                  child: (g.isFav[g.countriesName.indexOf(country.country)])?Icon(
                    Icons.star,
                    color: Colors.yellowAccent,
                    size: 45,
                  )
                  :
                  Icon(
                    Icons.star_border,
                    color: Colors.black38,
                    size: 45,
                  )
                  ),
            ));
  }

  lauchSite(String a) async {
    var continente;
    if (a == "Europe")
      continente = "europa";
    else if (a == "Asia")
      continente = "asia";
    else if (a == "North America")
      continente = "nordamerica";
    else if (a == "South America")
      continente = "americalatina";
    else if (a == "Australia")
      continente = "oceania";
    else if (a == "Africa") continente = "africa";
    var url = "https://www.ansa.it/sito/notizie/mondo/" +
        continente +
        "/" +
        continente +
        ".shtml";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Connection error for the url: $url!";
    }
  }

  Widget back(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isR) {
          Navigator.pop(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (SearchForCountry()),
              ));
        } 
        else if(isF){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (ListSavedCountry()),
              ));
        }        
        else {
          Navigator.pop(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (CountryList()),
              ));
        }
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
                colors: <Color>[Colors.black, Colors.grey[800]],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 10,
                  color: Colors.grey[400]),
            ]),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          colors: <Color>[Colors.black, Colors.grey[800]],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 10,
                            color: Colors.grey[400]),
                      ]),
                ),
                Icon(
                  CustomIcon.left_dir,
                  color: Colors.white,
                  size: 50,
                )
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              "BACK",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'KARNIBLA',
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
