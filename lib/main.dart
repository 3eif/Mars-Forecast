import 'dart:async';
import 'package:flutter/material.dart';

import './services/parseWeather.dart';
import './services/convertWeather.dart';
import './structures/Weather.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<Weather>> forecast;
  bool celsius = true;

  @override
  void initState() {
    super.initState();
    forecast = parseWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<List>(
            future: forecast,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                          child: Card(
                            color: Color.fromRGBO(40, 40, 43, 0.3),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: ListTile(
                                    title: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                'Sol ${snapshot.data[0].sol}\n',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 27.5),
                                          ),
                                          TextSpan(
                                            text: '${snapshot.data[0].date}\n',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          TextSpan(
                                            text: '${snapshot.data[0].season}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '\n\n${celsius ? snapshot.data[0].temperature['av'].round() : convertWeather(snapshot.data[0].temperature['av'])} ${celsius ? '°C' : '°F'}\n',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 55,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey[100]),
                                        children: [
                                          WidgetSpan(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              child: Icon(
                                                Icons.arrow_upward,
                                                color: Colors.grey[100],
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${celsius ? snapshot.data[0].temperature['mx'].round() : convertWeather(snapshot.data[0].temperature['mx'])} ${celsius ? '°C' : '°F'}',
                                          ),
                                          WidgetSpan(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 2.0),
                                              child: Icon(
                                                Icons.arrow_downward,
                                                color: Colors.grey[100],
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${celsius ? snapshot.data[0].temperature['mn'].round() : convertWeather(snapshot.data[0].temperature['mn'])} ${celsius ? '°C' : '°F'}',
                                          ),
                                          TextSpan(
                                            text:
                                                '\n${snapshot.data[0].windDirection} ${snapshot.data[0].windSpeed['av'].round()} mph\n${snapshot.data[0].pressure['av'].round()} Pa',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: new ButtonBar(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ButtonTheme(
                                        minWidth: 10,
                                        height: 20,
                                        child: new RaisedButton(
                                          color: celsius
                                              ? Colors.black
                                              : Colors.black26,
                                          child: new Text(
                                            '°C',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: celsius
                                                  ? FontWeight.bold
                                                  : FontWeight.w300,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              celsius = true;
                                            });
                                          },
                                        ),
                                      ),
                                      ButtonTheme(
                                        minWidth: 10,
                                        height: 20,
                                        child: new RaisedButton(
                                          color: !celsius
                                              ? Colors.black
                                              : Colors.black26,
                                          child: new Text(
                                            '°F',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: !celsius
                                                  ? FontWeight.bold
                                                  : FontWeight.w300,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              celsius = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data == null
                                ? 0
                                : snapshot.data.length - 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 4.0),
                                child: Card(
                                  color: Color.fromRGBO(240, 240, 240, 0.1),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 10.0,
                                            bottom: 10.0),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    'Sol ${snapshot.data[index + 1].sol}\n',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19,
                                                ),
                                              ),
                                              TextSpan(
                                                text: snapshot
                                                    .data[index + 1].date,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.5,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${celsius ? snapshot.data[index + 1].temperature['mx'].round() : convertWeather(snapshot.data[index + 1].temperature['mx'])}°    ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${celsius ? snapshot.data[index + 1].temperature['mn'].round() : convertWeather(snapshot.data[index + 1].temperature['mn'])}°',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/background.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  LinearProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.orange[800]),
                    backgroundColor: Colors.black,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
