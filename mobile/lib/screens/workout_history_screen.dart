import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/sub_screen_scaffold.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubScreenScaffold(
      title: 'Workout History',
      children: [
        for (final entry in MockData.workoutHistory) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${entry.when}, ${entry.meta}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
