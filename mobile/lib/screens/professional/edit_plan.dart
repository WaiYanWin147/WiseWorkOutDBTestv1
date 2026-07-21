import 'package:flutter/material.dart';

import '../../models/professional/workout_plan.dart';
import '../../widgets/professional/mobile_page_wrapper.dart';
import 'edit_plan_schedule.dart';

class EditPlan extends StatefulWidget {
  final WorkoutPlan plan;

  const EditPlan({
    super.key,
    required this.plan,
  });

  @override
  State<EditPlan> createState() => _EditPlanState();
}

class _EditPlanState extends State<EditPlan> {
  late TextEditingController planNameController;

  late String tagOne;
  late String tagTwo;
  late String tagThree;
  String visibility = 'Public';

  final List<String> tagOptions = [
    'Full Body',
    'Fat Loss',
    'Strength',
    'Upper Body',
    'Lower Body',
    'Core',
    'Cardio',
    'Beginner',
  ];

  final List<String> visibilityOptions = [
    'Public',
    'Private',
  ];

  @override
  void initState() {
    super.initState();

    planNameController = TextEditingController(
      text: widget.plan.title,
    );

    tagOne = widget.plan.tags.isNotEmpty ? widget.plan.tags[0] : 'Full Body';
    tagTwo = widget.plan.tags.length > 1 ? widget.plan.tags[1] : 'Fat Loss';
    tagThree = widget.plan.tags.length > 2 ? widget.plan.tags[2] : 'Strength';
  }

  @override
  void dispose() {
    planNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobilePageWrapper(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部返回按钮 + 标题
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F2FA),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Text(
                      'Edit: ${widget.plan.title}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 42),

              const Text(
                'Plan Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: planNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF3F2FA),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              RichText(
                text: TextSpan(
                  text: 'Tags ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '(max 3)',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              _EditDropdown(
                value: tagOne,
                items: tagOptions,
                onChanged: (value) {
                  setState(() {
                    tagOne = value;
                  });
                },
              ),

              const SizedBox(height: 8),

              _EditDropdown(
                value: tagTwo,
                items: tagOptions,
                onChanged: (value) {
                  setState(() {
                    tagTwo = value;
                  });
                },
              ),

              const SizedBox(height: 8),

              _EditDropdown(
                value: tagThree,
                items: tagOptions,
                onChanged: (value) {
                  setState(() {
                    tagThree = value;
                  });
                },
              ),

              const SizedBox(height: 34),

              const Text(
                'Visibility',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              _EditDropdown(
                value: visibility,
                items: visibilityOptions,
                onChanged: (value) {
                  setState(() {
                    visibility = value;
                  });
                },
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPlanSchedule(
                          plan: widget.plan,
                          planName: planNameController.text,
                          tags: [tagOne, tagTwo, tagThree],
                          visibility: visibility,
                        ),
                      ),
                   );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(String value) onChanged;

  const _EditDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.black54,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF3F2FA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: Colors.white,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}