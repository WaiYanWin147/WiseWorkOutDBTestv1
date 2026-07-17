import 'package:flutter/material.dart';

class WearableDevicesPage extends StatefulWidget {
  const WearableDevicesPage({super.key});

  @override
  State<WearableDevicesPage> createState() => _WearableDevicesPageState();
}

class _WearableDevicesPageState extends State<WearableDevicesPage> {
  bool appleHealthEnabled = true;
  bool motionFitnessEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          child: Column(
            children: [
              Row(
                children: [
                  _CircleBackButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Wearable Devices",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 38),
                ],
              ),
              const SizedBox(height: 28),
              _DeviceSwitchTile(
                title: "Apple Health",
                value: appleHealthEnabled,
                onChanged: (value) {
                  setState(() {
                    appleHealthEnabled = value;
                  });
                },
              ),
              _DeviceSwitchTile(
                title: "Motions & Fitness Activity",
                value: motionFitnessEnabled,
                onChanged: (value) {
                  setState(() {
                    motionFitnessEnabled = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeviceSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _DeviceSwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              activeThumbColor: Colors.white,
              activeTrackColor: Colors.deepPurpleAccent,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CircleBackButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F3FC),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 15,
        ),
      ),
    );
  }
}
