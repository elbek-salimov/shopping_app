import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      icon: const Icon(
        Icons.info_outline,
        color: Colors.red,
        size: 80,
      ),
      title: Text(title),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        MaterialButton(
          color: Colors.red,
          onPressed: onConfirm,
          child: Text(
            'logout_btn'.tr(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          color: Colors.blue,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'close'.tr(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
