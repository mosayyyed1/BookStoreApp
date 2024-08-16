import 'package:flutter/material.dart';

import '../models/book_model.dart';
import '../services/database_helper.dart';
import '../widget/book_list.dart';
import '../widget/custom_floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    List<Book> books = await DatabaseHelper().getBooks();
    setState(() {
      _books = books;
    });
  }

  void _removeBook(int bookId) async {
    await DatabaseHelper().deleteBook(bookId);
    setState(() {
      _books.removeWhere((book) => book.id == bookId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddBookButton(onAddBook: _loadBooks),
      appBar: AppBar(
        title: const Text(
          'Available Books',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BookList(books: _books, onRemoveBook: _removeBook),
      ),
    );
  }
}
