import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/client/workout_plan.dart';
import '../../theme/app_theme.dart';
import '../../widgets/client/pill_tag.dart';
import '../../widgets/client/sub_screen_scaffold.dart';

class SavedPlansScreen extends StatefulWidget {
  const SavedPlansScreen({super.key});

  @override
  State<SavedPlansScreen> createState() => _SavedPlansScreenState();
}

class _SavedPlansScreenState extends State<SavedPlansScreen> {
  late final List<WorkoutPlan> _plans;

  @override
  void initState() {
    super.initState();
    _plans = MockData.savedPlans();
  }

  @override
  Widget build(BuildContext context) {
    return SubScreenScaffold(
      title: 'Saved Workout Plans',
      children: [
        for (final plan in _plans) ...[
          _planCard(plan),
          const SizedBox(height: 14),
        ],
      ],
    );
  }

  Widget _planCard(WorkoutPlan plan) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardMuted,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            '${plan.duration} • ${plan.sessionLength}',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final t in plan.tags) PillTag(t)],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Created By ${plan.createdBy}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    setState(() => plan.bookmarked = !plan.bookmarked),
                child: Icon(
                  plan.bookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
