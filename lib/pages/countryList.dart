import 'package:covid19_wt_drawer/api/worldApi.dart';
import 'package:covid19_wt_drawer/db/favourite.dart';
import 'package:covid19_wt_drawer/icons/custom_icon_icons.dart';
import '../globals.dart' as g;
import 'covidMenu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'countryStats.dart';

MyHomePageState cavalloCountryList;

class CountryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  MyHomePageState createState() => cavalloCountryList = MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: g.myAppBar(scaffoldKey),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "COUNTRIES",
              style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            fontFamily: 'KARNIBLA'),
              textAlign: TextAlign.center,
            ),
          ),
          myListBody(),
        ],
      ),
      drawer: g.myDrawer(),
    );
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  myListBody() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: g.map.length,
              itemBuilder: (context, index) {
                var country = g.map[index].values.elementAt(0);
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CountryStats(country)));
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 2.5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: <Color>[Colors.white, Colors.white10],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 20,
                                      color: Colors.black.withOpacity(.5)),
                                ]),
                            child: cardOfList(country),
                          ),
                          Container(
                            height: 2.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
      ),
    );
  }

  cardOfList(var country) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              GestureDetector(
                onDoubleTap: () => {addFav(country)},
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 100.0,
                  ),
                  child: Stack(
                    children: <Widget>[
                      flagFuture(country),
                      Center(
                        child: Icon(
                          Icons.star,
                          color: Colors.white54,
                          size: 70,
                        ),
                      ),
                      (g.isFav[g.countriesName.indexOf(country.country)])
                          ? Center(
                              child: Icon(
                                Icons.star,
                                color: Colors.yellowAccent.withOpacity(0.8),
                                size: 70,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 235,
                      ),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          controller: ScrollController(
                            initialScrollOffset: 1000,
                            keepScrollOffset: true,
                          ),
                          scrollDirection: Axis.horizontal,
                          dragStartBehavior: DragStartBehavior.start,
                          reverse: true,
                          child: Container(
                              child: Text(
                            country.country,
                            style:
                                TextStyle(fontFamily: 'Aller_Bd', fontSize: 33),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    CustomIcon.iconfinder_scull_461379,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text(
                                    country.deaths.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            )),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black12,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.local_hospital,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Text(
                                          country.cases.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget back(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (CovidMenu()),
            ));
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

  flagFuture(WorldData country) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Container(
              child: CircularProgressIndicator(
            backgroundColor: Colors.black,
            strokeWidth: 2,
          ));
        }
        return Container(child: Image.network(country.countryInfo.flag));
      },
    );
  }

  addFav(WorldData country) async {
    if (g.isFav[g.countriesName.indexOf(country.country)]) {
      g.isFav[g.countriesName.indexOf(country.country)] = false;
      g.daoo.deleteCountry(
          g.savedCountryRaw.firstWhere((x) => x.country == country.country));
      g.savedCountryRaw = await g.daoo.findAllCountries();
      g.assign();
    } else if (!g.isFav[g.countriesName.indexOf(country.country)]) {
      g.isFav[g.countriesName.indexOf(country.country)] = true;
      g.daoo.insertCountry(SavedCountry(null, country.country));
      g.savedCountryRaw = await g.daoo.findAllCountries();
      g.assign();
    }
    setState(() {});
  }
}