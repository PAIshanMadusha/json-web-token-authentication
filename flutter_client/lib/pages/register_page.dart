import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/pages/login_page.dart';
import 'package:flutter_client/services/authentication_service.dart';
import 'package:flutter_client/widgets/reusable_widgets/custom_button.dart';
import 'package:flutter_client/widgets/reusable_widgets/custom_input_field.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final AuthenticationService _authenticationService = AuthenticationService();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  //Register
  void register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await _authenticationService.register(
          userName: _userNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.pinkAccent,
              content: Text(
                "Registration Successfully, Please Log In!",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      } catch (error) {
        debugPrint("Error when register: $error");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Registration Unsuccessfully!",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 35,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Welcome, New User!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "To register to the system, Enter Your Details and Create a new Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                SvgPicture.asset(
                  "assets/undrawregister.svg",
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.25,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: size.height * 0.05),
                CustomInputField(
                  controller: _userNameController,
                  hintText: "Your Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomInputField(
                  controller: _emailController,
                  hintText: "Your Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                      return "Please Enter a Valid Email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomInputField(
                  controller: _passwordController,
                  hintText: "Your Password",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomInputField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm Your Password",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Your Confirm Password";
                    }
                    if (value != _passwordController.text) {
                      return "Passowrd Doesn't Match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomButton(
                  isLoading: isLoading,
                  onPressed: register,
                  labelText: "Register",
                ),
                SizedBox(height: size.height * 0.07),
                Text.rich(
                  TextSpan(
                    text: "Already have an Account? ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: "Login Here",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
