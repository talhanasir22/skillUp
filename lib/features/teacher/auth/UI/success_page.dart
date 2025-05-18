import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/features/teacher/bottomnavbar.dart';
import 'package:skill_up/shared/loading_indicator.dart';

class SuccessPage extends StatefulWidget{
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.theme,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.189,
                    child: Image.asset("assets/Images/Logo.png"),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: AppColors.bgColor,
                      radius:  40,
                        child: Icon(Icons.done,color: AppColors.theme,size: 60,weight: 200,)),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text("Success",style: AppText.descriptionTextStyle().copyWith(fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Congratulations, you have\ncompleted your registration!"
                        ,style: AppText.hintTextStyle(),),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                          await Future.delayed(Duration(seconds: 1));
                          if (mounted) {
                              Navigator.pushAndRemoveUntil(context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 500),
                                    child: BottomNavBar(),
                                  ), (route) =>false);
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: AppColors.bgColor,
                      ),
                      child: _isLoading ? LoadingIndicator() : Text("Get Started", style: AppText.buttonTextStyle()),
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