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
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(50),
                        child: const Text(
                          "Désolé nous n'avons pas trouvez d'evenements correspondants",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      Image.network(
                          "https://i.pinimg.com/564x/c9/22/68/c92268d92cf2dbf96e3195683d9e14fb.jpg"),
                      const Text(
                        "Veuillez faire une nouvelle recherche",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  );
                }
                return ListView.builder(
                    itemCount: catPosts.length,
                    itemBuilder: (context2, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return OnePubPage(
                                postModel: catPosts[index],
                              );
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
                                          catPosts[index].imageUrl[0]))),
                              child: Container(
                                  height: 100,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white70,
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
                                      Text(
                                        catPosts[index].description!,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),
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
