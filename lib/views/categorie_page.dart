import 'package:decouvrir/views/one_pub_page.dart';
import 'package:flutter/material.dart';

class CategoriePage extends StatefulWidget {
  const CategoriePage({super.key});

  @override
  State<CategoriePage> createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorie : Evenements"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: ListView.builder(
          itemCount: 12,
          itemBuilder: (context2, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://i.pinimg.com/564x/a1/d9/e5/a1d9e521adae4ae4626bfbdc30fa8e29.jpg"))),
                    child: Container(
                        height: 100,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Kadel Food",
                                  style: TextStyle(
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
                                    label: const Text(
                                      "4,5",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              ],
                            ),
                            const Text("Petite description du lieu"),
                          ],
                        )),
                  ),
                ));
          }),
    );
  }
}
