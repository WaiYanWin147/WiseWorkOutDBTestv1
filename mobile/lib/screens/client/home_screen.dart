import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/client/menu_item.dart';
import '../../theme/app_theme.dart';
import '../../widgets/client/calorie_ring.dart';
import '../../widgets/client/section_card.dart';
import 'achievements_screen.dart';
import 'fitness_plan_screen.dart';
import 'leaderboard_screen.dart';
import 'log_meal_screen.dart';
import 'progress_screen.dart';
import 'saved_plans_screen.dart';
import 'workout_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          _header(),
          const SizedBox(height: 20),
          _dailyProgress(),
          const SizedBox(height: 16),
          _todaysPlan(context),
          const SizedBox(height: 16),
          _quickActions(context),
          const SizedBox(height: 16),
          _menuList(context),
        ],
      ),
    );
  }

  Widget _header() {
    return const Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MockData.dateLabel,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Hello, ${MockData.userName}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primarySoft,
          child: Icon(Icons.person, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _dailyProgress() {
    return SectionCard(
      color: AppColors.cardMuted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your daily progress',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _statTile(
                      icon: Icons.directions_walk,
                      iconColor: AppColors.primary,
                      iconBg: AppColors.primarySoft,
                      label: 'Steps',
                      value: '${MockData.steps}',
                    ),
                    const SizedBox(height: 10),
                    _statTile(
                      icon: Icons.favorite,
                      iconColor: AppColors.red,
                      iconBg: const Color(0xFFFDE8E8),
                      label: 'Heart Rate',
                      value: '${MockData.heartRate}',
                      unit: 'bpm',
                    ),
                    const SizedBox(height: 10),
                    _statTile(
                      icon: Icons.fitness_center,
                      iconColor: Colors.white,
                      iconBg: AppColors.dark,
                      label: 'Weekly Volume',
                      value: '${MockData.weeklyVolume}',
                      unit: 'kg',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              const CalorieRing(
                value: MockData.kcalBurned,
                goal: MockData.kcalGoal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
    String? unit,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: AppTheme.cardDecoration(radius: 14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: AppColors.textPrimary),
                  children: [
                    TextSpan(
                      text: value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (unit != null)
                      TextSpan(
                        text: ' $unit',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _todaysPlan(BuildContext context) {
    return SectionCard(
      color: AppColors.primarySoft,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.calendar_month, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Plan",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  MockData.todaysPlanTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  MockData.todaysPlanMeta,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FitnessPlanScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Start Now',
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w700)),
                Icon(Icons.chevron_right, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _actionCard(
            icon: Icons.fitness_center,
            iconBg: AppColors.primarySoft,
            iconColor: AppColors.primary,
            label: 'Log Workout',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const FitnessPlanScreen()),
              );
            },
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _actionCard(
            icon: Icons.restaurant,
            iconBg: const Color(0xFFEFF7DC),
            iconColor: AppColors.green,
            label: 'Log Meal',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LogMealScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _menuList(BuildContext context) {
    return SectionCard(
      color: AppColors.cardMuted,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            for (var i = 0; i < MockData.homeMenu.length; i++) ...[
              _menuRow(context, MockData.homeMenu[i]),
              if (i != MockData.homeMenu.length - 1)
                const Divider(height: 1, color: AppColors.border),
            ],
          ],
        ),
      ),
    );
  }

  void _openMenuItem(BuildContext context, String label) {
    final screens = <String, Widget Function()>{
      'Progress': () => const ProgressScreen(),
      'Leaderboard': () => const LeaderboardScreen(),
      'My Achievements': () => const AchievementsScreen(),
      'Saved Workout Plans': () => const SavedPlansScreen(),
      'Workout History': () => const WorkoutHistoryScreen(),
    };
    final builder = screens[label];
    if (builder != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => builder()));
    }
  }

  Widget _menuRow(BuildContext context, MenuItem item) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.primarySoft,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(item.icon, size: 20, color: AppColors.primary),
      ),
      title: Text(
        item.label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      trailing:
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
      onTap: () => _openMenuItem(context, item.label),
    );
  }
}
