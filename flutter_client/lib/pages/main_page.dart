import 'package:flutter/material.dart';
import 'package:flutter_client/pages/authentication_home_page.dart';
import 'package:flutter_client/services/authentication_service.dart';
import 'package:flutter_client/widgets/reusable_widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthenticationService _authenticationService = AuthenticationService();

  bool isLoading = false;

  //Logout
  void logout() async {
    setState(() {
      isLoading = true;
    });
    try {
      await _authenticationService.logout();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Logout Successfully!")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthenticationHomePage()),
        );
      }
    } catch (error) {
      debugPrint("Error when Logout: $error");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Logout Unsuccessfully!")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Main Page",
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/undrawwelcome.svg",
                height: size.height * 0.25,
                width: size.width * 0.25,
                fit: BoxFit.cover,
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                "You Have Successfully Logged Into The System, You can now log out by clicking the button below",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.1),
              CustomButton(
                isLoading: isLoading,
                onPressed: logout,
                labelText: "Logout",
              ),
              SizedBox(height: size.height * 0.2),
              Text(
                "Created by: Ishan Madhusha",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
