import 'package:am_t03/Classes/Book.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert' as convert;

class BooksAPI {
  static final BooksAPI _singleton = BooksAPI._internal();

  factory BooksAPI() {
    return _singleton;
  }

  Future<Response> getBooks(String inputString) async {
    Map<String, String> qParams = {'q': inputString};
    var url = Uri.https('www.googleapis.com', 'books/v1/volumes', qParams);
    Response response = await http.get(url);
    return response;
  }

  List<Book> decodeResponse(Response response) {
    List<Book> results = [];
    var info = convert.jsonDecode(response.body);
    info = info['items'];
    if (info == null) {
      return results;
    }
    try {
      info.forEach((element) {
        String title = element['volumeInfo']?['title'] ?? '';
        String img = element['volumeInfo']?['imageLinks']?['thumbnail'] ?? '-';
        var authors = element['volumeInfo']?['authors']?.join('') ?? '-';
        var pageCount = element['volumeInfo']?['pageCount'] ?? '-';
        pageCount = '${pageCount}';
        String description = element['volumeInfo']?['description'] ?? '-';
        String date = element['volumeInfo']?['publishedDate'] ?? '-';
        // try {
        //   img = element['volumeInfo']['imageLinks']['thumbnail'];
        // } catch (e) {
        //   img = '-';
        // }
        // try {
        //   authors = element['volumeInfo']['authors'];
        //   authors = element['volumeInfo']['authors'].join("");
        // } catch (e) {
        //   authors = '-';
        // }
        // try {
        //   pageCount = element['volumeInfo']['pageCount'];
        //   pageCount = '$pageCount';
        // } catch (e) {
        //   pageCount = '-';
        // }
        // try {
        //   description = element['volumeInfo']['description'];
        // } catch (e) {
        //   description = '-';
        // }
        // try {
        //   date = element['volumeInfo']['publishedDate'];
        // } catch (e) {
        //   date = '-';
        // }

        results.add(Book(
          title: title,
          img: img,
          description: description,
          pages: pageCount,
          authors: authors,
          date: date,
        ));
      });
    } catch (e) {
      print(e);
    }

    return results;
  }

  BooksAPI._internal();
}
