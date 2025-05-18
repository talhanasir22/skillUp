import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';

class ManageCoursePage extends StatefulWidget {
  const ManageCoursePage({super.key});

  @override
  State<ManageCoursePage> createState() => _ManageCoursePageState();
}

class _ManageCoursePageState extends State<ManageCoursePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  // File selection state
  File? selectedVideo;
  File? selectedPdf;

  // Form keys for validation
  final _videoFormKey = GlobalKey<FormState>();
  final _pdfFormKey = GlobalKey<FormState>();
  final _liveFormKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController videoTitleController = TextEditingController();
  final TextEditingController videoDescriptionController = TextEditingController();
  final TextEditingController pdfTitleController = TextEditingController();
  final TextEditingController pdfDescriptionController = TextEditingController();
  final TextEditingController liveTitleController = TextEditingController();
  final TextEditingController liveDescriptionController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    videoTitleController.dispose();
    videoDescriptionController.dispose();
    pdfTitleController.dispose();
    pdfDescriptionController.dispose();
    liveTitleController.dispose();
    liveDescriptionController.dispose();
    super.dispose();
  }

  Future<void> pickVideo() async {
    setState(() => _isLoading = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedVideo = File(result.files.single.path!);
        });
      }
    } catch (e) {
      _showErrorToast("Failed to pick video: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> pickPdf() async {
    setState(() => _isLoading = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedPdf = File(result.files.single.path!);
        });
      }
    } catch (e) {
      _showErrorToast("Failed to pick PDF: ${e.toString()}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.descriptionTextStyle()),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.bgColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildFilePicker({
    required String label,
    required VoidCallback onTap,
    required File? file,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.descriptionTextStyle()),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(icon, size: 24, color: AppColors.bgColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    file != null ? file.path.split('/').last : "Select $label",
                    style: file != null
                        ? AppText.mainSubHeadingTextStyle().copyWith(fontWeight: FontWeight.w500)
                        : AppText.hintTextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (file != null)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => setState(() {
                      if (file == selectedVideo) {
                        selectedVideo = null;
                      } else if (file == selectedPdf) {
                        selectedPdf = null;
                      }
                    }),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isPrimary = true,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.bgColor : Colors.white,
        foregroundColor: isPrimary ? AppColors.theme : AppColors.bgColor,
        elevation: isPrimary ? 2 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isPrimary ? Colors.transparent : AppColors.bgColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: AppText.buttonTextStyle().copyWith(
              color: isPrimary ? AppColors.theme : AppColors.bgColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: AppText.hintTextStyle(),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildLessonCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Video thumbnail (placeholder)
              const ColoredBox(color: Colors.black54),
              
              // Play button overlay
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.bgColor.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.theme,
                    size: 36,
                  ),
                ),
              ),
              
              // Video title and duration
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Lesson ${index + 1}: Introduction to Topic",
                          style: AppText.mainSubHeadingTextStyle().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "10:30",
                        style: AppText.mainSubHeadingTextStyle().copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Options button
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {
                      // Show options menu
                      _showLessonOptions(index);
                    },
                    iconSize: 20,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLessonOptions(int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Lesson'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement edit functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('View Analytics'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement analytics view
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                _confirmDeleteLesson(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteLesson(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lesson'),
        content: Text('Are you sure you want to delete Lesson ${index + 1}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement delete functionality
              _showSuccessToast('Lesson deleted successfully');
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _videoTab() {
    return Form(
      key: _videoFormKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTextField(
            controller: videoTitleController,
            label: "Lesson Name",
            hint: "Enter descriptive title",
          ),
          _buildTextField(
            controller: videoDescriptionController,
            label: "Lesson Description",
            hint: "Enter detailed description",
            maxLines: 3,
          ),
          _buildFilePicker(
            label: "Upload Video",
            onTap: pickVideo,
            file: selectedVideo,
            icon: Icons.videocam,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                text: "Create Lesson",
                onPressed: () {
                  if (_videoFormKey.currentState!.validate()) {
                    if (selectedVideo == null) {
                      _showErrorToast("Please select a video");
                      return;
                    }
                    // TODO: Implement create lesson logic
                    _showSuccessToast("Video lesson created successfully");
                  }
                },
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDividerWithText("OR"),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                text: "Generate Lesson with AI",
                onPressed: () {
                  _showSuccessToast("AI Lesson Generation coming soon");
                },
                icon: Icons.smart_toy,
                isPrimary: false,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            "Your Video Lessons",
            style: AppText.mainSubHeadingTextStyle(),
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            ...List.generate(5, (index) => _buildLessonCard(index)),
        ],
      ),
    );
  }

  Widget _pdfTab() {
    return Form(
      key: _pdfFormKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTextField(
            controller: pdfTitleController,
            label: "Document Title",
            hint: "Enter document title",
          ),
          _buildTextField(
            controller: pdfDescriptionController,
            label: "Document Description",
            hint: "Enter document description",
            maxLines: 3,
          ),
          _buildFilePicker(
            label: "Upload PDF",
            onTap: pickPdf,
            file: selectedPdf,
            icon: Icons.picture_as_pdf,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                text: "Create Document",
                onPressed: () {
                  if (_pdfFormKey.currentState!.validate()) {
                    if (selectedPdf == null) {
                      _showErrorToast("Please select a PDF");
                      return;
                    }
                    // TODO: Implement create document logic
                    _showSuccessToast("PDF document created successfully");
                  }
                },
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildDividerWithText("OR"),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(
                text: "Generate Document with AI",
                onPressed: () {
                  _showSuccessToast("AI Document Generation coming soon");
                },
                icon: Icons.smart_toy,
                isPrimary: false,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            "Your PDF Documents",
            style: AppText.mainSubHeadingTextStyle(),
          ),
          const SizedBox(height: 16),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.bgColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.picture_as_pdf,
                        color: AppColors.bgColor,
                      ),
                    ),
                    title: Text(
                      "Document ${index + 1}",
                      style: AppText.mainSubHeadingTextStyle().copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "Created on May ${10 + index}, 2025",
                      style: AppText.mainSubHeadingTextStyle().copyWith(color: Colors.grey),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // Show options for PDF
                      },
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _liveTab() {
    return Form(
      key: _liveFormKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTextField(
            controller: liveTitleController,
            label: "Live Session Title",
            hint: "Enter session title",
          ),
          _buildTextField(
            controller: liveDescriptionController,
            label: "Session Description",
            hint: "Describe what you'll cover in this session",
            maxLines: 3,
          ),
          const SizedBox(height: 8),
          
          // Date and time picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Schedule Session", style: AppText.descriptionTextStyle()),
              const SizedBox(height: 8),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // Show date picker
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Select Date",
                                style: AppText.hintTextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // Show time picker
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                "Select Time",
                                style: AppText.hintTextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Duration picker
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Session Duration", style: AppText.descriptionTextStyle()),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("Select Duration", style: AppText.hintTextStyle()),
                    value: null,
                    onChanged: (String? newValue) {
                      // Handle duration selection
                    },
                    items: <String>['30 minutes', '45 minutes', '60 minutes', '90 minutes']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          _buildActionButton(
            text: "Schedule Live Session",
            onPressed: () {
              if (_liveFormKey.currentState!.validate()) {
                // TODO: Implement schedule logic
                _showSuccessToast("Live session scheduled successfully");
              }
            },
            icon: Icons.event,
          ),
          const SizedBox(height: 10),
          _buildActionButton(
            text: "Go Live Now",
            onPressed: () {
              if (_liveFormKey.currentState!.validate()) {
                _showSuccessToast("Live session feature coming soon");
              }
            },
            icon: Icons.live_tv,
            isPrimary: false,
          ),
          const SizedBox(height: 32),
          
          // Upcoming sessions
          Text(
            "Upcoming Live Sessions",
            style: AppText.mainSubHeadingTextStyle(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.bgColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.live_tv,
                        color: AppColors.bgColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Introduction to UI Design",
                            style: AppText.mainSubHeadingTextStyle().copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "May 20, 2025 • 2:00 PM • 60 minutes",
                            style: AppText.hintTextStyle().copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  "Scheduled for tomorrow. Don't forget to prepare your materials!",
                  style: AppText.mainSubHeadingTextStyle(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // Edit session
                      },
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text("Edit"),
                    ),
                    const SizedBox(width: 12),
                    TextButton.icon(
                      onPressed: () {
                        // Cancel session
                      },
                      icon: const Icon(Icons.cancel_outlined, size: 18, color: Colors.red),
                      label: const Text("Cancel", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: AppColors.theme,),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.bgColor,
        title: Text("Lecture Tools", style: AppText.mainHeadingTextStyle().copyWith(fontSize: 18,color: AppColors.theme),),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: AppColors.theme),
            onPressed: () {
              // Show help dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Help"),
                  content: const Text(
                    "This page allows you to create and manage your course materials. "
                    "You can upload videos, PDFs, and schedule live sessions. "
                    "Use the tabs to navigate between different types of content.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Got it"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.theme,
          unselectedLabelColor: Colors.white70,
          indicatorColor: AppColors.theme,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "Videos"),
            Tab(text: "PDFs"),
            Tab(text: "Live"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _videoTab(),
          _pdfTab(),
          _liveTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show quick options menu
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Quick Add",
                    style: AppText.mainSubHeadingTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickAddButton(
                        context: context,
                        icon: Icons.videocam,
                        label: "Video",
                        onTap: () {
                          Navigator.pop(context);
                          _tabController.animateTo(0);
                        },
                      ),
                      _buildQuickAddButton(
                        context: context,
                        icon: Icons.picture_as_pdf,
                        label: "PDF",
                        onTap: () {
                          Navigator.pop(context);
                          _tabController.animateTo(1);
                        },
                      ),
                      _buildQuickAddButton(
                        context: context,
                        icon: Icons.live_tv,
                        label: "Live",
                        onTap: () {
                          Navigator.pop(context);
                          _tabController.animateTo(2);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: AppColors.bgColor,
        child: Icon(Icons.add, color: AppColors.theme),
      ),
    );
  }
  
  Widget _buildQuickAddButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 32,
              color: AppColors.bgColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppText.mainSubHeadingTextStyle().copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}