import 'dart:convert';

import 'package:Movietips/View/OnTapScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

// ------------ MOVIE CATEGORY COMPONENT ------------ //
class Category extends StatefulWidget {
  Category({
    Key? key,
    required this.title,
    required this.genero,
  }) : super(key: key);
  String title;
  String genero;

  @override
  State<Category> createState() => _CategoryState();
}

enum Selected { np, yp }

class _CategoryState extends State<Category> {
  // ------- Initial Value category button ------- //
  var generes = "10751";
  var categName = "Categoría";

  // ------- Fetch Movie API ID ------- //
  Future<List> fetch() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=${generes}&with_watch_monetization_types=flatrate');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var itemCount = jsonResponse['results'];
    return itemCount;
  }

  // ------- Fetch State Movie API ------- //
  Future<List> fetchGeneres() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var itemCount = jsonResponse["genres"];
    return itemCount;
  }

  // ------- Preset Colors ------- //
  Color secoundColor = Color.fromARGB(255, 113, 113, 113);
  Color primaryColor = Color.fromARGB(255, 209, 209, 209);

  Selected? buttonSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                categName,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          FutureBuilder<List>(
            future: fetchGeneres(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 35),
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var UserApi = snapshot.data![index];
                          var url =
                              "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
                          return GestureDetector(
                            // ------- State click controller genere ------- //
                            onTap: () {
                              setState(() {
                                generes = "${UserApi["id"]}";
                                categName = "${UserApi["name"]}";
                              });
                            },
                            // -------------- //
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    '${UserApi["name"]}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          SizedBox(
            child: FutureBuilder<List>(
                future: fetch(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisSpacing: 0,
                        mainAxisExtent: 230,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var UserApi = snapshot.data![index];
                        var url =
                            "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";

                        if (UserApi['poster_path'] != null) {
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
                        } else if (UserApi["profile_path"] == null) {}
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
