import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/client/sub_screen_scaffold.dart';

class PlanDetailScreen extends StatefulWidget {
  final String title;

  const PlanDetailScreen({super.key, required this.title});

  @override
  State<PlanDetailScreen> createState() => _PlanDetailScreenState();
}

class _PlanDetailScreenState extends State<PlanDetailScreen> {
  int _week = 0;
  int _day = 0;

  bool get _isRestDay => _day == 2;

  @override
  Widget build(BuildContext context) {
    return SubScreenScaffold(
      title: widget.title,
      bottomButton: PrimaryButton(
        label: 'Switch to this plan',
        onPressed: () => Navigator.of(context).pop(),
      ),
      children: [
        const Text(
          'Week',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        _selectorRow(
          count: 3,
          selected: _week,
          labelBuilder: (i) => ('W', '${i + 1}'),
          onTap: (i) => setState(() => _week = i),
        ),
        const SizedBox(height: 18),
        const Text(
          'Day',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        _selectorRow(
          count: 6,
          selected: _day,
          labelBuilder: (i) => ('DAY', '${i + 1}'),
          onTap: (i) => setState(() => _day = i),
        ),
        const SizedBox(height: 20),
        _dayBanner(),
        const SizedBox(height: 16),
        if (!_isRestDay)
          for (var i = 0; i < 4; i++) ...[
            _exerciseRow(i),
            const SizedBox(height: 10),
          ],
      ],
    );
  }

  Widget _selectorRow({
    required int count,
    required int selected,
    required (String, String) Function(int) labelBuilder,
    required ValueChanged<int> onTap,
  }) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isSelected = i == selected;
          final label = labelBuilder(i);
          return GestureDetector(
            onTap: () => onTap(i),
            child: Container(
              width: 48,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.navBar : AppColors.cardMuted,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label.$1,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white70 : AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label.$2,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color:
                          isSelected ? Colors.white : AppColors.textPrimary,
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
    final title = 'Day ${_day + 1}: Full Body Strength';
    final meta = _isRestDay ? 'Rest Day' : '~45 min • 6 exercises';
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
            child:
                const Icon(Icons.calendar_month, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                meta,
                style: const TextStyle(fontSize: 12, color: Colors.white70),
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
