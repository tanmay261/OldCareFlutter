import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:oldisgold/models/bpmmodel.dart';
import 'dart:convert';
import 'package:oldisgold/api/storage.dart';

class AverageBPM extends StatefulWidget {
  @override
  _AverageBPMState createState() => _AverageBPMState();
}

class _AverageBPMState extends State<AverageBPM> {
  BpmModel _bpm;
  List<charts.Series> seriesList;
  static List<charts.Series<HeartRate, String>> _createRandomData() {
    final random = Random();
    final bpmdata = [
      HeartRate(
        "Day 1 ",
        random.nextInt(100),
      ),
      HeartRate(
        "Day 2 ",
        random.nextInt(100),
      ),
      HeartRate(
        "Day 3 ",
        random.nextInt(100),
      ),
      HeartRate(
        "Day 4 ",
        random.nextInt(100),
      ),
      HeartRate(
        "Day 5 ",
        random.nextInt(100),
      ),
    ];

    return [
      charts.Series<HeartRate, String>(
          id: 'Heart Rate',
          domainFn: (HeartRate heartrate, _) => heartrate.day,
          measureFn: (HeartRate heartrate, _) => heartrate.hearrate,
          data: bpmdata,
          fillColorFn: (HeartRate heartrate, _) {
            return charts.MaterialPalette.blue.shadeDefault;
          })
    ];
  }

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
    );
  }

  Future<BpmModel> getBPM(String date, String filter) async {
    final SecureStorage secureStorage = SecureStorage();

    final String tokenID = await secureStorage.readSecureData('token');
    final String apiUrl = DotEnv.env['API'] + "device/bpm";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "date": date,
      "option": filter,
    }, headers: {
      "Authorization": "Bearer " + tokenID
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return bpmModelFromJson(responseString);
    } else {
      print("Error from server " + jsonDecode(response.body)['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final BpmModel bpm = await getBPM("2021-03-19", "date");
          setState(() {
            _bpm = bpm;
          });
          print(_bpm);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Charts"),
      ),
      body: Container(padding: EdgeInsets.all(20.0), child: barChart()),
    );
  }
}

class HeartRate {
  final String day;
  final int hearrate;

  HeartRate(this.day, this.hearrate);
}
