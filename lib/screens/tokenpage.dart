import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oldisgold/api/storage.dart';
import 'package:oldisgold/models/tokenModel.dart';
import 'package:oldisgold/screens/userpersonaldetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'signup_page.dart';

class TokenPage extends StatefulWidget {
  final String tokennum;
  const TokenPage({Key key, this.tokennum}) : super(key: key);
  @override
  _TokenPageState createState() => _TokenPageState();
}

String thistoken;
Future<DeviceTokenModel> registerDevice(String token) async {
  final SecureStorage secureStorage = SecureStorage();

  final String tokenID = await secureStorage.readSecureData('token');
  final String apiUrl = DotEnv.env['API'] + "device/register";
  final response = await http.post(Uri.parse(apiUrl),
      body: {"token": token}, headers: {"Authorization": "Bearer " + tokenID});

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return deviceTokenModelFromJson(responseString);
  } else {
    print("Error " + jsonDecode(response.body)['error']);
  }
}

class _TokenPageState extends State<TokenPage> {
  final TextEditingController tokencontroller = TextEditingController();
  @override
  void initState() {
    secureStorage.readSecureData('token').then((value) => {thistoken = value});
    super.initState();
  }

  DeviceTokenModel _token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                controller: tokencontroller,
                decoration: InputDecoration(
                    labelText: "Device Token",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: InputBorder.none,
                    hintText: "Enter Device Token Number",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(
              height: 20.0,
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
                          final String tokennumber = tokencontroller.text;
                          final DeviceTokenModel token =
                              await registerDevice(tokennumber);
                          setState(() {
                            _token = token;
                          });
                          print(secureStorage.readSecureData('token'));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPersonalDetails()));
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
            _token == null
                ? Container()
                : Text(" with token  is created successfully}"),
          ],
        ),
      ),
    );
  }
}
