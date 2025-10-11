import 'package:firstflutter/Labs/Lecture8/MyHome.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget Tree"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                      width: 40,
                      height: 40,
                    ),
                    Padding(padding: EdgeInsets.all(16.0)),
                    Container(
                      color: Colors.green,
                      width: 400,
                      height: 40,
                    ),
                    Padding(padding: EdgeInsets.all(16.0)),
                    Container(
                      color: Colors.blue,
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(16.0)),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                          width: 60,
                          height: 60,
                        ),
                        Padding(padding: EdgeInsets.all(16.0)),
                        Container(
                          color: Colors.green,
                          width: 40,
                          height: 40,
                        ),
                        Padding(padding: EdgeInsets.all(16.0)),
                        Container(
                          color: Colors.blue,
                          width: 20,
                          height: 20,
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 100.0,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.red,
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    color: Colors.pink,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Text("End of Line"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

