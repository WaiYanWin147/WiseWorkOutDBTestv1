import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/professional.dart';
import '../theme/app_theme.dart';
import '../widgets/sub_screen_scaffold.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubScreenScaffold(
      title: 'Reviews',
      children: [
        Center(
          child: Column(
            children: [
              const Text(
                '4.8',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              _stars(5),
              const SizedBox(height: 4),
              const Text(
                'based on 23 reviews',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        for (final review in [...MockData.reviews, ...MockData.reviews]) ...[
          _reviewCard(review),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _stars(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++)
          const Icon(Icons.star, size: 20, color: AppColors.amber),
      ],
    );
  }

  Widget _reviewCard(Review review) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardMuted,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primarySoft,
                child: Icon(Icons.person, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: 10),
              Text(
                review.reviewer,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, size: 14, color: AppColors.amber),
              const SizedBox(width: 2),
              Text(
                '${review.rating}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.text,
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
