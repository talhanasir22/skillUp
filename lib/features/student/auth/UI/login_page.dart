import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/features/role_selection_page.dart';
import 'package:skill_up/features/student/auth/UI/forgot_password_page.dart';
import 'package:skill_up/features/student/auth/UI/sign_up_page.dart';
import 'package:skill_up/shared/loading_indicator.dart';

import 'assign_username_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = true;
  bool _isLoading = false;
  bool _isgoogleLoading = false;

  void _mockLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: AssignUserNamePage(),
          ),
        );
      });
    }
  }

  void _mockGoogleSignIn() {
    setState(() => _isgoogleLoading = true);
    Future.delayed(Duration(seconds: 2), () {
      setState(() => _isgoogleLoading = false);
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: AssignUserNamePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.theme,
          appBar: AppBar(
            backgroundColor: AppColors.theme,
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: Duration(milliseconds: 300),
                    child: RoleSelectionPage(),
                  ),
                  (route) => false,
                );
              },
              icon: Icon(Icons.arrow_back_ios, color: AppColors.bgColor),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.189,
                        child: Image.asset("assets/Images/Logo.png"),
                      ),
                    ),
                    Center(child: Text("Sign in", style: AppText.authHeadingStyle())),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        "Enter your email & password to sign in",
                        style: AppText.authHeadingStyle().copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textFieldColor,
                        hintText: "email@domain.com",
                        hintStyle: AppText.hintTextStyle(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Please enter your email' : null,
                    ),
                    SizedBox(height: 13),
                    TextFormField(
                      obscureText: _isVisible,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.textFieldColor,
                        suffixIcon: IconButton(
                          icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off, size: 18),
                          onPressed: () => setState(() => _isVisible = !_isVisible),
                        ),
                        hintText: "Password",
                        hintStyle: AppText.hintTextStyle(),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) => value == null || value.isEmpty ? 'Please enter your password' : null,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 300),
                              child: ForgotPassword(),
                            ),
                          );
                        },
                        child: Text("Forgot Password?", style: TextStyle(color: Color(0xff858597), fontSize: 12)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 20),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "By proceeding, you agree to our ",
                              style: AppText.hintTextStyle().copyWith(fontSize: 9),
                            ),
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(fontSize: 9, color: Colors.black, decoration: TextDecoration.underline),
                            ),
                            TextSpan(
                              text: " and ",
                              style: AppText.hintTextStyle().copyWith(fontSize: 9),
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(fontSize: 9, color: Colors.black, decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _mockLogin,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColors.bgColor,
                        ),
                        child: _isLoading
                            ? LoadingIndicator()
                            : Text("Login", style: AppText.buttonTextStyle()),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(child: Text("- or continue with -", style: AppText.hintTextStyle())),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: _mockGoogleSignIn,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 1,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image.asset('assets/Images/google.png', width: 30, height: 30),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            print("Apple sign-in tapped");
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 1,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image.asset('assets/Images/apple.png', width: 30, height: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300),
                            child: SignUpPage(),
                          ),
                        );
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "I don't have an account ", style: AppText.hintTextStyle()),
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(color: Colors.black, decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isgoogleLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(child: LoadingIndicator()),
          ),
      ],
    );
  }
}
