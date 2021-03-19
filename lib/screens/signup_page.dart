import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oldisgold/api/storage.dart';
import 'package:oldisgold/models/signup.dart';
import 'package:oldisgold/screens/tokenpage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

SignUpModel _users;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Doctor'),
      Company(2, 'User'),
    ];
  }
}

final SecureStorage secureStorage = SecureStorage();

Future<SignUpModel> registerUser(
    String name, String email, String password) async {
  final String apiUrl = DotEnv.env['API'] + "auth/user/register";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "name": name,
    "email": email,
    "password": password,
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return signUpModelFromJson(responseString);
  } else {
    print("Error " + jsonDecode(response.body)['error']);
  }
}

class _SignUpState extends State<SignUp> {
  SignUpModel _user;
  final TextEditingController namecontroller = TextEditingController();

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = [];
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

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
                    "Sign Up As ",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
                  ),
                  DropdownButton(
                    value: _selectedCompany,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: InputBorder.none,
                      hintText: "Admin@live.com",
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
                          // print(DotEnv.env['API']);
                          // String xyz = DotEnv.env['API'];
                          // print(xyz);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TokenPage()));
                          final String name = namecontroller.text;
                          final String email = emailcontroller.text;
                          final String password = passwordcontroller.text;
                          final SignUpModel user =
                              await registerUser(name, email, password);

                          setState(() {
                            _user = user;
                          });
                          secureStorage.writeSecureData(
                              'email', _user.userDetails.email);
                          secureStorage.writeSecureData('token', _user.token);
                          print(secureStorage.readSecureData('token').toString());
                        },
                        child: Text(
                          "Submit",
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
            _user == null
                ? Container()
                : Text(
                    "The user ${_user.userDetails.name}, with token ${_user.token} is created successfully}"),
          ],
        ),
      ),
    );
  }
}
