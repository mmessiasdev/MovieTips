import 'package:codigomobile/View/Components/Header.dart';
import 'package:codigomobile/View/Components/MovieList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Header(
          title: 'MovieTips',
        ),
        MovieList(title: 'Melhores Avaliados', genero: "top_rated"),
      ],
    ));
  }
}
