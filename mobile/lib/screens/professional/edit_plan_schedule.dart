import 'package:flutter/material.dart';

import '../../models/professional/workout_plan.dart';
import '../../widgets/professional/mobile_page_wrapper.dart';
import 'review_plan.dart';
import 'select_exercise.dart';

class EditPlanSchedule extends StatefulWidget {
  final WorkoutPlan plan;
  final String? planName;
  final List<String>? tags;
  final String visibility;

  const EditPlanSchedule({
    super.key,
    required this.plan,
    this.planName,
    this.tags,
    this.visibility = 'Public',
  });

  @override
  State<EditPlanSchedule> createState() => _EditPlanScheduleState();
}

class _EditPlanScheduleState extends State<EditPlanSchedule> {
  int selectedWeek = 1;
  int selectedDay = 1;
  bool markAsRestDay = false;

  late List<Exercise> exercises;

  String get planTitle => widget.planName ?? widget.plan.title;

  @override
  void initState() {
    super.initState();

    exercises = widget.plan.workoutDays.first.exercises.take(3).toList();
  }

  Future<void> addExercise() async {
    final result = await Navigator.push<Exercise>(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectExercise(),
      ),
    );

    if (result != null) {
      setState(() {
        exercises.add(result);
      });
    }
  }

  void editExercise(int index) {
    final exercise = exercises[index];

    final setController = TextEditingController(text: '3');
    final minRepController = TextEditingController(text: '10');
    final maxRepController = TextEditingController(text: '12');
    final restController = TextEditingController(text: '60');

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              width: 430,
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 34,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const _SheetLabel('Set'),
                    const SizedBox(height: 8),
                    _SheetInput(controller: setController),

                    const SizedBox(height: 16),

                    const _SheetLabel('Reps'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _SheetInput(
                            controller: minRepController,
                            hint: 'Min',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _SheetInput(
                            controller: maxRepController,
                            hint: 'Max',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const _SheetLabel('Rest'),
                    const SizedBox(height: 8),
                    _SheetInput(
                      controller: restController,
                      suffixText: 'seconds',
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final newDetail =
                              '${setController.text} × ${minRepController.text}-${maxRepController.text} • ${restController.text}s rest';

                          setState(() {
                            exercises[index] = Exercise(
                              name: exercise.name,
                              detail: newDetail,
                            );
                          });

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void goToReview() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ReviewPlan(
        planName: planTitle,
        tags: widget.tags ?? widget.plan.tags,
        visibility: widget.visibility,
        duration: '${widget.plan.days} days',
        weekNumber: selectedWeek,
        dayNumber: selectedDay,
        dayName: 'Full Body Strength',
        isRestDay: markAsRestDay,
        exercises: exercises,
        buttonText: 'Update Changes',
      ),
    ),
  );
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
                      'Edit: $planTitle',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              const Text(
                'Schedule',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'Week',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  _SmallBox(
                    topText: 'W',
                    number: '1',
                    selected: selectedWeek == 1,
                    onTap: () {
                      setState(() {
                        selectedWeek = 1;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _SmallBox(
                    topText: 'W',
                    number: '2',
                    selected: selectedWeek == 2,
                    onTap: () {
                      setState(() {
                        selectedWeek = 2;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _SmallBox(
                    topText: 'W',
                    number: '3',
                    selected: selectedWeek == 3,
                    onTap: () {
                      setState(() {
                        selectedWeek = 3;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  const _AddSmallBox(),
                ],
              ),

              const SizedBox(height: 18),

              const Text(
                'Day',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  for (int i = 1; i <= 4; i++) ...[
                    _SmallBox(
                      topText: 'DAY',
                      number: '$i',
                      selected: selectedDay == i,
                      onTap: () {
                        setState(() {
                          selectedDay = i;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                  const _AddSmallBox(),
                ],
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFECE9FF),
                      child: Icon(
                        Icons.calendar_month,
                        color: Color(0xFF6C63FF),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Day 1:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Full Body Strength',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 36,
                child: OutlinedButton.icon(
                  onPressed: addExercise,
                  icon: const Icon(Icons.add, size: 17),
                  label: const Text('Add Exercise to This Day'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6C63FF),
                    side: const BorderSide(
                      color: Color(0xFF6C63FF),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return _EditableExerciseCard(
                      number: index + 1,
                      exercise: exercises[index],
                      onEdit: () {
                        editExercise(index);
                      },
                    );
                  },
                ),
              ),

              Row(
                children: [
                  Checkbox(
                    value: markAsRestDay,
                    activeColor: const Color(0xFF6C63FF),
                    onChanged: (value) {
                      setState(() {
                        markAsRestDay = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Mark as Rest Day',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: goToReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
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

class _SmallBox extends StatelessWidget {
  final String topText;
  final String number;
  final bool selected;
  final VoidCallback onTap;

  const _SmallBox({
    required this.topText,
    required this.number,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFF333333) : const Color(0xFFF0F0F0),
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: SizedBox(
          width: 44,
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                topText,
                style: TextStyle(
                  fontSize: 9,
                  color: selected ? Colors.white70 : Colors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                number,
                style: TextStyle(
                  fontSize: 14,
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddSmallBox extends StatelessWidget {
  const _AddSmallBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: Colors.grey.shade400,
          style: BorderStyle.solid,
        ),
      ),
      child: const Icon(
        Icons.add,
        size: 18,
        color: Colors.black54,
      ),
    );
  }
}

class _EditableExerciseCard extends StatelessWidget {
  final int number;
  final Exercise exercise;
  final VoidCallback onEdit;

  const _EditableExerciseCard({
    required this.number,
    required this.exercise,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFECE9FF),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Color(0xFF6C63FF),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  exercise.detail,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: Icon(
              Icons.edit,
              size: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SheetLabel extends StatelessWidget {
  final String text;

  const _SheetLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _SheetInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? suffixText;

  const _SheetInput({
    required this.controller,
    this.hint,
    this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        suffixText: suffixText,
        filled: true,
        fillColor: const Color(0xFFF4F4F5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}