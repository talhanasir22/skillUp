import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/features/teacher/course/UI/manage_course_page.dart';
import 'package:skill_up/features/teacher/course/UI/set_assignment_page.dart';
import 'package:skill_up/shared/course_annoucement_banner.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  final List<String> courseTitles = [
    "Mathematics Basics",
    "Intro to Physics",
    "Chemistry 101",
    "Biology Fundamentals"
  ];

  final List<Color> cardColors = [
    Colors.blue.shade400,
    Colors.green.shade400,
    Colors.orange.shade400,
    Colors.purple.shade400,
  ];

  final List<String> courseCids = [
    "course1",
    "course2",
    "course3",
    "course4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text("My Courses", style: AppText.mainHeadingTextStyle()),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: CourseAnnouncementBanner(
              bannerText: "Manage courses, & assign assignments\nAll in one place.",
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: courseTitles.isEmpty
                  ? Center(
                      child: Text(
                        "No course has been created yet",
                        style: AppText.hintTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2,
                      ),
                      itemCount: courseTitles.length,
                      itemBuilder: (context, index) {
                        return _buildGridItem(context, index);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, int index) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      color: cardColors[index],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                courseTitles[index],
                style: AppText.mainHeadingTextStyle().copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSmallCard(
                  title: "Student Enrolled",
                  subtitle: "3",
                ),
                _buildSmallCard(
                  title: "Manage Course",
                  icon: Icons.settings,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:ManageCoursePage(
                      ),
                      ),
                    );
                  },
                ),
                _buildSmallCard(
                  title: "Set\nAssignment",
                  icon: Icons.menu_book,
                  fontSize: 12,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: SetAssignmentPage()
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard({
    required String title,
    String? subtitle,
    IconData? icon,
    double fontSize = 14,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 75,
      width: 95,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 10,
          color: AppColors.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  title,
                  style: AppText.mainSubHeadingTextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: AppColors.theme,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: AppText.mainSubHeadingTextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.theme,
                  ),
                )
              else if (icon != null)
                Icon(icon, color: AppColors.theme),
            ],
          ),
        ),
      ),
    );
  }
}
