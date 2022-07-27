import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// ------------ TRALLER ENGLISH COMPONENT ------------ //
class TraillerEn extends StatelessWidget {
  TraillerEn({required this.idMovie});

  String idMovie;

  // ------- Fetch Traller Movie API ID ------- //
  Future<List> fetch() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${idMovie}/videos?api_key=78e7e6ae60efeac373ce12307172c271&language=en&page=1');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var itemCount = jsonResponse['results'];
    return itemCount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, left: 10),
          child: SizedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('em Inglês',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        SizedBox(
          height: 270,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: FutureBuilder<List>(
                future: fetch(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var MovieApi = snapshot.data![index];
                        var url = "https://www.youtube.com/watch?v=";
                        var urlApi =
                            "https://api.themoviedb.org/3/movie/${idMovie}/videos?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br&page=1";

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(
                                      '${url}${MovieApi["key"]}')) {
                                    await launch('${url}${MovieApi["key"]}');
                                  } else {
                                    throw "cannot load url";
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 197, 197, 197),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: Container(
                                                        width: 85,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)),
                                                        child: Icon(
                                                          Icons.play_arrow,
                                                          size: 50,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.70,
                                                  child: Text(
                                                    '${MovieApi["name"]}',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Trailer em Inglês',
                                                  style: GoogleFonts.montserrat(
                                                    color: Color.fromARGB(
                                                        255, 143, 143, 143),
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro ao pegar Trailler'),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
        ),
      ],
    );
  }
}
