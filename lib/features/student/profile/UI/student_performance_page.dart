
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_color.dart';

class AssignmentPerformance {
  final String week;
  final double completionPercentage;

  AssignmentPerformance({required this.week, required this.completionPercentage});
}

class StudentPerformancePage extends StatelessWidget {
  final String? sid;

  const StudentPerformancePage({this.sid, Key? key}) : super(key: key);

  // Mocked dummy data
  List<CoursePerformance> getDummyData() {
    return [
      CoursePerformance(
        courseName: "Mathematics",
        teacherName: "Mr. Smith",
        monthlyPerformance: [
          AssignmentPerformance(week: "Week 1", completionPercentage: 75),
          AssignmentPerformance(week: "Week 2", completionPercentage: 85),
          AssignmentPerformance(week: "Week 3", completionPercentage: 90),
          AssignmentPerformance(week: "Week 4", completionPercentage: 80),
        ],
      ),
      CoursePerformance(
        courseName: "Science",
        teacherName: "Ms. Johnson",
        monthlyPerformance: [
          AssignmentPerformance(week: "Week 1", completionPercentage: 65),
          AssignmentPerformance(week: "Week 2", completionPercentage: 70),
          AssignmentPerformance(week: "Week 3", completionPercentage: 60),
          AssignmentPerformance(week: "Week 4", completionPercentage: 75),
        ],
      ),
    ];
  }

  double averagePerformance(List<AssignmentPerformance> list) {
    if (list.isEmpty) return 0;
    return list.map((e) => e.completionPercentage).reduce((a, b) => a + b) / list.length;
  }

  @override
  Widget build(BuildContext context) {
    final courses = getDummyData();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Student Performance", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.bgColor,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(course.courseName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      subtitle: Text("Teacher: ${course.teacherName}"),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.bgColor,
                        child: Icon(Icons.book, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 100,
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipPadding: const EdgeInsets.all(8),
                              tooltipMargin: 8,
                              tooltipBorderRadius: BorderRadius.circular(8),
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                final index = group.x.toInt();
                                if (index < course.monthlyPerformance.length) {
                                  return BarTooltipItem(
                                    "${course.monthlyPerformance[index].week}\n${rod.toY.round()}%",
                                    const TextStyle(color: Colors.white),
                                  );
                                }
                                return null;
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() < course.monthlyPerformance.length) {
                                    return Text(
                                      course.monthlyPerformance[value.toInt()].week,
                                      style: TextStyle(fontSize: 12),
                                    );
                                  }
                                  return Text('');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  if (value % 20 == 0) {
                                    return Text("${value.toInt()}%");
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: false),
                          barGroups: course.monthlyPerformance.asMap().entries.map((entry) {
                            int idx = entry.key;
                            AssignmentPerformance data = entry.value;
                            return BarChartGroupData(
                              x: idx,
                              barRods: [
                                BarChartRodData(
                                  toY: data.completionPercentage,
                                  color: AppColors.bgColor,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(6),
                                  backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    toY: 100,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Average Completion: ${averagePerformance(course.monthlyPerformance).toStringAsFixed(1)}%",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CoursePerformance {
  final String courseName;
  final String teacherName;
  final List<AssignmentPerformance> monthlyPerformance;

  CoursePerformance({
    required this.courseName,
    required this.teacherName,
    required this.monthlyPerformance,
  });
}
