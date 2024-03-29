import 'package:decouvrir/controllers/post_controller.dart';
import 'package:decouvrir/models/constantes.dart';
import 'package:decouvrir/models/post_model.dart';
import 'package:decouvrir/views/auth_page.dart';
import 'package:decouvrir/views/categorie_page.dart';
import 'package:decouvrir/views/one_pub_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.postModel});
  final PostModel? postModel;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchbar = false;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  User? auth = FirebaseAuth.instance.currentUser;
  PostController postController = PostController();

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
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text("Ou voulez vous allez aujourd'hui ?"))
                  : ListView(children: [
                      Center(
                          child: Text("\nBienvenue à ${Constantes().appName}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white))),
                      const SizedBox(height: 90),
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
                              borderRadius: BorderRadius.circular(20)),
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
                                onTap: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const CategoriePage(
                                      categorie: "Event",
                                    );
                                  }));
                                  /*await analytics.logBeginCheckout(
                                      value: 10.0,
                                      currency: 'USD',
                                      items: [
                                        AnalyticsEventItem(
                                            itemName: 'Event',
                                            itemId: 'Event',
                                            price: 10.0),
                                      ],
                                      coupon: '10PERCENTOFF');*/
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
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const CategoriePage(
                                      categorie: "Tourisme",
                                    );
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
                                              "https://i.pinimg.com/236x/76/fd/29/76fd2985f89767a97650222030401e45.jpg"))),
                                ))),
                            const Text("Tourisme")
                          ]),
                          Column(children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const CategoriePage(
                                      categorie: "Loisir",
                                    );
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
                                              "https://i.pinimg.com/564x/cc/26/b5/cc26b5a5782a9844a379313f15d115ec.jpg"))),
                                ))),
                            const Text("Loisirs")
                          ]),
                          Column(children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const CategoriePage(
                                      categorie: "Restaurant",
                                    );
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
                                              "https://i.pinimg.com/564x/fe/86/45/fe8645a2f65a18601b13465444d6c934.jpg"))),
                                ))),
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
                              child: FutureBuilder(
                                  future: postController.getPost(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      print(snapshot.error);
                                    }
                                    if (snapshot.hasData) {
                                      List<PostModel> catPosts =
                                          snapshot.requireData;
                                      if (catPosts.isEmpty) {
                                        return const Text("Empty");
                                      }
                                      return ListView.builder(
                                          controller: scrollController,
                                          itemCount: catPosts.length,
                                          itemBuilder: (context2, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return OnePubPage(
                                                      postModel:
                                                          catPosts[index],
                                                    );
                                                  }));
                                                },
                                                child: Card(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            30,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                catPosts[index]
                                                                        .imageUrl[
                                                                    0]))),
                                                    child: Container(
                                                        height: 100,
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.white70,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  catPosts[
                                                                          index]
                                                                      .nom!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                TextButton.icon(
                                                                    onPressed:
                                                                        () {},
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .yellow,
                                                                      size: 35,
                                                                    ),
                                                                    label: Text(
                                                                      "${catPosts[index].noteMoy!}",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              20),
                                                                    )),
                                                              ],
                                                            ),
                                                            Text(
                                                              catPosts[index]
                                                                  .description!,
                                                              maxLines: 2,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ));
                                          });
                                    }
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }))));
                }),
          ),
        ]),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (auth != null) {
                print("Instruction de reduction a faire !!");
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Utilisateur premium"),
                        content: const Text(
                            "Pour montrer votre présence chez un partenaire et beneficier de reduction voir meme de gratuité, veuillez vous connecter d'abord"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AuthPage();
                                }));
                              },
                              child: const Text("Me connecter")),
                        ],
                      );
                    });
              }
            },
            label: const Text("J'y suis")),
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
