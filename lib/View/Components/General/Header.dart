import 'package:Movietips/View/Components/General/SearchScreen.dart';
import 'package:Movietips/View/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

// ------------ HEADER COMPONENT ------------ //
class Header extends StatelessWidget {
  Header({Key? key, required this.title, required this.buttonBack});

  String title;

  final Widget buttonBack;

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

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: SearchScreen());
                },
                child: Icon(
                  Icons.search,
                  size: 30,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Center(
                child: RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                      text: title),
                ),
              ),
            ),
            buttonBack,
          ],
        ),
      ),
    );
  }
}
