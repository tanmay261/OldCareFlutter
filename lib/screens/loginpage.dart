import 'package:flutter/material.dart';
import 'package:oldisgold/screens/homepage.dart';
import 'package:oldisgold/screens/testing_https.dart';
// import 'package:oldisgold/screens/testing_https2.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Welcome !",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500),
              ),
            ),
            // SizedBox(height: 20.0),
        
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Container(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/google.png",
                      height: 20.0,
                      width: 20.0,
                    ),
                    Text("Sign in with Google")
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                margin: EdgeInsets.fromLTRB(20.0, 250.0, 20.0, 0.0),
                height: 70.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          offset: Offset(4, 4)),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => TestMe()));
              },
              child: Container(
                child: Row(
                  children: [
                    Image.asset("assets/email.png", height: 20.0, width: 20.0),
                    Text("Sign in with Email")
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 70.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          offset: Offset(4, 4)),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
