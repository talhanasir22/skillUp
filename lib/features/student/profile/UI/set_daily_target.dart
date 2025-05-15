import 'package:flutter/material.dart';
import 'package:skill_up/Core/app_color.dart';
import 'package:skill_up/Core/app_text.dart';


class SetDailyTargetScreen extends StatefulWidget {
  const SetDailyTargetScreen({super.key});

  @override
  State<SetDailyTargetScreen> createState() => _SetDailyTargetScreenState();
}

class _SetDailyTargetScreenState extends State<SetDailyTargetScreen> {
  final List<int> targetOptions = [30, 60, 90, 120, 150, 180];
  int? selectedTarget;

  void _saveTarget() {
    if (selectedTarget != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Daily target set to $selectedTarget minutes!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Set Daily Target",
          style: AppText.mainHeadingTextStyle().copyWith(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How many minutes do you want to study daily?",
              style: AppText.mainSubHeadingTextStyle(),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelText: "Select Target (minutes)",
              ),
              value: selectedTarget,
              items: targetOptions
                  .map((min) => DropdownMenuItem(
                        value: min,
                        child: Text("$min minutes"),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTarget = value;
                });
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _saveTarget,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bgColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save Target",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
