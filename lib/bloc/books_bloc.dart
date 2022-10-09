import 'dart:async';
import 'package:am_t03/Classes/Book.dart';
import 'package:am_t03/main.dart';
import 'package:am_t03/repositories/books_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  BooksBloc() : super(BooksInitial()) {
    on<SearchBookEvent>(_searchForBooks);
    on<SeeBookDetailsEvent>(_seeDetails);
  }

  Future<FutureOr<void>> _searchForBooks(
      SearchBookEvent event, Emitter<BooksState> emit) async {
    emit(LoadingBooksState());
    List<Book> foundBooks = [];
    var apiCaller = BooksAPI();
    //call api
    try {
      Response response = await apiCaller.getBooks(event.inputSearch);
      if (response.statusCode != 404) {
        try {
          foundBooks = apiCaller.decodeResponse(response);
          if (foundBooks.isEmpty) {
            emit(ErrorBooksState(
                'There are no results in your search, please try again..'));
            return null;
          }
        } catch (e) {
          emit(ErrorBooksState(
              'There was a connection error, please try again'));

          return null;
        }
      }
    } catch (e) {
      print(e);
      emit(ErrorBooksState('There was a unkown error, please try again'));
      return null;
    }
    emit(FoundBooksState(foundBooks));

    //show gridview
  }

  FutureOr<void> _seeDetails(
      SeeBookDetailsEvent event, Emitter<BooksState> emit) {
    emit(SelectedBookState(event.book));
    emit(BooksInitial());
  }
}
