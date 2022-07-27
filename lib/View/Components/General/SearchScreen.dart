import 'dart:convert';
import 'package:Movietips/View/Components/General/Category.dart';
import 'package:Movietips/View/Components/General/MovieList.dart';
import 'package:Movietips/View/OnTapScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ------------ MOVIE SEARCH COMPONENT ------------ //
class SearchScreen extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Procure algum filme...';

  // ------------------------ //
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }
  // ------------------------ //

  // ------------------------ //
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back_ios));
  }
  // ------------------------ //

  // ------------------------ //
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List>(
      future: fetch(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('Procurando Filme...'),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao procurar filme.'),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var MovieApi = snapshot.data![index];
              var url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
              if (MovieApi["poster_path"] == null) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                );
              }
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    '${url}${MovieApi["poster_path"]}',
                  ),
                ),
                title: Text(
                  '${MovieApi["title"]}',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${MovieApi["original_title"]}',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                trailing: Text('${MovieApi["release_date"]}'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnTapScreen(
                        overview: '${MovieApi["overview"]}',
                        poster: '${url}${MovieApi["poster_path"]}',
                        rated: '${MovieApi["vote_average"]}',
                        year: '${MovieApi["release_date"]}',
                        title: '${MovieApi["title"]}',
                        idMovie: '${MovieApi["id"]}',
                      ),
                    )),
              );
            });
      },
    );
  }
  // ------------------------ //

  // ------------------------ //
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView(
      children: [
        MovieList(title: "Populares", genero: "top_rated"),
        Category(title: "Categoría", genero: "upcoming")
      ],
    );
  }
  // ------------------------ //

  // ------------------------ //
  // ------- Fetch Movie Query API ID ------- //
  Future<List> fetch(String query) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=78e7e6ae60efeac373ce12307172c271&language=pt-br&page=1&include_adult=true&query=$query');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    var itemCount = jsonResponse['results'];
    return itemCount;
  }
  // ------------------------ //
}
