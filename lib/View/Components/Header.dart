import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Login.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

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
            SizedBox(
              child: Center(
                child: Text(
                  'Movietips',
                  style: GoogleFonts.montserrat(
                      fontSize: 40, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              child: TextButton(
                onPressed: () {
                  sair();
                },
                child: Row(
                  children: [
                    Center(
                        child: Icon(
                      Icons.arrow_back_ios,
                      size: 12,
                    )),
                    Text('Logout')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
