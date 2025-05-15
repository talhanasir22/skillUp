import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_text.dart';

class GradeScreen extends StatefulWidget {
  const GradeScreen({super.key});

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen> {
  final List<Map<String, dynamic>> dummyGrades = [
    {
      'course': 'Mathematics',
      'assignment': 'Algebra Assignment',
      'grade': 'A',
      'marks': '18/20',
    },
    {
      'course': 'Physics',
      'assignment': 'Newton Laws Quiz',
      'grade': 'B+',
      'marks': '16/20',
    },
    {
      'course': 'Chemistry',
      'assignment': 'Periodic Table MCQs',
      'grade': 'A+',
      'marks': '20/20',
    },
    {
      'course': 'Computer Science',
      'assignment': 'Flutter UI Task',
      'grade': 'A',
      'marks': '19/20',
    },
  ];

  Widget buildGradeCard(Map<String, dynamic> gradeData) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gradeData['course'],
              style: AppText.mainHeadingTextStyle().copyWith(fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(
              "Assignment: ${gradeData['assignment']}",
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Grade: ${gradeData['grade']}", style: AppText.mainHeadingTextStyle()),
                Text("Marks: ${gradeData['marks']}", style: AppText.mainHeadingTextStyle()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Grades",
          style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
        ),
      ),
      body: ListView.builder(
        itemCount: dummyGrades.length,
        itemBuilder: (context, index) {
          return buildGradeCard(dummyGrades[index]);
        },
      ),
    );
  }
}
