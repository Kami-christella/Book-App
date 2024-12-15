import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'BookProvider.dart';
import 'HomeScreen.dart';

void main() {
  runApp(BookManagerApp());
}

class BookManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookProvider(),
      child: MaterialApp(
        title: 'Book Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
