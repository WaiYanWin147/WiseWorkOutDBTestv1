import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/professional.dart';
import '../models/workout_plan.dart';
import '../theme/app_theme.dart';
import '../widgets/filter_chips.dart';
import '../widgets/plan_card.dart';
import '../widgets/section_card.dart';
import '../widgets/section_header.dart';
import 'chat_list_screen.dart';
import 'plan_detail_screen.dart';
import 'professional_detail_screen.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _topTab = 0;
  String _filter = 'All';
  String _proFilter = 'All';
  bool _fpUnlocked = false;
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
    final showChatFab = _topTab == 1 && _fpUnlocked;
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding,
              16,
              AppSpacing.screenPadding,
              24,
            ),
            children: [
              _topToggle(),
              const SizedBox(height: 22),
              if (_topTab == 0)
                ..._workoutTab()
              else if (_fpUnlocked)
                ..._professionalsTab()
              else
                _professionalTab(),
            ],
          ),
          if (showChatFab)
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const ChatListScreen()),
                  );
                },
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.chat_bubble_outline,
                    color: Colors.white),
              ),
            ),
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
        onTap: () => _openPlan(_activePlan.title),
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
          onTap: () => _openPlan(plan.title),
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

  void _openPlan(String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PlanDetailScreen(title: title)),
    );
  }

  List<Widget> _professionalsTab() {
    return [
      TextField(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search fitness professionals',
          hintStyle:
              const TextStyle(fontSize: 13, color: AppColors.textMuted),
          suffixIcon: const Icon(Icons.search,
              size: 20, color: AppColors.textMuted),
          filled: true,
          fillColor: AppColors.cardMuted,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      const SizedBox(height: 20),
      const SectionHeader('More Fitness Professionals'),
      const SizedBox(height: 12),
      FilterChips(
        options: MockData.professionalFilters,
        selected: _proFilter,
        onSelected: (value) => setState(() => _proFilter = value),
      ),
      const SizedBox(height: 16),
      for (final pro in MockData.professionals) ...[
        _professionalCard(pro),
        const SizedBox(height: 12),
      ],
    ];
  }

  Widget _professionalCard(Professional pro) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProfessionalDetailScreen(professional: pro),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardMuted,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primarySoft,
              child: Icon(Icons.person, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pro.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    pro.specialties,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 14, color: AppColors.amber),
                      const SizedBox(width: 2),
                      Text(
                        '${pro.rating}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${pro.reviewCount} Reviews',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
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
                  onPressed: () => setState(() => _fpUnlocked = true),
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
