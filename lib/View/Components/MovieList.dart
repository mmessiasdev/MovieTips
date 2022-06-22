import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

import '../OnTapScreen.dart';

class MovieList extends StatelessWidget {
  MovieList({required this.title, required this.genero});
  String title;
  String genero;

  Future<List> fetch() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${genero}?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-BR&page=1');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var itemCount = jsonResponse['results'];
    return itemCount;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          SizedBox(
            height: 250,
            child: SizedBox(
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
                          mainAxisExtent: 180,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var UserApi = snapshot.data![index];
                          var url =
                              "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      height: 180,
                                      child: Image.network(
                                        '${url}${UserApi["poster_path"]}'
                                            .toString(),
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
                                      poster: '${url}${UserApi["poster_path"]}',
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
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Erro ao pegar Cotação'),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonsCategories extends StatelessWidget {
  const ButtonsCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 219, 219, 219),
        ),
        width: 120,
        child: Center(child: Text('Action')),
      ),
    );
  }
}
