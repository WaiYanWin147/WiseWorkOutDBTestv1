import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/client/leaderboard_entry.dart';
import '../../theme/app_theme.dart';
import '../../widgets/client/sub_screen_scaffold.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final top3 = MockData.leaderboard.take(3).toList();
    final rest = MockData.leaderboard.skip(3).toList();
    return SubScreenScaffold(
      title: 'Leaderboard',
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'June 21 - June 27',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _podium(top3),
        const SizedBox(height: 24),
        for (final entry in rest) ...[
          _rankRow(entry),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 6),
        _myPositionCard(),
      ],
    );
  }

  Widget _podium(List<LeaderboardEntry> top3) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _podiumSpot(top3[1], Icons.workspace_premium, AppColors.textMuted, 30),
        const SizedBox(width: 24),
        _podiumSpot(top3[0], Icons.emoji_events, AppColors.amber, 38),
        const SizedBox(width: 24),
        _podiumSpot(top3[2], Icons.workspace_premium, const Color(0xFFCD7F32), 30),
      ],
    );
  }

  Widget _podiumSpot(
      LeaderboardEntry entry, IconData medal, Color medalColor, double radius) {
    return Column(
      children: [
        Icon(medal, color: medalColor, size: 22),
        const SizedBox(height: 6),
        CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.primarySoft,
          child: Icon(Icons.person, color: AppColors.primary, size: radius),
        ),
        const SizedBox(height: 8),
        Text(
          entry.name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
        Text(
          '${entry.steps} steps',
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _rankRow(LeaderboardEntry entry) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardMuted,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '${entry.rank}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primarySoft,
            child: Icon(Icons.person, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              entry.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            '${entry.steps} steps',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _myPositionCard() {
    const me = MockData.myPosition;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Position ( #18 of 30)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(
                width: 24,
                child: Text(
                  '18',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.card,
                child: Icon(Icons.person, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  me.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                '${me.steps} steps',
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
