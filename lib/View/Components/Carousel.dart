import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../OnTapScreen.dart';

class CarouselMoviel extends StatelessWidget {
  CarouselMoviel({Key? key, required this.movieId, required this.title})
      : super(key: key);

  String movieId;
  String title;

  final List<String> imgList = [
    'https://www.themoviedb.org/t/p/original/56v2KjBlU4XaOv9rVYEQypROD7P.jpg',
    'https://www.themoviedb.org/t/p/original/n6vVs6z8obNbExdD3QHTr4Utu1Z.jpg',
    'https://www.themoviedb.org/t/p/original/n3u3kgNttY1F5Ixi5bMY9BwZImQ.jpg'
  ];

  Future<List> fetch() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${movieId}/recommendations?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br&page=1');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var itemCount = jsonResponse['results'];
    return itemCount;
  }

  // https://api.themoviedb.org/3/movie/${movie_id}/recommendations?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br&page=1

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: FutureBuilder<List>(
                future: fetch(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          mainAxisSpacing: 0,
                          mainAxisExtent:
                              MediaQuery.of(context).size.width * 0.85,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var UserApi = snapshot.data![index];
                          var url =
                              "https://www.themoviedb.org/t/p/w1280_and_h720_bestv2";
                          if (UserApi['backdrop_path'] != null) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: GestureDetector(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 200,
                                        child: Image.network(
                                          '${url}${UserApi["backdrop_path"]}'
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: RichText(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                            text:
                                                '${UserApi["title"].toString()}'),
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  var url =
                                      "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OnTapScreen(
                                        overview: '${UserApi["overview"]}',
                                        poster:
                                            '${url}${UserApi["poster_path"]}',
                                        rated: '${UserApi["vote_average"]}',
                                        year: '${UserApi["release_date"]}',
                                        title: '${UserApi["title"]}',
                                        idMovie: '${UserApi["id"]}',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: SizedBox(
                                  child: Text('${UserApi["name"]}',
                                      textAlign: TextAlign.center,
                                      style:
                                          GoogleFonts.montserrat(fontSize: 10)),
                                ),
                              )
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro ao pegar Cotação'),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }
}
