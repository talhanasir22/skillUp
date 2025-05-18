import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/shared/course_annoucement_banner.dart';

class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({super.key});

  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> with SingleTickerProviderStateMixin {
  String? selectedCategory;
  String? selectedDuration;
  late TabController _tabController;
  int selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final List<String> categories = ['SCIENCE', 'TECHNOLOGY', 'ENGINEERING', 'MATH'];
  final List<String> durations = [
    "0-2 Hours",
    "3-8 Hours",
    "8-14 Hours",
    "14-20 Hours",
    "20-24 Hours",
    "24-30 Hours"
  ];

  final List<Map<String, String>> mockCourses = List.generate(10, (index) {
    return {
      'courseTitle': 'Sample Course ${index + 1}',
      'teacherName': 'Teacher ${index + 1}',
      'thumbnailUrl': 'https://via.placeholder.com/100',
      'duration': '0-2h'
    };
  });

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Search Filter",
                        style: AppText.mainHeadingTextStyle().copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                          color: AppColors.theme,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Categories",
                      style: AppText.mainHeadingTextStyle().copyWith(
                        color: AppColors.theme,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: categories.map((category) {
                        bool isSelected = category == selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedCategory = isSelected ? null : category;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.bgColor),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? AppColors.bgColor : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Duration",
                      style: AppText.mainHeadingTextStyle().copyWith(
                        color: AppColors.theme,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: durations.map((duration) {
                        bool isSelected = duration == selectedDuration;
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedDuration = isSelected ? null : duration;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.bgColor),
                            ),
                            child: Text(
                              duration,
                              style: TextStyle(
                                color: isSelected ? AppColors.bgColor : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(width: 1),
                              backgroundColor: AppColors.bgColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text("Clear", style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text("Apply Filter", style: TextStyle(color: AppColors.bgColor)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCourses = mockCourses.where((course) {
      final title = course['courseTitle']!.toLowerCase();
      return title.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Choose Your Course", style: AppText.mainHeadingTextStyle()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Find Course",
                hintStyle: AppText.hintTextStyle(),
                prefixIcon: Icon(Icons.search, color: AppColors.hintIconColor),
                suffixIcon: IconButton(
                  onPressed: _showFilterBottomSheet,
                  icon: Icon(Icons.tune_rounded, color: AppColors.hintIconColor),
                ),
                filled: true,
                fillColor: AppColors.textFieldColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
              ),
            ),
          ),
          const CourseAnnouncementBanner(
            bannerText: "Explore a diverse selection of STEM courses for a comprehensive learning experience.",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  List<String> tabTitles = [
                    "All",
                    "Science",
                    "Technology",
                    "Engineering",
                    "Mathematics"
                  ];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 16 : 8,
                      right: 8,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedTabIndex = index;
                        });
                        _tabController.animateTo(index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _tabController.index == index
                            ? Colors.black
                            : Colors.white,
                        foregroundColor: _tabController.index == index
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(tabTitles[index]),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                var course = filteredCourses[index];
                return Card(
                  color: AppColors.theme,
                  elevation: 1,
                  shadowColor: Colors.grey,
                  child: ListTile(
                    leading: Container(
                      height: 80,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(course['thumbnailUrl']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      course['courseTitle']!,
                      style: AppText.mainSubHeadingTextStyle().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.person, size: 12),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            course['teacherName']!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFFEBF0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            course['duration']!,
                            style: const TextStyle(color: Color(0xffFF6905)),
                          ),
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      height: 30,
                      width: 95,
                      child: ElevatedButton(
                        onPressed: () {
                          // Simulate button action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enroll button tapped")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bgColor,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          "Enroll Now",
                          style: AppText.buttonTextStyle().copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
