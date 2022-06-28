import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MovieGalery extends StatelessWidget {
  MovieGalery({required this.idMovie});

  String idMovie;

  Future<List> fetch() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${idMovie}/images?api_key=78e7e6ae60efeac373ce12307172c271&language=en');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var itemCount = jsonResponse['backdrops'];
    return itemCount;
  }

  // https://api.themoviedb.org/3/movie/{movie_id}/images?api_key=<<api_key>>&language=en-US

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            child: Text('Posters',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(
          height: 250,
          child: FutureBuilder<List>(
            future: fetch(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var MovieApi = snapshot.data![index];
                      var url =
                          "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
                      if (MovieApi["file_path"] != null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  '${url}${MovieApi["file_path"]}',
                                  height: 200,
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (MovieApi[0]) {
                        return CircularProgressIndicator();
                      }
                      return Center(child: CircularProgressIndicator());
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Casters Não existem'),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        )
      ],
    );
  }
}
