import 'package:covid19_wt_drawer/icons/custom_icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getflutter/getflutter.dart';
import 'package:getflutter/types/gf_button_type.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:link/link.dart';
import '../globals.dart' as g;
import 'SearchForCountry.dart';
import 'countryList.dart';
import 'listSavedCountry.dart';

MyHomePageState cavalloMenu;

class CovidMenu extends StatelessWidget {
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
  MyHomePageState createState() => cavalloMenu = MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    g.menuContext = context;
    setState(() {});
    return Scaffold(
      key: scaffoldKey,
      appBar: g.myAppBar(scaffoldKey),
      body: g.myMenuBody(),
      drawer: g.myDrawer(),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
}
