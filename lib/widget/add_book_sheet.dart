import 'package:flutter/material.dart';

import '../models/book_model.dart';
import '../services/database_helper.dart';

class AddBookBottomSheet extends StatefulWidget {
  const AddBookBottomSheet({super.key});

  @override
  State<AddBookBottomSheet> createState() => _AddBookBottomSheetState();
}

class _AddBookBottomSheetState extends State<AddBookBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String? nameBook, nameAuthor, imgUrl;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextFormField('Book Name', (val) => nameBook = val),
                _buildTextFormField('Author Name', (val) => nameAuthor = val),
                _buildTextFormField('Img Url', (val) => imgUrl = val),
                const SizedBox(height: 15),
                _buildSaveButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(String hint, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(hintText: hint),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hint';
        }
        return null;
      },
      onChanged: (val) => setState(() => onChanged(val)),
    );
  }

  SizedBox _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState?.validate() ?? false) {
            _formKey.currentState?.save();
            Book book = Book(
              bookName: nameBook!,
              authorName: nameAuthor!,
              imageUrl: imgUrl!,
            );
            var db = DatabaseHelper();
            await db.insertBook(book);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Book saved successfully!')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.shade900,
          padding: const EdgeInsets.symmetric(vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
