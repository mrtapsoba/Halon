import 'package:flutter/material.dart';
import 'package:decouvrir/models/constantes.dart';

class UserProfilPage extends StatefulWidget {
  const UserProfilPage({super.key});

  @override
  State<UserProfilPage> createState() => _UserProfilPageState();
}

class _UserProfilPageState extends State<UserProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Salut, TAPSOBA")),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(Constantes().imagetest))),
            child: Column(
              children: [
                Card(
                    child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 150,
                              width: 125,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(Constantes().imagetest)),
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(62.5)),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text("Nom d'utilisateur"),
                                    const Text("24 ans"),
                                    const Text("203 points"),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("Modifier"))
                                  ],
                                ))
                          ],
                        ))),
                Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    children: [
                      FloatingActionButton.extended(
                          elevation: 1,
                          onPressed: () {},
                          label: const Text(
                              "Inviter des amis et gagner des points")),
                      const ListTile(
                        title: Text("Notifications"),
                        trailing: Icon(Icons.notifications),
                      ),
                      const ListTile(
                        title: Text("Mes Sorties"),
                      ),
                      const ListTile(
                        title: Text("Mes préférences"),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Devenir partenaire evenementiel",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          )),
                      const ListTile(
                        title: Text("Conditions d'utilisation"),
                      ),
                      const ListTile(
                        title: Text("Politique de confidentialité"),
                      ),
                      TextButton(
                          onPressed: () {}, child: const Text("Déconnexion"))
                    ],
                  ),
                ))
              ],
            )),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1,
            onTap: (value) {
              if (value == 0) {
                Navigator.pop(context);
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Moi"),
            ]));
  }
}
