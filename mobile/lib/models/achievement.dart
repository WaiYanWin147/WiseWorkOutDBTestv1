import 'package:flutter/material.dart';

class Achievement {
  final String label;
  final IconData icon;
  final bool achieved;

  const Achievement({
    required this.label,
    required this.icon,
    this.achieved = false,
  });
}
