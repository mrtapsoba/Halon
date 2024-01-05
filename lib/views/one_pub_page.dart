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
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://i.pinimg.com/564x/05/5e/4e/055e4e82d548029f91d96c30499341fb.jpg")),
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
            minChildSize: 0.45,
            maxChildSize: 0.9,
            builder: (context, ScrollController scrollController) {
              return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Scrollbar(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ListView(
                          controller: scrollController,
                          children: [
                            const Text(
                              "Kadel Food",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                                "Les catégories de l'évenement ou du lieu"),
                            const Text("Petite description du lieu"),
                            const Text(
                              "Adresse : Adresse complete du lieu",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Du 18 Dec 2023",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text("Au 22 Dec 2023",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
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
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            FloatingActionButton.extended(
                                elevation: 1,
                                onPressed: () {},
                                label: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: const Text("Planifier la sortie",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20)))),
                            const SizedBox(height: 20),
                            const Text(
                              "Simulaires",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                                height: 290,
                                child: ListView.builder(
                                    itemCount: 8,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          child: Column(children: [
                                        Container(
                                            width: 200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: const DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://i.pinimg.com/564x/fe/86/45/fe8645a2f65a18601b13465444d6c934.jpg")))),
                                        const Text(
                                          "RifkaLand",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Text(
                                              "Ouvert",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                            TextButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                label: const Text(
                                                  "4,5",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ]));
                                    }))
                          ],
                        )),
                  ));
            })
      ]),
      bottomNavigationBar: SizedBox(
          height: 60,
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
              ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
