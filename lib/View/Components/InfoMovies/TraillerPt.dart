import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class TraillerPt extends StatelessWidget {
  TraillerPt({required this.idMovie});

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
    return FutureBuilder<List>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    child: Text('Trailer',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var MovieApi = snapshot.data![index];
                    var urlThumb =
                        "https://img.youtube.com/vi/${MovieApi["key"]}/0.jpg";
                    var url = "https://www.youtube.com/watch?v=";
                    var urlApi =
                        "https://api.themoviedb.org/3/movie/${idMovie}/videos?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br&page=1";
                    if (MovieApi["key"] != null) {
                      return SizedBox(
                        height: 240,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: GestureDetector(
                          onTap: () async {
                            if (await canLaunch('${url}${MovieApi["key"]}')) {
                              await launch('${url}${MovieApi["key"]}');
                            } else {
                              throw "cannot load url";
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Image.network(
                                        urlThumb,
                                        fit: BoxFit.cover,
                                        color:
                                            Color.fromARGB(255, 214, 214, 214)
                                                .withOpacity(0.1),
                                        colorBlendMode: BlendMode.modulate,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
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
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 40),
                                                  child: Container(
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0)),
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: 50,
                                                      color: Color.fromARGB(
                                                          255, 211, 211, 211),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Trailer em Português',
                                                  style: GoogleFonts.montserrat(
                                                    color: Color.fromARGB(
                                                        255, 70, 70, 70),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                            child: Text('${MovieApi["name"]}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontSize: 10)),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao pegar Trailer.'),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
