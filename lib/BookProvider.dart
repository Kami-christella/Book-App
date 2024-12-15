import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'book.dart';

class BookProvider with ChangeNotifier {
  final List<Book> _books = [];

  List<Book> get books => _books;

  void addBook(String title, String author, String description) {
    final newBook = Book(
      id: Uuid().v4(),
      title: title,
      author: author,
      description: description,
    );
    _books.add(newBook);
    notifyListeners();
  }

  void updateBook(String id, String title, String author, String description) {
    final bookIndex = _books.indexWhere((book) => book.id == id);
    if (bookIndex >= 0) {
      _books[bookIndex] = Book(
        id: id,
        title: title,
        author: author,
        description: description,
      );
      notifyListeners();
    }
  }

  void deleteBook(String id) {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }
}
