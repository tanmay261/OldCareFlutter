import 'package:flutter/material.dart';
import 'package:oldisgold/models/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:oldisgold/screens/signup_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:oldisgold/api/storage.dart';
import 'dart:convert';
import 'package:oldisgold/models/loginModel.dart';

class TestMe extends StatefulWidget {
  @override
  _TestMeState createState() => _TestMeState();
}

final SecureStorage secureStorage = SecureStorage();

Future<LoginModel> loginUser(String email, String password) async {
  final String apiUrl = DotEnv.env['API'] + "auth/user/login";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "email": email,
    "password": password,
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return loginModelFromJson(responseString);
  } else {
    print("Error " + jsonDecode(response.body)['error']);
  }
}

class _TestMeState extends State<TestMe> {
  LoginModel _user;
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Welcome"),
          Text(
            "Sign In",
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
          ),
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
              controller: emailcontroller,
              decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: InputBorder.none,
                  hintText: "Admin@live.com",
                  hintStyle: TextStyle(color: Colors.grey[400])),
            ),
          ),
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
              controller: passwordcontroller,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: InputBorder.none,
                  hintText: "********",
                  hintStyle: TextStyle(color: Colors.grey[400])),
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
                        final String email = emailcontroller.text;
                        final String password = passwordcontroller.text;

                        final LoginModel user =
                            await loginUser(email, password);
                        setState(() {
                          _user = user;
                        });
                        secureStorage.writeSecureData('token', _user.token);
                        if (_user != null) print(_user);
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue,
                            offset: Offset(6, 2),
                            blurRadius: 1.0,
                            spreadRadius: 2.0),
                      ]),
                ),
              )
            ],
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )),
          _user == null
              ? Container()
              : Text(
                  "The user ${_user}, ${_user} is created successfully at }"),
        ],
      ),
    ));
  }
}
