import 'package:flutter/material.dart';

class MyContact extends StatelessWidget {
  final String? userEmail;
  final void Function()? onTap;
  const MyContact({super.key, this.userEmail, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(userEmail ?? 'example@gmail.com'),
          ],
        ),
      ),
    );
  }
}
