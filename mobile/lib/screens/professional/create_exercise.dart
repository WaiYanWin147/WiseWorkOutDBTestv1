import 'package:flutter/material.dart';

import '../../data/professional/mock_exercises.dart';
import '../../models/professional/workout_plan.dart';
import '../../widgets/professional/mobile_page_wrapper.dart';

class CreateExercise extends StatefulWidget {
  const CreateExercise({super.key});

  @override
  State<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {
  final TextEditingController nameController = TextEditingController(
    text: 'Chest Press (Barbell)',
  );
  final TextEditingController repsController = TextEditingController(
    text: '6 - 8',
  );
  final TextEditingController restController = TextEditingController(
    text: '120',
  );
  final TextEditingController instructionController = TextEditingController(
    text: 'Keep back flat, lower bar to mid-chest...',
  );

  String muscleGroup = 'Chest';
  String equipment = 'Barbell';

  @override
  void dispose() {
    nameController.dispose();
    repsController.dispose();
    restController.dispose();
    instructionController.dispose();
    super.dispose();
  }

  void saveExercise() {
    final name = nameController.text.trim();
    final reps = repsController.text.trim();
    final rest = restController.text.trim();

    if (name.isEmpty) {
      showMessage('Please enter exercise name.');
      return;
    }

    final newExercise = Exercise(
      name: name,
      detail: '3 × $reps • ${rest}s rest',
    );

    Navigator.pop(context, newExercise);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobilePageWrapper(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 26),
          child: Column(
            children: [
              Row(
                children: [
                  _BackButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'New Exercise',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _InputField(
                        label: 'Name',
                        controller: nameController,
                      ),

                      const SizedBox(height: 18),

                      _DropdownField(
                        label: 'Muscle Group',
                        value: muscleGroup,
                        items: muscleGroups.where((item) => item != 'All').toList(),
                        onChanged: (value) {
                          setState(() {
                            muscleGroup = value;
                          });
                        },
                      ),

                      const SizedBox(height: 18),

                      _DropdownField(
                        label: 'Equipment',
                        value: equipment,
                        items: equipmentTypes.where((item) => item != 'All').toList(),
                        onChanged: (value) {
                          setState(() {
                            equipment = value;
                          });
                        },
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: _InputField(
                              label: 'Default reps',
                              controller: repsController,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _InputField(
                              label: 'Rest (sec)',
                              controller: restController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      _InputField(
                        label: 'Instructions',
                        controller: instructionController,
                        maxLines: 3,
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.3,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: Colors.grey.shade600,
                              size: 24,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Add demo image / video',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: saveExercise,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Save Exercise',
                    style: TextStyle(
                      fontSize: 16,
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

class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboardType;

  const _InputField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F2FA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final void Function(String value) onChanged;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F2FA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BackButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        color: Color(0xFFF3F2FA),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: Colors.black54,
        ),
      ),
    );
  }
}