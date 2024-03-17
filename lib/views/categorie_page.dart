import 'package:decouvrir/controllers/post_controller.dart';
import 'package:decouvrir/models/post_model.dart';
import 'package:decouvrir/views/one_pub_page.dart';
import 'package:flutter/material.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({super.key, required this.categorie});
  final String categorie;
  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Categorie : ${widget.categorie}"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: FutureBuilder(
            future: PostController().getCategorie(widget.categorie),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              if (snapshot.hasData) {
                List<PostModel> catPosts = snapshot.requireData;
                if (catPosts.isEmpty) {
                  return const Text("Empty");
                }
                return ListView.builder(
                    itemCount: catPosts.length,
                    itemBuilder: (context2, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const OnePubPage();
                            }));
                          },
                          child: Card(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width: MediaQuery.of(context).size.width - 30,
                              height: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          catPosts[index].imageUrl![0]))),
                              child: Container(
                                  height: 100,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white60,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            catPosts[index].nom!,
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black),
                                          ),
                                          TextButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 35,
                                              ),
                                              label: Text(
                                                "${catPosts[index].noteMoy!}",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                        ],
                                      ),
                                      Text(catPosts[index].description!),
                                    ],
                                  )),
                            ),
                          ));
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
