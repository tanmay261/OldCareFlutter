import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:im_animations/im_animations.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oldisgold/models/sugarmodel.dart';
import 'package:oldisgold/screens/addreminders.dart';
import 'package:oldisgold/screens/averagebpm.dart';
import 'package:oldisgold/screens/averagefootsteps.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SugarModel sugar;
  Future<SugarModel> getSugar() async {
    final String apiUrl = DotEnv.env['API'] + "device/sugarlvl";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return sugarModelFromJson(responseString);
      print(response.body);
    } else {
      print("Error " + jsonDecode(response.body)['error']);
    }
  }

  int _currentIndex = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {}
  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
        onPressed: function,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: Colors.blue,
        child: Icon(
          icon,
          size: 36.0,
        ));
  }

  final controller = PageController(
    initialPage: 1,
  );
  _generateData() {
    var piedata = [
      new Task('Work', 35.8, Color(0xff3366cc)),
      new Task('Eat', 8.3, Color(0xff990099)),
      new Task('Commute', 10.8, Color(0xff109618)),
      new Task('TV', 15.6, Color(0xfffdbe19)),
      new Task('Sleep', 19.2, Color(0xffff9900)),
      new Task('Other', 10.3, Color(0xffdc3912)),
    ];
  }

  @override
  void initState() {
    super.initState();
    _generateData();
    getSugar();
  }

  List screens = [];
  int randomIntInRange({int min = 0, int max = 100}) {
    return (Random().nextDouble() * (max - min + 1) + min).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        shadowColor: Colors.white,
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              children: [
                                Text(
                                  "HeartRate",
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                GestureDetector(
                                  child: HeartBeat(
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AverageBPM()));
                                  },
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      randomIntInRange(min: 60, max: 120)
                                          .toString(),
                                      style: TextStyle(fontSize: 40),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      "bpm",
                                      style: TextStyle(
                                          fontSize: 20,
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("Healthy",
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              children: [
                                Text(
                                  "Sugar Lvl",
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("mg/Dl"),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      randomIntInRange(min: 140, max: 180)
                                          .toString(),
                                      style: TextStyle(fontSize: 40),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text("Normal",
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              height: 100.0,
              width: double.infinity,
              child: PageView(
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[200],
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      height: 100.0,
                      width: 200,
                      child: Column(
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Upcoming Reminders",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ]),
                        ],
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reminders()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        height: 100.0,
                        width: 200,
                        child: Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Completed Reminders",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/capsule.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                        Column(
                                          children: [
                                            Text("Medicine"),
                                            Text("Paracetamol ")
                                          ],
                                        ),
                                        Text("5:45 PM ")
                                      ],
                                    ),
                                    // Row(
                                    //   children: [],
                                    // ),
                                  ],
                                ),
                              )
                            ]),
                          ],
                        )),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red[200],
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      height: 100.0,
                      width: 200,
                      child: Column(
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Missed Reminders",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ]),
                        ],
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              height: 100,
              width: double.infinity,
              child: PageView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AverageFootSteps()));
                              },
                              child: Text(
                                "Footsteps",
                                style: TextStyle(fontSize: 22.0),
                              ),
                            ),
                            Text("12000 steps"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Calories",
                              style: TextStyle(fontSize: 22.0),
                            ),
                            Text("596 Cal"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "Footsteps",
                                  style: TextStyle(fontSize: 22.0),
                                ),
                                Text("per goal")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "12000 ",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text("out of"),
                                Text(
                                  "15000",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text("steps"),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "Calories",
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                Text("per goal")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  "596 ",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text("out of"),
                                Text(
                                  "15000",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                Text("Cal"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
