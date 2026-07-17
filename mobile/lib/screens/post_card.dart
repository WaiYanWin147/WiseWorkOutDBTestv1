import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Post image：约 65%
          Expanded(
            flex: 65,
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
          ),

          // Post information：约 35%
          Expanded(
            flex: 35,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lorem ipsum dolor sit amet...",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.15,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      const Expanded(
                        child: Text(
                          "Christopher",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        size: 15,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        "299",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
