import 'package:flutter/material.dart';

import '../models/menu_item.dart';
import '../models/nutrition.dart';
import '../models/workout_plan.dart';
import '../theme/app_theme.dart';

class MockData {
  // Home
  static const String userName = 'Christopher';
  static const String dateLabel = 'Saturday 23 May';

  static const int steps = 4580;
  static const int heartRate = 108;
  static const int weeklyVolume = 1200;
  static const int kcalBurned = 330;
  static const int kcalGoal = 500;

  static const String todaysPlanTitle = 'Full Body Strength';
  static const String todaysPlanMeta = '~45 min • 6 exercises';

  static const List<MenuItem> homeMenu = [
    MenuItem(label: 'Progress', icon: Icons.track_changes),
    MenuItem(label: 'Leaderboard', icon: Icons.groups),
    MenuItem(label: 'My Achievements', icon: Icons.emoji_events),
    MenuItem(label: 'Saved Workout Plans', icon: Icons.bookmark),
    MenuItem(label: 'Workout History', icon: Icons.history),
  ];

  // Workout
  static const List<String> workoutFilters = [
    'All',
    'Nutrition',
    'Strength',
    'Weight Loss',
    'HIIT',
  ];

  static WorkoutPlan activePlan() => WorkoutPlan(
        title: '30-Day Full Body Fat Burn',
        duration: '30 Days',
        sessionLength: '~45 min',
        tags: const ['Full Body', 'Fat Loss', 'Strength'],
        active: true,
        bookmarked: true,
        categories: const ['Strength', 'Weight Loss'],
      );

  static List<WorkoutPlan> freePlans() => [
        WorkoutPlan(
          title: '30-Day Full Body Fat Burn',
          duration: '30 Days',
          sessionLength: '~45 min',
          tags: const ['Full Body', 'Fat Loss', 'Strength'],
          categories: const ['Strength', 'Weight Loss'],
        ),
        WorkoutPlan(
          title: 'Beginner HIIT',
          duration: '30 Days',
          sessionLength: '~45 min',
          tags: const ['Full Body', 'Fat Loss', 'Strength'],
          categories: const ['HIIT', 'Weight Loss'],
        ),
        WorkoutPlan(
          title: 'Morning Yoga',
          duration: '30 Days',
          sessionLength: '~45 min',
          tags: const ['Full Body', 'Fat Loss', 'Strength'],
          categories: const ['Nutrition'],
        ),
        WorkoutPlan(
          title: 'Upper Body Blast',
          duration: '30 Days',
          sessionLength: '~45 min',
          tags: const ['Full Body', 'Fat Loss', 'Strength'],
          categories: const ['Strength'],
        ),
      ];

  // Nutrition
  static const int caloriesConsumed = 730;
  static const int caloriesGoal = 1600;

  static const List<Macro> macros = [
    Macro(name: 'Protein', current: 62, target: 108, color: AppColors.red),
    Macro(name: 'Carbs', current: 92, target: 180, color: AppColors.cyan),
    Macro(name: 'Fat', current: 37, target: 60, color: AppColors.green),
  ];

  static const int waterConsumed = 900;
  static const int waterGoal = 2000;

  static const List<Meal> meals = [
    Meal(
      name: 'Breakfast',
      calories: 685,
      protein: 39,
      carbs: 92,
      fat: 32,
      icon: Icons.breakfast_dining,
    ),
    Meal(
      name: 'Lunch',
      calories: 540,
      protein: 34,
      carbs: 61,
      fat: 18,
      icon: Icons.lunch_dining,
    ),
  ];
}
