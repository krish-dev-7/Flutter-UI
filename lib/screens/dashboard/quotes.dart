import 'package:books_app/constants/colors.dart';
import 'package:books_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quote {
  final String quote;
  final String author;

  Quote(
    this.quote,
    this.author,
  );
}

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  String get token {
    String s;
    AuthService().firebaseAuth.currentUser.getIdToken(true).then((String val) {
      setState(() {
        s = val;
      });
    }).toString();
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return quote();
  }

  FutureBuilder quote() {
    return FutureBuilder<dynamic>(
        future: AuthService().getQuote(AuthService.googleAuthToken),
        // future: Api.getQuote(AuthService().authtoken),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(AuthService.googleAuthToken);
            print(' is the access token received');
            // print(AuthService().firebaseAuth.currentUser);
            print('Quote is $snapshot.toString()');
            print('Quote snapshot isss $snapshot.data');

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(children: <Widget>[
                  Text(
                    snapshot.data.toString(),
                    // '"${quote.text}"',
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    style: GoogleFonts.lato(
                        color: blackButton,
                        fontSize: 23,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      snapshot.data.toString(),
                      // '-${quote.author}',
                      style: GoogleFonts.lato(color: blackButton, fontSize: 14),
                    ),
                  )
                ]),
              ),
            );
          }
        });
  }
}
