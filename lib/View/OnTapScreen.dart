import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'Components/Header.dart';
import 'Components/MovieBanner.dart';

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
      ),
      MovieBanner(
        overview: '${overview}',
        rated: '${rated}',
        year: '${year}',
        poster: '${poster}',
      ),
      FutureBuilder<List>(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  mainAxisSpacing: 0,
                  mainAxisExtent: 180,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var MovieApi = snapshot.data![index];
                  var url = "https://www.youtube.com/watch?v=";
                  var urlApi =
                      "https://api.themoviedb.org/3/movie/${idMovie}/videos?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br&page=1";
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () async {
                          if (await canLaunch('${url}${MovieApi["key"]}')) {
                            await launch('${url}${MovieApi["key"]}');
                          } else {
                            throw "cannot load url";
                          }
                        },
                        child: FractionallySizedBox(
                            widthFactor: 0.75,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 30,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Trailer',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao pegar Cotação'),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),

      // Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 30),
      //   child: SizedBox(
      //     child: FutureBuilder<List>(
      //       future: fetch(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           return GridView.builder(
      //             physics: NeverScrollableScrollPhysics(),
      //             shrinkWrap: true,
      //             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //               maxCrossAxisExtent: 200,
      //               mainAxisSpacing: 0,
      //               mainAxisExtent: 250,
      //             ),
      //             itemCount: snapshot.data!.length,
      //             itemBuilder: (context, index) {
      //               var TrailerApi = snapshot.data![index];
      //               var urlTrailer = 'https://www.youtube.com/watch?v=';
      //               return GestureDetector(
      //                 onTap: () async {
      //                   if (await canLaunch(
      //                       '${urlTrailer}${TrailerApi["key"]}')) {
      //                     await launch('${urlTrailer}${TrailerApi["key"]}');
      //                   } else {
      //                     throw "cannot load url";
      //                   }
      //                 },
      //                 child: FractionallySizedBox(
      //                     widthFactor: 0.75,
      //                     child: Container(
      //                         color: Colors.blue,
      //                         child: Padding(
      //                           padding: const EdgeInsets.symmetric(
      //                             horizontal: 20,
      //                             vertical: 30,
      //                           ),
      //                           child: Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.center,
      //                             children: [
      //                               Text(
      //                                 'Trailer',
      //                                 style: GoogleFonts.montserrat(
      //                                   fontSize: 30,
      //                                   fontWeight: FontWeight.w800,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ))),
      //               );
      //             },
      //           );
      //         } else if (snapshot.hasError) {
      //           return Center(
      //             child: Text('Erro ao pegar Cotação'),
      //           );
      //         }
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       },
      //     ),
      //   ),
      // ),
    ]));
  }
}
