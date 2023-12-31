import 'package:decouvrir/views/user_profil_page.dart';
import 'package:flutter/material.dart';

class PrefPage extends StatefulWidget {
  const PrefPage({super.key});

  @override
  State<PrefPage> createState() => _PrefPageState();
}

class _PrefPageState extends State<PrefPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profil utilisateur 2 / 2"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          child: ListView(children: [
            const Text(
              "Vos centres d'interets",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 250,
            ),
            FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UserProfilPage();
                  }));
                },
                label: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 100,
                  child: const Text("Enregistrer",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                )),
          ]),
        ));
  }
}
