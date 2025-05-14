import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';

class SecondPage extends StatefulWidget{
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.theme,
        body: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .35,
                width: MediaQuery.of(context).size.height * .75,
                child: Image.asset("assets/Images/2.png"),
              ),
            ),
            Center(
              child: Text("Learn, Track & Grow",style: AppText.onboardingHeadingStyle()),
            ),
            Center(
              child: SizedBox(
                height: 30,
                width: 300,
                child: Text("Save time and effort as AI automates your progress tracking and learning suggestions",
                  overflow: TextOverflow.visible,
                  maxLines: 5, // Limits text to 2 lines
                  textAlign: TextAlign.center, // Centers text
                  style: AppText.onboardingDescStyle(),
                ),
              ),

            )
          ],
        )
    );
  }
}