import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/features/student/profile/UI/student_performance_page.dart';
import 'package:skill_up/shared/course_annoucement_banner.dart';


class EnrolledStudentPage extends StatefulWidget {
  const EnrolledStudentPage({super.key});

  @override
  State<EnrolledStudentPage> createState() => _EnrolledStudentPageState();
}

class _EnrolledStudentPageState extends State<EnrolledStudentPage> {
  bool _isLoading = true;
  List<String> studentNames = [];
  List<String> studentSids = [];

  @override
  void initState() {
    super.initState();
    _loadDummyStudents();
  }

  Future<void> _loadDummyStudents() async {
    await Future.delayed(Duration(seconds: 2)); // simulate loading delay
    setState(() {
      studentNames = [
        'Alice Johnson',
        'Bob Smith',
        'Charlie Davis',
        'Dua Fatima',
        'Talha Warraich',
        'Emily Stone',
      ];
      
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "Student Performance\nAnalytics",
            style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
          ),
        ),
      ),
      body: _isLoading ? _buildShimmerEffect() : _buildContent(),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CourseAnnouncementBanner(
            bannerText: "Manage students, track individual performance, and review assignments seamlessly.",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Click to view each student's performance in detail.",
              style: AppText.mainSubHeadingTextStyle(),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Enrolled Students",
                  style: AppText.descriptionTextStyle().copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.bgColor,
                child: Text(studentNames.length.toString()),
              ),
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: studentNames.length,
            itemBuilder: (context, index) {
              return _buildElevatedButton(
                studentNames[index],
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentPerformancePage(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildElevatedButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: AppText.mainSubHeadingTextStyle().copyWith(fontSize: 16),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
