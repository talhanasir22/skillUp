import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_text.dart';

class SubmissionScreen extends StatefulWidget {
  const SubmissionScreen({super.key});

  @override
  State<SubmissionScreen> createState() => _SubmissionScreenState();
}

class _SubmissionScreenState extends State<SubmissionScreen> {
  // Dummy submission data
  final List<Map<String, String>> submissions = [
    {
      'title': 'Math Assignment 1',
      'date': '2025-04-10',
      'status': 'Submitted',
    },
    {
      'title': 'Physics Lab Report',
      'date': '2025-04-12',
      'status': 'Pending Review',
    },
    {
      'title': 'Computer Science Quiz',
      'date': '2025-04-15',
      'status': 'Graded',
    },
    {
      'title': 'English Essay',
      'date': '2025-04-18',
      'status': 'Submitted',
    },
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
        title: Text(
          "Submissions",
          style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
        ),
      ),
      body: submissions.isEmpty
          ? Center(
              child: Text(
                "No submissions found.",
                style: AppText.mainSubHeadingTextStyle(),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: submissions.length,
              itemBuilder: (context, index) {
                final submission = submissions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.assignment),
                    title: Text(
                      submission['title'] ?? '',
                      style: AppText.mainSubHeadingTextStyle(),
                    ),
                    subtitle: Text('Date: ${submission['date']}'),
                    trailing: Text(
                      submission['status'] ?? '',
                      style: TextStyle(
                        color: submission['status'] == 'Graded'
                            ? Colors.green
                            : submission['status'] == 'Pending Review'
                                ? Colors.orange
                                : Colors.blue,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
