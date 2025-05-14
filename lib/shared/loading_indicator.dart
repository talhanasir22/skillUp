import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_color.dart';


class LoadingIndicator extends StatefulWidget{
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return  CircularProgressIndicator(
      color: AppColors.theme,
      backgroundColor: Colors.black,
      strokeWidth: 3.5,
      strokeAlign: -3.5,
    );
  }
}