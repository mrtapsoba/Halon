import 'package:decouvrir/controllers/post_controller.dart';
import 'package:decouvrir/controllers/user_controller.dart';
import 'package:decouvrir/models/post_model.dart';
import 'package:decouvrir/views/auth_page.dart';
//import 'package:decouvrir/views/comment_page.dart';
import 'package:decouvrir/views/container/container_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:decouvrir/models/constantes.dart';

class OnePubPage extends StatefulWidget {
  const OnePubPage({super.key, required this.postModel});
  final PostModel postModel;
  @override
  State<OnePubPage> createState() => _OnePubPageState();
}

class _OnePubPageState extends State<OnePubPage> {
  User? auth = FirebaseAuth.instance.currentUser;
  PostController postController = PostController();
  UserController userController = UserController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userController
            .getlike(auth != null ? auth!.uid : Constantes().appName),
        builder: ((context, snapshotStream) {
          print(auth!.uid);
          List<Map<String, dynamic>> myLiked = [];
          if (snapshotStream.hasError) {
            print("echo");
            print(snapshotStream.error);
          }
          if (snapshotStream.hasData) {
            myLiked = snapshotStream.data as List<Map<String, dynamic>>;
            print(myLiked);
          }
          return Scaffold(
            body: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://i.pinimg.com/564x/05/5e/4e/055e4e82d548029f91d96c30499341fb.jpg")),
                ),
                child: ContainerList(widget.postModel.imageUrl),
              ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 10,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 150),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "${widget.postModel.nom}",
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      "Catégories : ${widget.postModel.categories}"),
                                  Text("${widget.postModel.description}"),
                                  Text(
                                    "Adresse : ${widget.postModel.adresse}",
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          widget.postModel.dateDebut != null
                                              ? "Debut ${widget.postModel.dateDebut?.toDate().day} / ${widget.postModel.dateDebut?.toDate().month} / ${widget.postModel.dateDebut?.toDate().year}"
                                              : "",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          widget.postModel.dateFin != null
                                              ? "Fin ${widget.postModel.dateFin?.toDate().day} / ${widget.postModel.dateFin?.toDate().month} / ${widget.postModel.dateFin?.toDate().year}"
                                              : "",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                              "Ouverture: ${widget.postModel.ouverture}")),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Fermeture: ${widget.postModel.fermeture}",
                                            style: const TextStyle(
                                                color: Colors.orange),
                                          )),
                                    ],
                                  ),
                                  Text(
                                    "Ouvert au +${widget.postModel.ageMin} ans,  Entrée : ${widget.postModel.entree != 0 ? widget.postModel.entree : 'Gratuite'}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ExpansionTile(
                                    leading: const Icon(Icons.discount),
                                    backgroundColor:
                                        Constantes().mainColor.withOpacity(0.2),
                                    title: const Text(
                                      "Reduction du menu pour toi !",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle:
                                        const Text("Cliquer pour voir menu"),
                                    children: [
                                      Text("${widget.postModel.menus}"),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Simulaires",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                      height: 290,
                                      child: ListView.builder(
                                          itemCount: 3,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Card(
                                                child: Column(children: [
                                              Container(
                                                width: 200,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          "https://i.pinimg.com/564x/fe/86/45/fe8645a2f65a18601b13465444d6c934.jpg")),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              const Text(
                                                "RifkaLand",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  const Text(
                                                    "A venir   ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  ),
                                                  TextButton.icon(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.red,
                                                      ),
                                                      label: const Text(
                                                        "45",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ]));
                                          })),
                                  const SizedBox(
                                    height: 100,
                                  )
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
                          Text(
                            "En cours",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: Constantes().mainColor),
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text("Partager",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900))),
                          TextButton.icon(
                              onPressed: () {
                                if (auth != null) {
                                  if (myLiked.any((element) =>
                                      element["postId"].toString() ==
                                      widget.postModel.id)) {
                                    userController.setLike(
                                        widget.postModel.id, auth!.uid, false);
                                    postController.setLike(
                                        widget.postModel.id, auth!.uid, false);
                                  } else {
                                    userController.setLike(
                                        widget.postModel.id, auth!.uid, true);
                                    postController.setLike(
                                        widget.postModel.id, auth!.uid, true);
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Utilisateur non-connecté"),
                                          content: const Text(
                                              "Pour pouvoir publier des evenements ou plus vous devez vous connecter d'abord"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return const AuthPage();
                                                  }));
                                                },
                                                child:
                                                    const Text("Me connecter")),
                                          ],
                                        );
                                      });
                                }
                              },
                              icon: myLiked.any((element) =>
                                      element["postId"].toString() ==
                                      widget.postModel.id)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 35,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                              label: Text(
                                myLiked.any((element) =>
                                        element["postId"].toString() ==
                                        widget.postModel.id)
                                    ? "${widget.postModel.noteMoy! + 1}"
                                    : "${widget.postModel.noteMoy!}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                        ],
                      ),
                    ])),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("J'y vais / Localisation"),
              icon: const Icon(Icons.location_on),
            ),
          );
        }));
  }
}
