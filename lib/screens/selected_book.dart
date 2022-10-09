import 'package:am_t03/Classes/Book.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SelectedBook extends StatefulWidget {
  const SelectedBook({super.key});

  @override
  State<SelectedBook> createState() => _SelectedBookState();
}

class _SelectedBookState extends State<SelectedBook> {
  int? _lines = 5;
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    List<dynamic> params =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    Book book = params[0];

    return Scaffold(
      appBar: AppBar(
        title: Text("Book details"),
        backgroundColor: Colors.grey.shade800,
        actions: [
          IconButton(
              onPressed: (() async {
                await Share.share(
                    'Check out this book! ${book.title} pages: ${book.pages}');
              }),
              icon: Icon(Icons.share))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                margin:
                    EdgeInsets.only(bottom: 5, top: 30, left: 20, right: 20),
                child: Image.network(
                  book.img,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/no_cover_available.png',
                        fit: BoxFit.contain);
                  },
                ),
              ),
            ),
            Center(
                child: Text(
              book.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
            )),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.date,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Pages: ' + book.pages),
                  GestureDetector(
                    child: Text(
                      book.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: _lines,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    onTap: () {
                      this.setState(() {
                        if (hidden) {
                          hidden = false;
                          _lines = 5;
                        } else {
                          hidden = true;
                          _lines = 40;
                        }
                        ;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
