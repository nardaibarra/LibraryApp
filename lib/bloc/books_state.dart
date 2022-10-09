part of 'books_bloc.dart';

@immutable
abstract class BooksState extends Equatable {
  const BooksState();
  @override
  List<Object> get props => [];
}

class BooksInitial extends BooksState {}

class LoadingBooksState extends BooksState {}

class FoundBooksState extends BooksState {
  final List<dynamic> foundBooks;
  FoundBooksState(this.foundBooks);
  @override
  List<Object> get props => [foundBooks];
}

class FoundNoBooksState extends BooksState {}

class ErrorBooksState extends BooksState {
  final String error;
  ErrorBooksState(this.error);
  @override
  List<Object> get props => [error];
}

class SelectedBookState extends BooksState {
  final Book selectedBook;
  SelectedBookState(this.selectedBook);
  @override
  List<Object> get props => [selectedBook];
}

class HiddenText extends BooksState {}

class ShownText extends BooksState {}
