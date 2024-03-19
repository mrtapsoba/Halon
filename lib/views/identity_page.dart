import 'package:decouvrir/controllers/auth_controller.dart';
import 'package:decouvrir/controllers/user_controller.dart';
import 'package:decouvrir/views/pref_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:decouvrir/models/constantes.dart';

class IdentityPage extends StatefulWidget {
  const IdentityPage({super.key, required this.user});
  final AppUser user;

  @override
  State<IdentityPage> createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  AuthController authController = AuthController();
  TextEditingController username = TextEditingController();
  TextEditingController parrainCode = TextEditingController();
  String image = "";
  String imageUrl = "";
  DateTime? birthday;
  UserController userController = UserController();
  User? auth = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      imageUrl = auth!.photoURL!;
      username.text = auth!.displayName!;
    });
    super.initState();
  }

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
                      image: (imageUrl != "")
                          ? DecorationImage(image: NetworkImage(imageUrl))
                          : DecorationImage(image: AssetImage(image)),
                      borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
                ),
                const Text("Ajouter une photo\nde profil")
              ],
            )),
            const SizedBox(
              height: 25,
            ),
            Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: username,
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
                    boxShadow: [
                      BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton.icon(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime(1999, 9, 5),
                        firstDate: DateTime(1961),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        setState(() {
                          birthday = value;
                        });
                      });
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: Text(birthday != null
                        ? birthday.toString()
                        : "Date de naissance"))),
            const SizedBox(
              height: 25,
            ),
            Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: parrainCode,
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
                  if (username.text != "" && birthday != null) {
                    auth!.updateDisplayName(username.text);
                    String userIdentifiant = "";
                    if (auth!.phoneNumber != null) {
                      userIdentifiant = auth!.phoneNumber!;
                    } else if (auth!.email != null) {
                      userIdentifiant = auth!.email!;
                    }
                    userController
                        .setUserInfo(auth!.uid, userIdentifiant, username.text,
                            parrainCode.text, birthday!, imageUrl)
                        .then((value) => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PrefPage(
                                user: widget.user,
                              );
                            })));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Veuillez remplir correctement le nom et la date de naissance",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                label: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 100,
                  child: const Text("Enregister et Suivant",
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                )),
          ]),
        ));
  }
}
