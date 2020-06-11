import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:covid19_wt_drawer/api/worldApi.dart';
import 'package:covid19_wt_drawer/icons/custom_icon_icons.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as g;
import 'countryStats.dart';
import 'covidMenu.dart';

class SearchForCountry extends StatefulWidget {
  @override
  SearchForCountryState createState() => SearchForCountryState();
}

class SearchForCountryState extends State<SearchForCountry>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  String countryId;
  List<String> country = g.nameList;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
      appBar: g.myAppBar(scaffoldKey),
      drawer: g.myDrawer(),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
            child: Text(
              "SEARCH",
              style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                            fontFamily: 'KARNIBLA'),
              textAlign: TextAlign.center,
            ),
          ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: SizedBox(
                            height: _animation.value,
                            child: Icon(
                              CustomIcon.iconfinder_location_3126609,
                              size: 200,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                            child: SimpleAutoCompleteTextField(
                              key: key,
                              decoration: new InputDecoration(
                                  errorText: "Insert Country"),
                              controller: TextEditingController(),
                              focusNode: _focusNode,
                              onFocusChanged: (value) => countryId,
                              submitOnSuggestionTap: true,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.none,
                              suggestionsAmount: 10,
                              suggestions: country,
                              textChanged: (text) => countryId = text,
                              clearOnSubmit: true,
                              textSubmitted: (text) => setState(() {
                                if (text != "") {
                                  String s = text;
                                  if (g.nameList.contains(s)) {
                                    int index = g.nameList.indexOf(s);
                                    WorldData countr = g.map.values
                                        .elementAt(index)
                                        .values
                                        .first;
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              (CountryStats(countr, true)),
                                        ));
                                  }
                                }
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Spacer(),
              back(context),
              SizedBox(
                height: 20,
              ),
            ]),
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
}