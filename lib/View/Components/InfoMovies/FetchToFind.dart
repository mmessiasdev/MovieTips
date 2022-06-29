import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class FetchToFind extends StatefulWidget {
  FetchToFind({Key? key, required this.fetchSelect, required this.title})
      : super(key: key);
  Future<List<dynamic>> fetchSelect;
  String title;

  @override
  State<FetchToFind> createState() => _FetchToFindState();
}

class _FetchToFindState extends State<FetchToFind> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Center(
              child: Text(
                widget.title,
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: FutureBuilder<List>(
              future: widget.fetchSelect,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisSpacing: 0,
                        mainAxisExtent: 100,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var MovieApi = snapshot.data![index];
                        var url =
                            "https://www.themoviedb.org/t/p/w600_and_h600_bestv2";

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image(
                                height: 80,
                                width: 80,
                                image: CachedNetworkImageProvider(
                                  '${url}${MovieApi["logo_path"]}',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                          style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                          text:
                                              '${MovieApi["provider_name"]}')),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Casters Não existem'),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
