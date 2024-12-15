import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BookProvider.dart';
import 'BookDetailScreen.dart';
import 'AddEditBookScreen.dart';
import 'SettingsScreen.dart';
import 'MainDrawer.dart';  // Import the new MainDrawer file

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: MainDrawer(),  // Add the drawer here
      body: ListView.builder(
        itemCount: bookProvider.books.length,
        itemBuilder: (ctx, index) {
          final book = bookProvider.books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddEditBookScreen(book: book),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    bookProvider.deleteBook(book.id);
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditBookScreen(),
            ),
          );
        },
      ),
    );
  }
}
