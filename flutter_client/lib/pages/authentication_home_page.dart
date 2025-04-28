import 'package:flutter/material.dart';
import 'package:flutter_client/pages/login_page.dart';
import 'package:flutter_client/pages/register_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthenticationHomePage extends StatelessWidget {
  const AuthenticationHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Let's Get Started",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  SvgPicture.asset(
                    "assets/undrawhome.svg",
                    height: size.height * 0.4,
                    width: size.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: size.height * 0.1),
                  Text(
                    "JWT Authentication",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    "This is a simple JWT (JSON Web Token) authentication app that demonstrates only the Login and Register pages. The JWT token is saved using SharedPreferences.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customContainerButton(
                        context: context,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        text: "Login",
                      ),
                      customContainerButton(
                        context: context,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        text: "Register",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customContainerButton({
    required BuildContext context,
    required void Function()? onTap,
    required String text,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.41,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black87,
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.pinkAccent,
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
