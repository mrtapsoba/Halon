import 'package:decouvrir/controllers/auth_controller.dart';
import 'package:decouvrir/views/pref_page.dart';
import 'package:flutter/material.dart';

class IdentityPage extends StatefulWidget {
  const IdentityPage({super.key});

  @override
  State<IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Profil utilisateur 1 / 2")),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          child: ListView(children: [
            const Text(
              "Information personnelle",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text(
                "Votre age est demandé pour pouvoir vous proposer du contenu approprié. Vos informations personnelles ne sont pas partager avec des structure tiers."),
            const SizedBox(
              height: 25,
            ),
            Card(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
                ),
                const Text("Ajouter une photo\nde profil (facultatif)")
              ],
            )),
            const SizedBox(
              height: 25,
            ),
            Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.green, blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Nom d'utilisateur"),
                )),
            const SizedBox(
              height: 25,
            ),
            Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.green, blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton.icon(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime(1999),
                        firstDate: DateTime(1961),
                        lastDate: DateTime.now(),
                      );
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: const Text("Date de naissance"))),
            const SizedBox(
              height: 25,
            ),
            Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.green, blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Code de celui qui vous invite (facultatif)"),
                )),
            const SizedBox(
              height: 25,
            ),
            FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(context);
                  authController
                      .deconnexion(); /*
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const PrefPage();
                  }));*/
                },
                label: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 100,
                  child: const Text("Suivant",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                )),
          ]),
        ));
  }
}
