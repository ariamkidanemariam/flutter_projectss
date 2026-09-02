import 'package:flutter/material.dart';
import 'package:postapp/model/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

   const PostCard({super.key, required this.post}); 

  @override
  Widget build(BuildContext context) {
    return Card(
       child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.name, 
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(post.body),
          ],
        ),
      ),
    );
  }
}
