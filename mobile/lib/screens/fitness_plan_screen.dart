import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/sub_screen_scaffold.dart';
import 'active_workout_screen.dart';

class FitnessPlanScreen extends StatefulWidget {
  const FitnessPlanScreen({super.key});

  @override
  State<FitnessPlanScreen> createState() => _FitnessPlanScreenState();
}

class _FitnessPlanScreenState extends State<FitnessPlanScreen> {
  int _selectedDay = 3;

  static const _days = [
    ('WED', '30'),
    ('THU', '30'),
    ('FRI', '31'),
    ('SAT', '1'),
    ('SUN', '2'),
    ('MON', '3'),
    ('TUE', '4'),
  ];

  @override
  Widget build(BuildContext context) {
    return SubScreenScaffold(
      title: 'My Fitness Plan',
      bottomButton: PrimaryButton(
        label: 'Start Workout',
        icon: Icons.chevron_right,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ActiveWorkoutScreen()),
          );
        },
      ),
      children: [
        _dayStrip(),
        const SizedBox(height: 18),
        _dayBanner(),
        const SizedBox(height: 16),
        for (var i = 0; i < MockData.dayExercises.length; i++) ...[
          _exerciseRow(i),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget _dayStrip() {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final selected = i == _selectedDay;
          return GestureDetector(
            onTap: () => setState(() => _selectedDay = i),
            child: Container(
              width: 52,
              decoration: BoxDecoration(
                color: selected ? AppColors.navBar : AppColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected ? AppColors.navBar : AppColors.border,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _days[i].$1,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white70 : AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _days[i].$2,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: selected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dayBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.calendar_month, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MockData.currentDayLabel,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2),
              Text(
                MockData.currentDayMeta,
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _exerciseRow(int index) {
    final exercise = MockData.dayExercises[index];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardMuted,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                exercise.meta,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
