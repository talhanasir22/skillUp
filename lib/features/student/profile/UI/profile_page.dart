import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/features/role_selection_page.dart';
import 'package:skill_up/features/student/profile/UI/assignment_screen.dart';
import 'package:skill_up/features/student/profile/UI/edit_profile_page.dart';
import 'package:skill_up/features/student/profile/UI/grade_screen.dart';
import 'package:skill_up/features/student/profile/UI/notification_setting_screen.dart';
import 'package:skill_up/features/student/profile/UI/set_daily_target.dart';
import 'package:skill_up/features/student/profile/UI/student_performance_page.dart';
import 'package:skill_up/features/student/profile/UI/submission_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String _userName = "Talha"; // Hardcoded name (no backend)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profile", style: AppText.mainHeadingTextStyle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
    
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Hi, $_userName",
                style: AppText.mainHeadingTextStyle().copyWith(
                  color: AppColors.bgColor,
                ),
              ),
              subtitle: Text(
                "Student",
                style: AppText.mainSubHeadingTextStyle().copyWith(
                  color: AppColors.bgColor,
                ),
              ),
              trailing: Icon(
                Icons.person,
                size: 50,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.89,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: StudentPerformancePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "View Progress",
                        style: AppText.mainHeadingTextStyle().copyWith(
                          color: AppColors.theme,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.theme,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextButton("Edit Profile", () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: EditProfileScreen(),
                ),
              );
            }),
            _buildTextButton("Change Notification Settings", () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: NotificationSettingScreen(),
                ),
              );
            }),
            _buildTextButton("Due Assignments", () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: AssignmentScreen(),
                ),
              );
            }),
            _buildTextButton("Submissions", () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: SubmissionScreen(),
                ),
              );
            }),
            _buildTextButton("Grades", () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: GradeScreen(),
                ),
              );
            }),
            _buildTextButton("Set Daily Target", () {
                Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: SetDailyTargetScreen(),
                ),
              );
            }),
            _buildTextButton("Help", () {}),
            _buildTextButton("Customer Support", () {}),
            _buildTextButton("Logout", () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Confirm Logout"),
                  content: const Text("Are you sure you want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: const RoleSelectionPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppText.mainSubHeadingTextStyle().copyWith(
              fontSize: 16,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
