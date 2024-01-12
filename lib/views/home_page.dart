import 'package:decouvrir/models/constantes.dart';
import 'package:decouvrir/views/auth_page.dart';
import 'package:decouvrir/views/categorie_page.dart';
import 'package:decouvrir/views/one_pub_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchbar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Constantes().mainColor,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(Constantes().imagetest))),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 25, vertical: (searchbar) ? 35 : 0),
              child: (searchbar)
                  ? Container(
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Constantes().mainColor, blurRadius: 2)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text("Ou voulez vous allez aujourd'hui ?"))
                  : ListView(children: [
                      Center(
                          child: Text("Bienvenue à ${Constantes().appName}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white))),
                      const SizedBox(height: 110),
                      Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Constantes().mainColor,
                                    blurRadius: 2)
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child:
                              const Text("Ou voulez vous allez aujourd'hui ?")),
                      const SizedBox(height: 5),
                      const Text("Style de vie",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const CategoriePage();
                                  }));
                                },
                                child: Card(
                                    child: Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://i.pinimg.com/564x/a1/d9/e5/a1d9e521adae4ae4626bfbdc30fa8e29.jpg"))),
                                ))),
                            const Text("Evenements")
                          ]),
                          Column(children: [
                            Card(
                                child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://i.pinimg.com/236x/76/fd/29/76fd2985f89767a97650222030401e45.jpg"))),
                            )),
                            const Text("Tourisme")
                          ]),
                          Column(children: [
                            Card(
                                child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://i.pinimg.com/564x/cc/26/b5/cc26b5a5782a9844a379313f15d115ec.jpg"))),
                            )),
                            const Text("Loisirs")
                          ]),
                          Column(children: [
                            Card(
                                child: Container(
                              height: 75,
                              width: 75,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://i.pinimg.com/564x/fe/86/45/fe8645a2f65a18601b13465444d6c934.jpg"))),
                            )),
                            const Text("Restaurants")
                          ]),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Text("Pour toi !",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ])),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent > 0.7) {
                setState(() {
                  searchbar = true;
                });
              } else {
                setState(() {
                  searchbar = false;
                });
              }
              return true;
            },
            child: DraggableScrollableSheet(
                initialChildSize: (MediaQuery.of(context).size.height - 425) /
                    MediaQuery.of(context).size.height,
                minChildSize: 0.35,
                maxChildSize: (MediaQuery.of(context).size.height - 110) /
                    MediaQuery.of(context).size.height,
                builder: (context, ScrollController scrollController) {
                  return Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Scrollbar(
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: 12,
                                  itemBuilder: (context2, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const OnePubPage();
                                          }));
                                        },
                                        child: Card(
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                30,
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: const DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://i.pinimg.com/564x/05/5e/4e/055e4e82d548029f91d96c30499341fb.jpg"))),
                                            child: Container(
                                                height: 100,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white60,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        const Text(
                                                          "Kadel Food",
                                                          style: TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        TextButton.icon(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                              size: 35,
                                                            ),
                                                            label: const Text(
                                                              "4,5",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            )),
                                                      ],
                                                    ),
                                                    const Text(
                                                        "Petite description du lieu"),
                                                  ],
                                                )),
                                          ),
                                        ));
                                  }))));
                }),
          ),
        ]),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {}, label: const Text("J'y suis")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              if (value == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AuthPage();
                }));
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Moi"),
            ]));
  }
}
