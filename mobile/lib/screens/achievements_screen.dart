import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/achievement.dart';
import '../theme/app_theme.dart';
import '../widgets/sub_screen_scaffold.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achieved =
        MockData.achievements.where((a) => a.achieved).toList();
    final unachieved =
        MockData.achievements.where((a) => !a.achieved).toList();
    return SubScreenScaffold(
      title: 'My Achievements',
      children: [
        const Text(
          'Achieved',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        _badgeGrid(achieved, achieved: true),
        const SizedBox(height: 24),
        const Text(
          'Unachieved',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        _badgeGrid(unachieved, achieved: false),
      ],
    );
  }

  Widget _badgeGrid(List<Achievement> items, {required bool achieved}) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [for (final item in items) _badge(item, achieved)],
    );
  }

  Widget _badge(Achievement item, bool achieved) {
    return Container(
      width: 96,
      height: 96,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardMuted,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            size: 30,
            color: achieved ? AppColors.amber : AppColors.textMuted,
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: achieved ? AppColors.textPrimary : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
