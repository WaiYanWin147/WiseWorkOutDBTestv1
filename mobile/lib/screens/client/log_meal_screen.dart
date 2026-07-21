import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/client/sub_screen_scaffold.dart';

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({super.key});

  @override
  State<LogMealScreen> createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  String _mealType = 'Breakfast';

  static const _mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  @override
  Widget build(BuildContext context) {
    return SubScreenScaffold(
      title: 'Log Meal',
      bottomButton: PrimaryButton(
        label: 'Log Meal',
        onPressed: () => Navigator.of(context).pop(),
      ),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: _mealTypeDropdown(),
        ),
        const SizedBox(height: 8),
        _label('Food Name'),
        const SizedBox(height: 8),
        _textField(hint: 'eg. Tuna Poke Bowl'),
        const SizedBox(height: 18),
        _label('Ingredients'),
        const SizedBox(height: 8),
        _textField(hint: 'eg. rice, tuna, green beans', maxLines: 3),
        const SizedBox(height: 18),
        _label('Nutrition Facts'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _factField('Calories', '0 kcal')),
            const SizedBox(width: 12),
            Expanded(child: _factField('Protein', '0g')),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _factField('Carbs', '0g')),
            const SizedBox(width: 12),
            Expanded(child: _factField('Fat', '0g')),
          ],
        ),
        const SizedBox(height: 18),
        _label('Image'),
        const SizedBox(height: 8),
        _imagePicker(),
      ],
    );
  }

  Widget _mealTypeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.cardMuted,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _mealType,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          items: [
            for (final type in _mealTypes)
              DropdownMenuItem(value: type, child: Text(type)),
          ],
          onChanged: (value) {
            if (value != null) setState(() => _mealType = value);
          },
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    );
  }

  Widget _textField({required String hint, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: AppColors.textMuted),
        filled: true,
        fillColor: AppColors.cardMuted,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _factField(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardMuted,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.edit, size: 12, color: AppColors.textMuted),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imagePicker() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Column(
        children: [
          const Icon(Icons.image_outlined,
              size: 32, color: AppColors.textMuted),
          const SizedBox(height: 10),
          const Text(
            'Choose an image to upload (optional)',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Add image',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
