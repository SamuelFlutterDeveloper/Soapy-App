import 'package:flutter/material.dart';

class DialogHelper {
  // Existing method for showing success dialog
  static void showSuccessDialog(
    BuildContext context, {
    required String title,
    required String message,
    required double totalAmount,
    required VoidCallback onDone,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('$message\nTotal Amount: ₹${totalAmount.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: onDone,
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  // New method for showing info dialog
  static void showInfoDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
