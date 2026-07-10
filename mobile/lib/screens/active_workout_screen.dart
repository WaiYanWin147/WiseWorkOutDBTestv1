import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/exercise.dart';
import '../theme/app_theme.dart';
import '../widgets/sub_screen_scaffold.dart';
import 'workout_complete_screen.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  late final Map<int, List<ExerciseSet>> _sets;

  @override
  void initState() {
    super.initState();
    _sets = {
      for (var i = 0; i < MockData.dayExercises.length; i++)
        i: List.generate(3, (_) => ExerciseSet()),
    };
  }

  @override
  Widget build(BuildContext context) {
    return SubScreenScaffold(
      title: MockData.currentDayLabel,
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          '12:38',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
      bottomButton: PrimaryButton(
        label: 'Finish Workout',
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const WorkoutCompleteScreen()),
          );
        },
      ),
      children: [
        for (var i = 0; i < MockData.dayExercises.length; i++) ...[
          _exerciseCard(i),
          const SizedBox(height: 14),
        ],
      ],
    );
  }

  Widget _exerciseCard(int index) {
    final exercise = MockData.dayExercises[index];
    final sets = _sets[index]!;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardMuted,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.fitness_center,
                    size: 18, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      exercise.meta,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.help_outline,
                  size: 18, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              SizedBox(
                width: 30,
                child: Text('SET', style: _headerStyle),
              ),
              Expanded(child: Text('KG', style: _headerStyle)),
              SizedBox(width: 10),
              Expanded(child: Text('REPS', style: _headerStyle)),
              SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 6),
          for (var s = 0; s < sets.length; s++) _setRow(sets[s], s),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
    letterSpacing: 0.5,
  );

  Widget _setRow(ExerciseSet set, int number) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '${number + 1}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(child: _setField(initial: set.kg, onChanged: (v) => set.kg = v)),
          const SizedBox(width: 10),
          Expanded(
              child: _setField(initial: set.reps, onChanged: (v) => set.reps = v)),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => setState(() => set.done = !set.done),
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: set.done ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: set.done ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: set.done
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _setField({required String initial, required ValueChanged<String> onChanged}) {
    return SizedBox(
      height: 36,
      child: TextFormField(
        initialValue: initial,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          filled: true,
          fillColor: AppColors.card,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
