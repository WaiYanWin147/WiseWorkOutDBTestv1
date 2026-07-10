import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/professional.dart';
import '../theme/app_theme.dart';
import '../widgets/pill_tag.dart';

class ChatScreen extends StatelessWidget {
  final Professional professional;

  const ChatScreen({super.key, required this.professional});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                children: [
                  const Center(
                    child: Text(
                      'Today, 4:28 PM',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (final msg in MockData.chatMessages) ...[
                    if (msg.planTitle != null)
                      _planBubble(msg.planTitle!)
                    else
                      _messageBubble(msg),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            _inputBar(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.cardMuted,
              shape: const CircleBorder(),
            ),
          ),
          Expanded(
            child: Text(
              professional.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (_) {},
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'review',
                child: Text('Give a Review', style: TextStyle(fontSize: 13)),
              ),
              PopupMenuItem(
                value: 'report',
                child: Text(
                  'Report Fitness Professional',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _messageBubble(ChatMessage msg) {
    return Row(
      mainAxisAlignment:
          msg.fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!msg.fromMe) ...[
          const CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.primarySoft,
            child: Icon(Icons.person, size: 14, color: AppColors.primary),
          ),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: msg.fromMe ? AppColors.primary : AppColors.cardMuted,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: msg.fromMe ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),
        ),
        if (msg.fromMe) ...[
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.primarySoft,
            child: Icon(Icons.person, size: 14, color: AppColors.primary),
          ),
        ],
      ],
    );
  }

  Widget _planBubble(String title) {
    return Row(
      children: [
        const SizedBox(width: 36),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.cardMuted,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '30 Days • ~45 min',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                const Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    PillTag('Full Body'),
                    PillTag('Fat Loss'),
                    PillTag('Strength'),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Save Plan',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: TextField(
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Ask a question...',
          hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
          suffixIcon:
              const Icon(Icons.send, size: 18, color: AppColors.textMuted),
          filled: true,
          fillColor: AppColors.cardMuted,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
