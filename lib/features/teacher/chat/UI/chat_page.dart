import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skill_up/Core/app_text.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String currentTime = DateFormat.jm().format(DateTime.now());

  // Simulated static teacher data for UI
  final List<Map<String, dynamic>> mockTeachers = [
    {'uid': 't1', 'userName': 'Ms. Ada Lovelace'},
    {'uid': 't2', 'userName': 'Mr. Alan Turing'},
    {'uid': 't3', 'userName': 'Dr. Marie Curie'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Messages & Notifications",
          style: AppText.mainHeadingTextStyle().copyWith(fontSize: 24),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Message"),
            Tab(text: "Notification"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Messages Tab
          ListView.separated(
            itemCount: mockTeachers.length,
            itemBuilder: (context, index) {
              var teacher = mockTeachers[index];

              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeft,
                  //     child: ChatRoomPage(
                  //       name: teacher['userName'],
                  //       teacherUid: teacher['uid'],
                  //     ),
                  //   ),
                  // );
                },
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(teacher['userName']),
                  trailing: Text(currentTime),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),

          // Notifications Tab
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset("assets/Images/No notification.png")),
              const Center(child: Text("No notification yet"))
            ],
          ),
        ],
      ),
    );
  }
}
