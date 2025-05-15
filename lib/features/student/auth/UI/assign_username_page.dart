import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/features/student/auth/UI/success_page.dart';
import 'package:skill_up/shared/loading_indicator.dart';


class AssignUserNamePage extends StatefulWidget {
  @override
  State<AssignUserNamePage> createState() => _AssignUserNamePageState();
}

class _AssignUserNamePageState extends State<AssignUserNamePage> {
  final _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  Future<void> _mockSaveUserName() async {
    await Future.delayed(Duration(seconds: 1));
    // Simulated success feedback
    print("Username '${_userNameController.text.trim()}' saved (mock).");
  }

  Future<bool> _mockIsUsernameUnique(String username) async {
    await Future.delayed(Duration(milliseconds: 500));
    return username != "takenusername"; // Pretend this username is already taken
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.theme,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.189,
                    child: Image.asset("assets/Images/Logo.png"),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Enter",
                      style: AppText.onboardingHeadingStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Your Username",
                    textAlign: TextAlign.center,
                    style: AppText.onboardingHeadingStyle().copyWith(color: AppColors.bgColor),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      hintText: "Enter here",
                      hintStyle: AppText.hintTextStyle(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) =>
                        (value == null || value.isEmpty) ? 'Please enter your username' : null,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          final String enteredUsername =
                              _userNameController.text.trim().toLowerCase();

                          bool isUnique = await _mockIsUsernameUnique(enteredUsername);
                          if (!isUnique) {
                            Fluttertoast.showToast(
                                msg: "Username is already taken. Please choose another.");
                            setState(() {
                              _isLoading = false;
                            });
                            return;
                          }

                          await _mockSaveUserName();

                          if (mounted) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 500),
                                child: SuccessPage(),
                              ),
                            );
                          }

                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppColors.bgColor,
                      ),
                      child: _isLoading
                          ? LoadingIndicator()
                          : Text("Next", style: AppText.buttonTextStyle()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
