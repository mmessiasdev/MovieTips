import 'package:Movietips/View/Components/Carousel.dart';
import 'package:Movietips/View/Components/Category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Components/DefaultButton.dart';
import 'Components/Header.dart';
import 'Components/MovieList.dart';
import 'Login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _fireBaseAuth = FirebaseAuth.instance;
    sair() async {
      await _fireBaseAuth.signOut().then(
            (user) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            ),
          );
    }

    return Scaffold(
        body: ListView(
      children: [
        Header(
          title: 'MovieTips',
          buttonBack: DefaultButton(
              tap: sair,
              icon: Icon(
                Icons.logout_rounded,
                size: 30,
                color: Color.fromARGB(255, 0, 0, 0),
              )),
        ),
        CarouselMoviel(
          movieId: '242',
          title: 'Filmes de Ação para você',
        ),
        MovieList(title: "Populares", genero: "popular"),
        MovieList(title: "Melhores Avaliados", genero: "top_rated"),
        MovieList(title: "Novos", genero: "upcoming"),
        Category(title: "Categoría", genero: "upcoming")
      ],
    ));
  }
}

class _fireBaseAuth {}
