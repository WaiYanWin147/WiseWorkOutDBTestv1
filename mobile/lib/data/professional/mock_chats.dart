import '../../models/professional/chat_models.dart';
import 'mock_plans.dart';

final List<ChatUser> chatUsers = [
  ChatUser(
    name: 'Christopher Heron',
    lastMessage: 'Hi, Wade! Can you help me create...',
    time: '17:48 PM',
    unreadCount: 1,
    tags: ['New', 'Urgent'],
    priority: true,
    avatarText: 'C',
    age: 34,
    gender: 'Male',
    weight: '65 kg',
    height: '172 cm',
    activityLevel: 'Lightly Active',
    fitnessGoal: 'Gain Weight',
    activePlan: publicPlans.first,
  ),
  ChatUser(
    name: 'Evans Mcgee',
    lastMessage: 'Sure, let me know if you need...',
    time: '17:48 PM',
    unreadCount: 0,
    tags: ['Consult'],
    priority: false,
    avatarText: 'E',
    age: 29,
    gender: 'Male',
    weight: '72 kg',
    height: '176 cm',
    activityLevel: 'Moderately Active',
    fitnessGoal: 'Fat Loss',
    activePlan: publicPlans[1],
  ),
];

List<ChatMessage> buildInitialMessages(ChatUser user) {
  return [
    const ChatMessage(
      isMe: false,
      text: 'Hi, Wade!\nCan you help me create a 30-day weight loss program?',
      time: 'Today, 14:38 PM',
    ),
  ];
}