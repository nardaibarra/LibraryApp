import 'package:am_t03/bloc/books_bloc.dart';
import 'package:am_t03/screens/selected_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/book_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  var _mainMsg = 'Type something to search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade800,
          title: const Text('Libreria free to play'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: TextField(
                controller: _searchController,
                cursorColor: Colors.grey.shade600,
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                    focusColor: Colors.grey.shade600,
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 4, 4, 4),
                      ),
                      onPressed: () {
                        BlocProvider.of<BooksBloc>(context).add(SearchBookEvent(
                            inputSearch: _searchController.text));
                      },
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Type something'),
              ),
            ),
            BlocConsumer<BooksBloc, BooksState>(listener: (context, state) {
              if (state is BooksInitial) {
                _mainMsg = 'Type something to search';
              }
              if (state is SelectedBookState) {
                navigateToSelectedBookPage(context, state);
              }
              if (state is ErrorBooksState) {
                _mainMsg = state.error;
              }
            }, builder: (context, state) {
              if (state is LoadingBooksState) {
                return _shimmerView(context);
              } else if (state is FoundBooksState) {
                return _booksGridView(context, state, this._searchController);
              } else
                return _defaultView(
                    context, this._mainMsg, this._searchController);
            }),
          ],
        ));
  }

  Widget _defaultView(BuildContext context, _mainMsg, _searchController) {
    return Expanded(
        child: Container(
      child: Center(
        child: Text(
          _mainMsg,
          textAlign: TextAlign.center,
        ),
      ),
      // height: double.infinity,
      // width: double.infinity,
    ));
  }

  Widget _shimmerView(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: GridView.count(
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            shrinkWrap: true,
            padding: EdgeInsets.all(6),
            children: List.generate(4, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(2)),
                  Container(
                    height: 15,
                    color: Colors.white,
                  ),
                  const Padding(padding: EdgeInsets.all(2)),
                  Container(
                    width: itemWidth / 2.5,
                    height: 15,
                    color: Colors.white,
                  )
                ],
              );
            })),
      ),
    );
  }
}

Widget _booksGridView(
    BuildContext context, state, TextEditingController searchController) {
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2;
  return Expanded(
    child: GridView.count(
        childAspectRatio: (itemWidth / itemHeight),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(state.foundBooks.length, (index) {
          return BookCard(context, book: state.foundBooks[index]);
        })),
  );
}

navigateToSelectedBookPage(BuildContext context, state) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (nextContext) => BlocProvider.value(
          value: BlocProvider.of<BooksBloc>(context), child: SelectedBook()),
      settings: RouteSettings(arguments: [state.selectedBook])));
}
