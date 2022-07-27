import 'package:Movietips/View/Components/General/Carousel.dart';
import 'package:Movietips/View/Components/General/Category.dart';
import 'package:Movietips/View/Components/General/DefaultButton.dart';
import 'package:Movietips/View/Components/General/Header.dart';
import 'package:Movietips/View/Components/General/MovieList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'Login.dart';

// ------------ APP HOMEPAGE PAGE ------------ //
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ------- HomePage logout function ------- //
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

    // ------- Statusbar and notification Launcher ------- //
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // cor da barra superior
      statusBarIconBrightness: Brightness.dark, // ícones da barra superior
      systemNavigationBarColor: Colors.white, // cor da barra inferior
      systemNavigationBarIconBrightness:
          Brightness.dark, // ícones da barra inferior
    ));

    return Scaffold(
        backgroundColor: Colors.white,
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
