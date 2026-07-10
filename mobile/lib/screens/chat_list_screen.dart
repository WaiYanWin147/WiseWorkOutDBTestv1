import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/professional.dart';
import '../theme/app_theme.dart';
import '../widgets/sub_screen_scaffold.dart';
import 'chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = MockData.professionals.take(2).toList();
    return SubScreenScaffold(
      title: 'Chat',
      children: [
        TextField(
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Search fitness professionals',
            hintStyle:
                const TextStyle(fontSize: 13, color: AppColors.textMuted),
            suffixIcon:
                const Icon(Icons.search, size: 20, color: AppColors.textMuted),
            filled: true,
            fillColor: AppColors.cardMuted,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        for (var i = 0; i < chats.length; i++) ...[
          _chatRow(
            context,
            name: chats[i].name,
            message: 'Sure, let me know if you need...',
            time: i == 0 ? '12:48 PM' : '11:45 PM',
            unread: i == 0,
            professional: chats[i],
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _chatRow(
    BuildContext context, {
    required String name,
    required String message,
    required String time,
    required bool unread,
    required Professional professional,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        leading: const CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.primarySoft,
          child: Icon(Icons.person, color: AppColors.primary),
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
              ),
            ),
            if (unread) ...[
              const SizedBox(height: 4),
              Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '1',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChatScreen(professional: professional),
            ),
          );
        },
      ),
    );
  }
}
