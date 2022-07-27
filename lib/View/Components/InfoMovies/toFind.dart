import 'dart:convert';

import 'package:Movietips/View/Components/InfoMovies/FetchToFind.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ------------ WHERE TO FIND COMPONENT ------------ //
class ToFind extends StatelessWidget {
  ToFind({required this.idMovie});

  // ------- Fetch where to flatrate ------- //
  Future<List> fetch() async {
    var itemCount;
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${idMovie}/watch/providers?api_key=78e7e6ae60efeac373ce12307172c271');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["results"]["BR"] != null) {
      itemCount = jsonResponse["results"]["BR"]["flatrate"] ?? [] as List;
    } else {
      itemCount = [];
    }

    return itemCount;
  }

  // ------- Fetch where to rent ------- //
  Future<List> fetchRent() async {
    var itemCount;
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${idMovie}/watch/providers?api_key=78e7e6ae60efeac373ce12307172c271');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["results"]["BR"] != null) {
      itemCount = jsonResponse["results"]["BR"]["rent"] ?? [] as List;
    } else {
      itemCount = [];
    }

    return itemCount;
  }

  // ------- Principal Fetch where to buy ------- //
  Future<List> fetchBuy() async {
    var itemCount;
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${idMovie}/watch/providers?api_key=78e7e6ae60efeac373ce12307172c271');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["results"]["BR"] != null) {
      itemCount = jsonResponse["results"]["BR"]["buy"] ?? [] as List;
    } else {
      itemCount = [];
    }

    return itemCount;
  }

  String idMovie;

  Widget ContainerSearch() {
    return DraggableScrollableSheet(
      initialChildSize: 0.48,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 45),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 35,
                ),
              ),
              FetchToFind(title: 'Streamer', fetchSelect: fetch()),
              SizedBox(
                height: 20,
              ),
              FetchToFind(title: 'Alugue', fetchSelect: fetchRent()),
              SizedBox(
                height: 20,
              ),
              FetchToFind(title: 'Compre', fetchSelect: fetchBuy()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 100,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Color.fromARGB(255, 255, 155, 155),
                        Color.fromARGB(255, 255, 125, 125),
                      ],
                      tileMode: TileMode.mirror,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 50,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Text(
                        'Aonde Encontrar',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => ContainerSearch())),
        ],
      ),
    );
  }
}
