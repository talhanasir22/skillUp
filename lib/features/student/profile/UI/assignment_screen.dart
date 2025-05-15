import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> incompleteAssignments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadDummyAssignments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void loadDummyAssignments() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading
    setState(() {
      incompleteAssignments = [
        {
          'title': 'Assignment 1',
          'dueDate': '2025-05-30',
          'dueTime': '11:59 PM',
          'totalMarks': 20,
          'teacherName': 'Mr. Ahmed',
          'courseName': 'Mathematics',
          'pdfUrl': 'https://example.com/assignment1.pdf',
        },
        {
          'title': 'Assignment 2',
          'dueDate': '2025-06-05',
          'dueTime': '5:00 PM',
          'totalMarks': 25,
          'teacherName': 'Ms. Fatima',
          'courseName': 'Physics',
          'pdfUrl': 'https://example.com/assignment2.pdf',
        },
      ];
      isLoading = false;
    });
  }

  void showDummyActionMessage(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$action clicked (Dummy)")),
    );
  }

  Widget smallBlueButton(IconData icon, String tooltip, VoidCallback onPressed) {
    return Tooltip(
      message: tooltip,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              backgroundColor: AppColors.bgColor,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          Text(tooltip),
        ],
      ),
    );
  }

  Widget buildShimmerLoader() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(height: 150),
        ),
      ),
    );
  }

  Widget buildAssignmentCard(Map<String, dynamic> assignment) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title: ${assignment['title']}", style: AppText.mainHeadingTextStyle()),
            Text("Course: ${assignment['courseName']}"),
            Text("Teacher: ${assignment['teacherName']}"),
            Text("Due Date: ${assignment['dueDate']} at ${assignment['dueTime']}"),
            Text("Total Marks: ${assignment['totalMarks']}"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                smallBlueButton(Icons.open_in_new, "Open", () => showDummyActionMessage("Open")),
                smallBlueButton(Icons.download, "Download", () => showDummyActionMessage("Download")),
                smallBlueButton(Icons.upload, "Upload", () => showDummyActionMessage("Upload")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIncompleteTab() {
    if (isLoading) return buildShimmerLoader();
    if (incompleteAssignments.isEmpty) {
      return const Center(child: Text("No incomplete assignments found."));
    }
    return ListView.builder(
      itemCount: incompleteAssignments.length,
      itemBuilder: (context, index) {
        return buildAssignmentCard(incompleteAssignments[index]);
      },
    );
  }

  Widget buildCompletedTab() {
    return const Center(child: Text("Completed assignments UI coming soon..."));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Assignments",
          style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Incomplete"),
            Tab(text: "Completed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildIncompleteTab(),
          buildCompletedTab(),
        ],
      ),
    );
  }
}
