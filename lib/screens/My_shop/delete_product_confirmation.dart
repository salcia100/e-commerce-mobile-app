import 'package:flutter/material.dart';

class DeleteProductConfirmation {
  static Future<void> showDeleteDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
    String title = "Delete product",
    String content = "Are you sure you want to delete this product?",
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(ctx).pop(); // Ferme la boîte
              },
            ),
            TextButton(
              child:
                  const Text("DELETE", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(ctx).pop(); // Ferme la boîte
                onConfirm(); // Exécute la suppression
              },
            ),
          ],
        );
      },
    );
  }
}
