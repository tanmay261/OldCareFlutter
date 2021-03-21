import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:oldisgold/models/bpmmodel.dart';
import 'dart:convert';
import 'package:oldisgold/api/storage.dart';
import 'package:oldisgold/models/footstepsmodel.dart';

class AverageFootSteps extends StatefulWidget {
  @override
  _AverageFootStepsState createState() => _AverageFootStepsState();
}

class _AverageFootStepsState extends State<AverageFootSteps> {
  FootstepsModel _steps;
  List<charts.Series> seriesList;
  static List<charts.Series<FootSteps, String>> _createRandomData() {
    final random = Random();
    final stepsdata = [
      FootSteps(
        "Day 1 ",
        random.nextInt(100),
      ),
      FootSteps(
        "Day 2 ",
        random.nextInt(100),
      ),
      FootSteps(
        "Day 3 ",
        random.nextInt(100),
      ),
      FootSteps(
        "Day 4 ",
        random.nextInt(100),
      ),
      FootSteps(
        "Day 5 ",
        random.nextInt(100),
      ),
    ];

    return [
      charts.Series<FootSteps, String>(
          id: 'FootSteps Rate',
          domainFn: (FootSteps footsteps, _) => footsteps.day,
          measureFn: (FootSteps footSteps, _) => footSteps.hearrate,
          data: stepsdata,
          fillColorFn: (FootSteps footSteps, _) {
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

  Future<FootstepsModel> getSteps(String date, String filter) async {
    final SecureStorage secureStorage = SecureStorage();

    final String tokenID = await secureStorage.readSecureData('token');
    final String apiUrl = DotEnv.env['API'] + "device/steps";
    final response = await http.post(Uri.parse(apiUrl), body: {
      "date": date,
      "option": filter,
    }, headers: {
      "Authorization": "Bearer " + tokenID
    });

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return footstepsModelFromJson(responseString);
    } else {
      print("Error from server " + jsonDecode(response.body)['error']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final FootstepsModel steps = await getSteps("2021-03-19", "date");
          setState(() {
            _steps = steps;
          });
          print(_steps);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("FootSteps"),
      ),
      body: Container(padding: EdgeInsets.all(20.0), child: barChart()),
    );
  }
}

class FootSteps {
  final String day;
  final int hearrate;

  FootSteps(this.day, this.hearrate);
}
