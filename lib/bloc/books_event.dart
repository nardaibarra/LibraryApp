part of 'books_bloc.dart';

abstract class BooksEvent extends Equatable {
  const BooksEvent();
  @override
  List<Object> get props => [];
}

class SearchBookEvent extends BooksEvent {
  final String inputSearch;
  SearchBookEvent({
    required this.inputSearch,
  });
  @override
  List<Object> get props => [inputSearch];
}

class SeeBookDetailsEvent extends BooksEvent {
  final Book book;
  SeeBookDetailsEvent({
    required this.book,
  });
  @override
  List<Object> get props => [book];
}
