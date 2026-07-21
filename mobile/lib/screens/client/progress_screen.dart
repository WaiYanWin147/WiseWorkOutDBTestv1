import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/client/section_card.dart';
import '../../widgets/client/sub_screen_scaffold.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _stepsRange = 0;
  int _caloriesRange = 0;

  @override
  Widget build(BuildContext context) {
    return SubScreenScaffold(
      title: 'Progress',
      children: [
        _chartCard(
          title: 'Step Count',
          average: '12,456',
          unit: 'steps',
          values: MockData.weeklySteps,
          barColor: AppColors.primarySoft,
          highlightColor: AppColors.primary,
          selectedRange: _stepsRange,
          onRangeChanged: (i) => setState(() => _stepsRange = i),
        ),
        const SizedBox(height: 16),
        _chartCard(
          title: 'Calories Burned',
          average: '456',
          unit: 'kcal',
          values: MockData.weeklyCalories,
          barColor: const Color(0xFFEFF7DC),
          highlightColor: AppColors.green,
          selectedRange: _caloriesRange,
          onRangeChanged: (i) => setState(() => _caloriesRange = i),
        ),
      ],
    );
  }

  Widget _chartCard({
    required String title,
    required String average,
    required String unit,
    required List<int> values,
    required Color barColor,
    required Color highlightColor,
    required int selectedRange,
    required ValueChanged<int> onRangeChanged,
  }) {
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _rangeToggle(selectedRange, highlightColor, onRangeChanged),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'AVERAGE',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textMuted,
              letterSpacing: 0.5,
            ),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.textPrimary),
              children: [
                TextSpan(
                  text: average,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < values.length; i++) ...[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 100 * values[i] / maxValue,
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          MockData.weekDays[i],
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i != values.length - 1) const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rangeToggle(
      int selected, Color highlightColor, ValueChanged<int> onChanged) {
    const labels = ['W', 'M', '6M', 'Y'];
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++)
          GestureDetector(
            onTap: () => onChanged(i),
            child: Container(
              margin: const EdgeInsets.only(left: 4),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: selected == i ? highlightColor : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: selected == i ? Colors.white : AppColors.textMuted,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
