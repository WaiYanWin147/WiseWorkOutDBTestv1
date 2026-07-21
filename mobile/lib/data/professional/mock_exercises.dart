import '../../models/professional/library_exercise.dart';

final List<String> muscleGroups = [
  'All',
  'Abdominals',
  'Abductors',
  'Adductors',
  'Biceps',
  'Calves',
  'Chest',
  'Forearms',
  'Full Body',
  'Glutes',
  'Hamstrings',
  'Lats',
  'Lower Back',
  'Neck',
  'Quadriceps',
  'Shoulders',
  'Traps',
  'Triceps',
  'Upper Back',
];

final List<String> equipmentTypes = [
  'All',
  'None',
  'Barbell',
  'Dumbell',
  'Kettlebell',
  'Plate',
  'Resistance Band',
  'Suspension Band',
];

final List<LibraryExercise> exerciseLibrary = [
  LibraryExercise(
    name: 'Bench Press (Barbell)',
    muscleGroup: 'Chest',
    equipment: 'Barbell',
  ),
  LibraryExercise(
    name: 'Bench Press (Dumbell)',
    muscleGroup: 'Chest',
    equipment: 'Dumbell',
  ),
  LibraryExercise(
    name: 'Bent Over Row (Barbell)',
    muscleGroup: 'Upper Back',
    equipment: 'Barbell',
  ),
  LibraryExercise(
    name: 'Bicep Curl (Dumbell)',
    muscleGroup: 'Biceps',
    equipment: 'Dumbell',
  ),
  LibraryExercise(
    name: 'Deadlift (Barbell)',
    muscleGroup: 'Glutes',
    equipment: 'Barbell',
  ),
  LibraryExercise(
    name: 'Hammer Curl (Dumbell)',
    muscleGroup: 'Biceps',
    equipment: 'Dumbell',
  ),
  LibraryExercise(
    name: 'Incline Bench Press (Dumbell)',
    muscleGroup: 'Chest',
    equipment: 'Dumbell',
  ),
  LibraryExercise(
    name: 'Lateral Raise (Dumbell)',
    muscleGroup: 'Shoulders',
    equipment: 'Dumbell',
  ),
  LibraryExercise(
    name: 'Shoulder Press (Dumbell)',
    muscleGroup: 'Shoulders',
    equipment: 'Dumbell',
  ),
  LibraryExercise(
    name: 'Squat (Barbell)',
    muscleGroup: 'Quadriceps',
    equipment: 'Barbell',
  ),
  LibraryExercise(
    name: 'Triceps Pushdown',
    muscleGroup: 'Triceps',
    equipment: 'Resistance Band',
  ),
];