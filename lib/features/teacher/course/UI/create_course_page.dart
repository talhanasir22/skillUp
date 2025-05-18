import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';
import 'package:skill_up/shared/course_annoucement_banner.dart';


class CreateCoursePage extends StatefulWidget {
  const CreateCoursePage({super.key});

  @override
  State<CreateCoursePage> createState() => _CreateCoursePageState();
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? selectedCategory;
  File? _selectedImage;

  final List<String> _tags = ['MATH', 'SCIENCE', 'ENGINEERING', 'TECHNOLOGY'];

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final extension = file.path.split('.').last.toLowerCase();
      if (['jpg', 'jpeg', 'png'].contains(extension)) {
        setState(() {
          _selectedImage = file;
        });
      } else {
        Fluttertoast.showToast(
          msg: "Only PNG or JPEG images are allowed.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  void _generateThumbnailAI() {
    Fluttertoast.showToast(
      msg: "AI Thumbnail Generation Coming Soon!",
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 6),
      child: Text(
        text,
        style: AppText.mainSubHeadingTextStyle().copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    int maxLines = 1,
    int maxLength = 100,
    String hint = "Enter here",
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppText.hintTextStyle(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "This field cannot be empty";
        }
        return null;
      },
    );
  }

  Widget _buildTagDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      items: _tags.map((tag) {
        return DropdownMenuItem<String>(
          value: tag,
          child: Text(tag),
        );
      }).toList(),
      onChanged: (value) => setState(() => selectedCategory = value),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      validator: (value) => value == null ? "Please select a course tag" : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tell us what you want to teach", style: AppText.mainHeadingTextStyle(),maxLines: 2,),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
         padding: EdgeInsets.only(left: 6.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseAnnouncementBanner(
                bannerText: "Explore a diverse selection of STEM courses for a comprehensive learning experience.",
              ),
              Center(child: Text("Add your Course", style: AppText.mainHeadingTextStyle().copyWith(fontSize: 19))),

              _buildLabel("Course Title"),
              _buildTextField(controller: _titleController, maxLength: 50),

              _buildLabel("Course Description"),
              _buildTextField(controller: _descriptionController, maxLines: 3, maxLength: 200),

              _buildLabel("Course Price (in USD)"),
              _buildTextField(controller: _priceController, maxLength: 6, inputType: TextInputType.number),

              _buildLabel("Course Tag"),
              _buildTagDropdown(),

              _buildLabel("Course Thumbnail"),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.attach_file_outlined),
                    label: Text("Upload Image"),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.auto_awesome, color: Colors.deepPurple),
                    onPressed: _generateThumbnailAI,
                    tooltip: "Generate Thumbnail with AI",
                  ),
                ],
              ),
              if (_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _selectedImage!.path.split('/').last,
                    style: TextStyle(color: Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedImage == null) {
                        Fluttertoast.showToast(
                          msg: "Please select a course thumbnail.",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }
                      if (selectedCategory == null) {
                        Fluttertoast.showToast(
                          msg: "Please select a course tag.",
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }
                      Fluttertoast.showToast(
                        msg: "Course Data Captured (UI-only)",
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bgColor,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Submit", style: AppText.buttonTextStyle().copyWith(color: AppColors.theme)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
