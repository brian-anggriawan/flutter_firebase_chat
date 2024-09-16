import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? buttonText;
  final void Function()? onTap;

  const MyButton({super.key, this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            buttonText ?? 'My Button',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
