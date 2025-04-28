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
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registration Successfully, Please Log In!"),
            ),
          );
        }
      } catch (error) {
        debugPrint("Error when register: $error");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration Unsuccessfully!")),
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
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Hello Again!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  "Hello Again! Description",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset(
                  "assets/undrawregister.svg",
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 15),
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
                SizedBox(height: 15),
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
                SizedBox(height: 15),
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
                SizedBox(height: 15),
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
                SizedBox(height: 15),
                CustomButton(
                  isLoading: isLoading,
                  onPressed: register,
                  labelText: "Register",
                ),
                SizedBox(height: 15),
                Text.rich(
                  TextSpan(
                    text: "Already have an Account? ",
                    children: [
                      TextSpan(
                        text: "Login Here",
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
