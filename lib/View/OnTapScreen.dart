import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'Components/DefaultButton.dart';
import 'Components/Header.dart';
import 'Components/InfoMovies/Credits.dart';
import 'Components/InfoMovies/MovieBanner.dart';
import 'Components/InfoMovies/TraillerEn.dart';
import 'Components/InfoMovies/TraillerPt.dart';
import 'HomePage.dart';

class OnTapScreen extends StatelessWidget {
  OnTapScreen({
    required this.overview,
    required this.rated,
    required this.year,
    required this.poster,
    required this.title,
    required this.idMovie,
  });
  String overview;
  String rated;
  String year;
  String poster;
  String title;
  String idMovie;

  Future<List> fetch() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${idMovie}/videos?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br&page=1');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var itemCount = jsonResponse['results'];
    return itemCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Header(
        title: title,
        buttonBack: DefaultButton(
            tap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
            )),
      ),
      MovieBanner(
        overview: '${overview}',
        rated: '${rated}',
        year: '${year}',
        poster: '${poster}',
        title: '${title}',
      ),
      TraillerPt(idMovie: '${idMovie}'),
      Credits(idMovie: '${idMovie}'),
      // MovieGalery(idMovie: '${idMovie}'),
      TraillerEn(idMovie: '${idMovie}'),
    ]));
  }
}
