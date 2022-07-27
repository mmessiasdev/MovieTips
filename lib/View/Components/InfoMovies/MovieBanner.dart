import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ------------ BANNER, DESCRIPTION, DATE AND RATING COMPONENT ------------ //
class MovieBanner extends StatelessWidget {
  MovieBanner(
      {Key? key,
      required this.overview,
      required this.year,
      required this.rated,
      required this.poster,
      required this.title})
      : super(key: key);

  String poster;
  String overview;
  String rated;
  String year;
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(poster)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                rated,
                                style: GoogleFonts.montserrat(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                size: 10,
                              )
                            ],
                          ),
                          Text(
                            year,
                            style: GoogleFonts.montserrat(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width * 0.55,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.90,
              heightFactor: 0.90,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            overview,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
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
      ],
    );
  }
}
