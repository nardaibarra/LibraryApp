import 'package:am_t03/bloc/books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Classes/Book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  BookCard(BuildContext context, {super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<BooksBloc>(context)
                    .add(SeeBookDetailsEvent(book: this.book));
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      this.book.img,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                            'assets/images/no_cover_available.png',
                            fit: BoxFit.contain);
                      },
                    ),
                  ),
                  Container(
                    child: Column(children: [
                      Container(
                          height: 40,
                          child: Text(book.title,
                              overflow: TextOverflow.ellipsis, maxLines: 2))
                    ]),
                  )
                ],
              ),
            )));
  }
}
