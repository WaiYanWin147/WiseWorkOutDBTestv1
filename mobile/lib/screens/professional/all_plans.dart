import 'package:flutter/material.dart';
import '../../data/professional/mock_plans.dart';
import '../../models/professional/workout_plan.dart';
import '../../widgets/professional/mobile_page_wrapper.dart';
import '../../widgets/professional/plan_card.dart';
import 'plan_detail.dart';
import 'edit_plan.dart';

class AllPlansScreen extends StatelessWidget {
  const AllPlansScreen({super.key});

  void openPlanDetail(BuildContext context, WorkoutPlan plan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanDetailScreen(plan: plan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MobilePageWrapper(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F2FA),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  const Expanded(
                    child: Center(
                      child: Text(
                        'All Plans',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 44),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                child: Column(
                  children: [
                    _PlanSection(
                      title: 'My Public Plans',
                      count: publicPlans.length,
                      plans: publicPlans,
                      onView: (plan) => openPlanDetail(context, plan),
                    ),

                    const SizedBox(height: 18),

                    _PlanSection(
                      title: 'Private Plans',
                      count: privatePlans.length,
                      plans: privatePlans,
                      onView: (plan) => openPlanDetail(context, plan),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanSection extends StatelessWidget {
  final String title;
  final int count;
  final List<WorkoutPlan> plans;
  final void Function(WorkoutPlan plan) onView;

  const _PlanSection({
    required this.title,
    required this.count,
    required this.plans,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: '$title ',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '($count)',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          ...plans.map((plan) {
            return PlanCard(
              plan: plan,
              onView: () => onView(plan),
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPlan(plan: plan),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}