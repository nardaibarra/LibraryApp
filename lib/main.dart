import 'package:am_t03/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/books_bloc.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => BooksBloc(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: const Home(),
        theme: ThemeData(
          // brightness: Brightness.dark,

          // inputDecorationTheme: InputDecorationTheme(focusColor: Colors.grey),
          // primaryColor: Colors.grey.shade600,
          scaffoldBackgroundColor: Colors.grey.shade300,
        ));
  }
}
