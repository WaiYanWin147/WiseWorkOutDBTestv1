import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/workout_plan.dart';
import '../theme/app_theme.dart';
import '../widgets/filter_chips.dart';
import '../widgets/plan_card.dart';
import '../widgets/section_card.dart';
import '../widgets/section_header.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _topTab = 0;
  String _filter = 'All';
  late final WorkoutPlan _activePlan;
  late final List<WorkoutPlan> _freePlans;

  @override
  void initState() {
    super.initState();
    _activePlan = MockData.activePlan();
    _freePlans = MockData.freePlans();
  }

  List<WorkoutPlan> get _visiblePlans {
    if (_filter == 'All') return _freePlans;
    return _freePlans
        .where((p) => p.categories.contains(_filter))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding,
          16,
          AppSpacing.screenPadding,
          24,
        ),
        children: [
          _topToggle(),
          const SizedBox(height: 22),
          if (_topTab == 0) ..._workoutTab() else _professionalTab(),
        ],
      ),
    );
  }

  Widget _topToggle() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
      ),
      child: Row(
        children: [
          _toggleButton('Workout', 0),
          _toggleButton('Fitness Professional', 1),
        ],
      ),
    );
  }

  Widget _toggleButton(String label, int index) {
    final selected = _topTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _topTab = index),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _workoutTab() {
    return [
      const SectionHeader('Active Plan'),
      const SizedBox(height: 12),
      PlanCard(
        plan: _activePlan,
        onBookmarkTap: () =>
            setState(() => _activePlan.bookmarked = !_activePlan.bookmarked),
      ),
      const SizedBox(height: 24),
      const SectionHeader('Free Plans'),
      const SizedBox(height: 12),
      FilterChips(
        options: MockData.workoutFilters,
        selected: _filter,
        onSelected: (value) => setState(() => _filter = value),
      ),
      const SizedBox(height: 16),
      for (final plan in _visiblePlans) ...[
        PlanCard(
          plan: plan,
          onBookmarkTap: () =>
              setState(() => plan.bookmarked = !plan.bookmarked),
        ),
        const SizedBox(height: 14),
      ],
      if (_visiblePlans.isEmpty)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              'No plans in this category yet.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
    ];
  }

  Widget _professionalTab() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        60,
        AppSpacing.screenPadding,
        24,
      ),
      child: Center(
        child: SectionCard(
          color: AppColors.primarySoft,
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Fitness Professional',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Get personalised workout plans, professional guidance, and direct messaging with fitness experts.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.workspace_premium, size: 18),
                  label: const Text(
                    'Unlock Priority',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
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
