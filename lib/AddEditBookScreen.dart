import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BookProvider.dart';
import 'book.dart';

class AddEditBookScreen extends StatefulWidget {
  final Book? book;

  AddEditBookScreen({this.book});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _author;
  String? _description;

  @override
  void initState() {
    if (widget.book != null) {
      _title = widget.book!.title;
      _author = widget.book!.author;
      _description = widget.book!.description;
    }
    super.initState();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final bookProvider = context.read<BookProvider>();
      if (widget.book == null) {
        bookProvider.addBook(_title!, _author!, _description!);
      } else {
        bookProvider.updateBook(
          widget.book!.id,
          _title!,
          _author!,
          _description!,
        );
      }
      Navigator.of(context).pop();
    }
  }

  void _deleteBook() {
    final bookProvider = context.read<BookProvider>();
    if (widget.book != null) {
      bookProvider.deleteBook(widget.book!.id);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
        actions: [
          if (widget.book != null) ...[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _deleteBook,
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            ),
          ],
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.book == null
          ? FloatingActionButton(
              onPressed: _saveForm,
              child: Icon(Icons.add),
              tooltip: 'Add Book',
            )
          : null,
    );
  }
}
