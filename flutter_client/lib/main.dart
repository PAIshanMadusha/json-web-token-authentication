import 'package:flutter/material.dart';
import 'package:flutter_client/pages/login_page.dart';
import 'package:flutter_client/pages/main_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "JWT Authentication",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: CheckAuthenticationStatus(),
    );
  }
}

//Check Authentication Status
class CheckAuthenticationStatus extends StatefulWidget {
  const CheckAuthenticationStatus({super.key});

  @override
  State<CheckAuthenticationStatus> createState() =>
      _CheckAuthenticationStatusState();
}

class _CheckAuthenticationStatusState extends State<CheckAuthenticationStatus> {
  bool isLoggedIn = false;

  //A Method to Check the User Login Status
  void checkLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    setState(() {
      isLoggedIn = token != null;
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? MainPage() : LoginPage();
  }
}
