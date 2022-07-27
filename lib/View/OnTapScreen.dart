import 'dart:convert';
import 'package:Movietips/View/Components/General/DefaultButton.dart';
import 'package:Movietips/View/Components/General/Header.dart';
import 'package:Movietips/View/Components/InfoMovies/toFind.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'Components/InfoMovies/Credits.dart';
import 'Components/InfoMovies/MovieBanner.dart';
import 'Components/InfoMovies/TraillerEn.dart';
import 'Components/InfoMovies/TraillerPt.dart';
import 'HomePage.dart';

// ------------ DETAILED PRESENTATION SCREEN OF MOVIES AND SERIES ------------ //
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

  // ------- Fetch Movie API ID ------- //
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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Header(
            title: title,
            buttonBack: DefaultButton(
                tap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                )),
          ),

          // ------- Banner, description, date and movie rating ------- //
          MovieBanner(
            overview: '${overview}',
            rated: '${rated}',
            year: '${year}',
            poster: '${poster}',
            title: '${title}',
          ),

          // ------- Where to find movie ------- //
          ToFind(idMovie: '${idMovie}'),

          // ------- Movie's cast ------- //
          Credits(idMovie: '${idMovie}'),

          // ------- Traillers in portuguese ------- //
          TraillerPt(idMovie: '${idMovie}'),

          // ------- Traillers in English ------- //
          TraillerEn(idMovie: '${idMovie}'),
        ],
      ),
    );
  }
}
