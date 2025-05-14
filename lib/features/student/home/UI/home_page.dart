import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';

class HomePage extends StatefulWidget {
  final Function(int)? onNavIndexChange;
  const HomePage({super.key, required this.onNavIndexChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _userName = "Talha";
  int timeSpentInSeconds = 0;
  Timer? timer;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        timeSpentInSeconds++;
        progress = timeSpentInSeconds / 3600;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  _buildCardWithImage(context),
                  _buildSectionTitle("Learning Plan"),
                  _buildTextCard(context, "Explore courses, track progress, and master skills. Start innovating today!"),
                  _buildEdTechCard(context),
                ],
              ),
            ),
          ),
          _buildHeader(),
          _buildTopRightAvatars(context),
          _buildProgressBar(context),
        ],
      ),
    );
  }

  Widget _buildCardWithImage(BuildContext context) {
    return SizedBox(
      height: 155,
      width: MediaQuery.of(context).size.width * 0.85,
      child: Card(
        elevation: 1,
        color: Color(0xffCEECFE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("What do you want to learn today?", style: AppText.mainSubHeadingTextStyle().copyWith(fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onNavIndexChange?.call(1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.bgColor,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("Get Started", style: AppText.buttonTextStyle().copyWith(color: AppColors.theme)),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage("assets/Images/Page3.png"),
                  radius: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(title, style: AppText.mainHeadingTextStyle().copyWith(fontSize: 18)),
    );
  }

  Widget _buildTextCard(BuildContext context, String text) {
    return SizedBox(
      height: 130,
      width: MediaQuery.of(context).size.width * 0.85,
      child: Card(
        elevation: 1,
        color: Color(0xffCEECFE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(text, style: AppText.mainSubHeadingTextStyle().copyWith(fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _buildEdTechCard(BuildContext context) {
    return SizedBox(
      height: 130,
      width: MediaQuery.of(context).size.width * 0.85,
      child: Card(
        elevation: 1,
        color: AppColors.bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" The EdTech", style: AppText.mainHeadingTextStyle().copyWith(fontSize: 23, fontWeight: FontWeight.w600, color: AppColors.theme)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 70,
                    width: 200,
                    child: Text("Unlocking Knowledge, Powering Innovation!", style: AppText.mainSubHeadingTextStyle().copyWith(fontSize: 12)),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 10),
                  child: CircleAvatar(
                    radius: 37.5,
                    backgroundColor: AppColors.theme.withOpacity(0.56),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.theme.withOpacity(0.8),
                      child: CircleAvatar(
                        radius: 12.5,
                        backgroundImage: AssetImage("assets/Images/Page2.png"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 180,
      color: AppColors.bgColor,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_userName, style: AppText.mainHeadingTextStyle().copyWith(color: AppColors.theme)),
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: Text("Student", style: AppText.mainSubHeadingTextStyle().copyWith(color: AppColors.theme)),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRightAvatars(BuildContext context) {
    return Positioned(
      top: 50,
      right: 10,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(context, PageTransition(child: AchievementScreen(), type: PageTransitionType.rightToLeft));
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.theme,
              backgroundImage: AssetImage("assets/Images/Awards.png"),
            ),
          ),
          const SizedBox(width: 15),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.theme,
            backgroundImage: AssetImage("assets/Images/User.png"),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return Positioned(
      top: 130,
      left: MediaQuery.of(context).size.width * 0.075,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.theme,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Learned Today", style: AppText.hintTextStyle()),
              SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  text: "${(timeSpentInSeconds / 60).toStringAsFixed(0)}",
                  style: AppText.mainHeadingTextStyle(),
                  children: [TextSpan(text: "/60min", style: AppText.hintTextStyle())],
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
            ]),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: MyCourse()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bgColor,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("My Courses", style: AppText.buttonTextStyle().copyWith(color: AppColors.theme)),
            ),
          ],
        ),
      ),
    );
  }
}
