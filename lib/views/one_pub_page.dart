import 'package:decouvrir/models/constantes.dart';
import 'package:decouvrir/views/comment_page.dart';
import 'package:flutter/material.dart';

class OnePubPage extends StatefulWidget {
  const OnePubPage({super.key});

  @override
  State<OnePubPage> createState() => _OnePubPageState();
}

class _OnePubPageState extends State<OnePubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width + 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(Constantes().imagetest)),
            )),
        Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            IconButton.filledTonal(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ],
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            builder: (context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  children: [
                    const Text(
                      "Kadel Food",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Text("Les catégories de l'évenement ou du lieu"),
                    const Text("Petite description du lieu"),
                    const Text(
                      "Adresse : Adresse complete du lieu",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text("Ouverture: 10h")),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Fermeture: 22h",
                              style: TextStyle(color: Colors.orange),
                            )),
                      ],
                    ),
                    const Text(
                      "Entrée : Gratuite",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            })
      ]),
      bottomNavigationBar: SizedBox(
          height: 120,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Ouvert",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.green),
                    ),
                    TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 35,
                        ),
                        label: const Text(
                          "4,5",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const CommentPage();
                          }));
                        },
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.black,
                        ),
                        label: const Text(
                          "23 commentaires",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                FloatingActionButton.extended(
                    onPressed: () {},
                    label: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        child: const Text("Planifier une sortie",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20))))
              ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
