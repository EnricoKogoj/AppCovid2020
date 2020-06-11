import 'package:covid19_wt_drawer/icons/custom_icon_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'countryStats.dart';
import '../globals.dart' as g;
import 'covidMenu.dart';

class ListSavedCountry extends StatefulWidget {
  ListSavedCountry();
  @override
  ListSavedCountryState createState() => ListSavedCountryState();
}

class ListSavedCountryState extends State<ListSavedCountry> {
  void initState() {
    g.assign();
    super.initState();
  }

  Future<Widget> _flag(String country) async {
    var temp = g.getCountryFromName(country);
    return Container(
      height: 30,
      width: 100,
      child: Image.network(temp.countryInfo.flag),
    );
  }

  Future<Widget> saved(String country) async {
    return Container(
      width: 50,
      child: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          g.daoo.deleteCountry(
              g.savedCountryRaw.firstWhere((x) => x.country == country));
          g.savedCountryRaw = await g.daoo.findAllCountries();
          g.assign();
          g.isFav[g.countriesName.indexOf(country)] = false;
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: g.myAppBar(scaffoldKey),
      drawer: g.myDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "FAVOURITES",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'KARNIBLA'),
              textAlign: TextAlign.center,
            ),
          ),
          (g.savedCountry.isEmpty)
              ? Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Container(
                        child: Text(
                          "There aren't favorites yet.",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Expanded(
                  child: Stack(
                    children: <Widget>[
                      ListView.builder(
                        itemCount: g.savedCountry.length,
                        itemBuilder: (context, index) => Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (CountryStats(
                                          g.getCountryFromName(
                                              g.savedCountry.toList()[index]),
                                          false,
                                          true)),
                                    ));
                              },
                              child: Container(
                                  width: 340,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Colors.white,
                                          Colors.white10
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 20,
                                            color:
                                                Colors.black.withOpacity(.5)),
                                      ]),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          FutureBuilder(
                                              future: _flag(g.savedCountry
                                                  .toList()[index]),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  return Container(
                                                    child: snapshot.data,
                                                    width: 50,
                                                  );
                                                } else
                                                  return Container();
                                              }),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: 200,
                                            ),
                                            child: Scrollbar(
                                              child: SingleChildScrollView(
                                                controller: ScrollController(
                                                  initialScrollOffset: 1000,
                                                  keepScrollOffset: true,
                                                ),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                dragStartBehavior:
                                                    DragStartBehavior.start,
                                                reverse: true,
                                                child: Container(
                                                    child: Text(
                                                  g.savedCountry
                                                      .toList()[index],
                                                  style: TextStyle(
                                                      fontFamily: 'Aller_Bd',
                                                      fontSize: 33),
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                            ),
                                          ),
                                          FutureBuilder(
                                              future: saved(g.savedCountry
                                                  .toList()[index]),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  return Container(
                                                      child: snapshot.data);
                                                } else
                                                  return Container();
                                              }),
                                        ],
                                      ))),
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
                ),
        ],
      ),
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

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
}
