import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/shared/course_annoucement_banner.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  String? selectedCategory;
  String? selectedDuration;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  int selectedTabIndex = 0;

  final List<String> categories = ['SCIENCE', 'TECHNOLOGY', 'ENGINEERING', 'MATH'];
  final List<String> durations = [
    "0-2 Hours",
    "3-8 Hours",
    "8-14 Hours",
    "14-20 Hours",
    "20-24 Hours",
    "24-30 Hours"
  ];

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() => setState(() {}));
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
                    _buildFilterSection("Categories", categories, selectedCategory, (value) {
                      setModalState(() {
                        selectedCategory = selectedCategory == value ? null : value;
                      });
                    }),
                    const SizedBox(height: 16),
                    _buildFilterSection("Duration", durations, selectedDuration, (value) {
                      setModalState(() {
                        selectedDuration = selectedDuration == value ? null : value;
                      });
                    }),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(width: 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              backgroundColor: AppColors.bgColor,
                            ),
                            child: const Text("Clear", style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
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

  Widget _buildFilterSection(String label, List<String> options, String? selected, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.mainHeadingTextStyle().copyWith(fontSize: 16, color: AppColors.theme)),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: options.map((option) {
            bool isSelected = option == selected;
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.bgColor),
                ),
                child: Text(
                  option,
                  style: TextStyle(color: isSelected ? AppColors.bgColor : Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabTitles = ["All", "Science", "Technology", "Engineering", "Mathematics"];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
        title: Text("Find your course", style: AppText.mainHeadingTextStyle()),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 40,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => searchQuery = value),
                  style: const TextStyle(fontSize: 14),
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
                itemCount: tabTitles.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 16 : 8, right: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => selectedTabIndex = index);
                        _tabController.animateTo(index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedTabIndex == index ? Colors.black : Colors.white,
                        foregroundColor: selectedTabIndex == index ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(tabTitles[index]),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  color: AppColors.theme,
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Container(
                      height: 80,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                    ),
                    title: Text(
                      'Sample Course ${index + 1}',
                      style: AppText.mainSubHeadingTextStyle().copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.person, size: 12),
                        const SizedBox(width: 5),
                        const Flexible(child: Text('Teacher Name', overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12))),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xffFFEBF0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('0-2h', style: TextStyle(color: Color(0xffFF6905))),
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      height: 30,
                      width: 95,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.bgColor),
                        child: Text("Enroll Now", style: AppText.buttonTextStyle().copyWith(fontSize: 10)),
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
