import 'dart:convert';
import 'package:oldisgold/api/storage.dart';
import 'package:flutter/material.dart';
import 'package:oldisgold/models/personalDetails.dart';
import 'package:oldisgold/models/timezone.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart' as http;

class UserPersonalDetails extends StatefulWidget {
  @override
  _UserPersonalDetailsState createState() => _UserPersonalDetailsState();
}

Future<PersonalDetailModel> registerUser(
    String name,
    String age,
    String mobileno,
    String weight,
    String height,
    String timezone,
    String country_code) async {
  final SecureStorage secureStorage = SecureStorage();
  final String apiUrl = DotEnv.env['API'] + "elder/add";
  final String tokenID = await secureStorage.readSecureData('token');
  final response = await http.post(Uri.parse(apiUrl), body: {
    "name": name,
    "age": age,
    "mobileno": mobileno,
    "timezone": timezone,
    "weight": weight,
    "height": height,
    "country_code": country_code
  }, headers: {
    "Authorization": "Bearer " + tokenID
  });

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print("Error from server" + jsonDecode(response.body)['error']);
  }
}

class _UserPersonalDetailsState extends State<UserPersonalDetails> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();
  final TextEditingController mobilecontroller = TextEditingController();
  final TextEditingController heightcontroller = TextEditingController();
  final TextEditingController weightcontroller = TextEditingController();
  PersonalDetailModel _personal;

  String _selectedtimezone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
              ),
              child: Row(
                children: [
                  Text(
                    "Enter your Details ",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("TimeZone : "),
                DropdownButton(
                  value: _selectedtimezone,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedtimezone = newValue;
                    });
                  },
                  items: timezonelist.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0)
                    ]),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: InputBorder.none,
                      hintText: "Enter Your Full Name",
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0)
                    ]),
                child: TextField(
                  controller: agecontroller,
                  decoration: InputDecoration(
                      labelText: "Age",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: InputBorder.none,
                      hintText: "Enter your age",
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0)
                    ]),
                child: TextField(
                  controller: mobilecontroller,
                  decoration: InputDecoration(
                      labelText: "Mobile Number",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: InputBorder.none,
                      hintText: "Enter your mobile number without country code",
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0)
                    ]),
                child: TextField(
                  controller: weightcontroller,
                  decoration: InputDecoration(
                      labelText: "Weight",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: InputBorder.none,
                      hintText: "Enter your weight in Kg",
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: Color(0XFFEFF3F6),
                    borderRadius: BorderRadius.circular(100.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          offset: Offset(6, 2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0),
                      BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          offset: Offset(-6, -2),
                          blurRadius: 6.0,
                          spreadRadius: 3.0)
                    ]),
                child: TextField(
                  controller: heightcontroller,
                  decoration: InputDecoration(
                      labelText: "Height",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: InputBorder.none,
                      hintText: "Enter your height in cm",
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          final String name = namecontroller.text;
                          print("check 1" + name);
                          final String age = agecontroller.text;
                          print("check 2" + age.toString());
                          final String mobile = mobilecontroller.text;
                          print("check 3 " + mobile.toString());
                          final String weight = weightcontroller.text;
                          print("check 4 " + weight.toString());
                          final String height = heightcontroller.text;
                          print("check 5 " + height.toString());
                          final String timezone = _selectedtimezone;
                          print("check 6 " + timezone);
                          final PersonalDetailModel personal =
                              await registerUser(name, age, mobile, weight,
                                  height, timezone, "91");
                          setState(() {
                            _personal = personal;
                          });
                          print(_personal);
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.lightBlue[50],
                              offset: Offset(6, 2),
                              blurRadius: 1.0,
                              spreadRadius: 2.0),
                        ]),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
