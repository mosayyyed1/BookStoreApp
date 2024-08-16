import 'package:flutter/material.dart';

import 'add_book_sheet.dart';

class AddBookButton extends StatelessWidget {
  final VoidCallback onAddBook;

  const AddBookButton({super.key, required this.onAddBook});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context, builder: (context) => const AddBookBottomSheet());
        onAddBook();
      },
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.add,
        size: 45,
      ),
    );
  }
}
