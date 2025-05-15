import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_text.dart';

class AwardPage extends StatefulWidget{
  const AwardPage({super.key});

  @override
  State<AwardPage> createState() => _AwardPageState();
}

class _AwardPageState extends State<AwardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
         Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text("Achievements",style: AppText.mainHeadingTextStyle(),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/Images/No notification.png")),
          Center(child: Text("No achievement yet",style: AppText.mainSubHeadingTextStyle()))
        ],
      ),
    );
  }
}