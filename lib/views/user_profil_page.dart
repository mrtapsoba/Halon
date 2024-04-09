import 'dart:io';

import 'package:decouvrir/controllers/auth_controller.dart';
import 'package:decouvrir/controllers/user_controller.dart';
import 'package:decouvrir/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:decouvrir/models/constantes.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilPage extends StatefulWidget {
  const UserProfilPage(
      {super.key, required this.userId, required this.userModel});
  final String userId;
  final UserModel userModel;

  @override
  State<UserProfilPage> createState() => _UserProfilPageState();
}

class _UserProfilPageState extends State<UserProfilPage> {
  TextEditingController username = TextEditingController();
  UserController userController = UserController();
  @override
  void initState() {
    setState(() {
      username.text = widget.userModel.nom!;
      birthday = widget.userModel.age;
    });
    super.initState();
  }

  File? _selectedImage;
  DateTime? birthday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Salut, ${username.text}")),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(Constantes().imagetest))),
            child: ListView(
              children: [
                Card(
                    child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.bottomCenter,
                              height: 150,
                              width: 125,
                              decoration: BoxDecoration(
                                  image: (widget.userModel.imageUrl != null)
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              widget.userModel.imageUrl!))
                                      : const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "widget.userModel.imageUrl!")),
                                  color: Constantes().mainColor,
                                  borderRadius: BorderRadius.circular(62.5)),
                              child: IconButton(
                                  onPressed: () async {
                                    await _pickImageFromGallery();
                                    if (_selectedImage != null) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text("Photo de profil"),
                                              content: _selectedImage != null
                                                  ? Image.file(_selectedImage!)
                                                  : const Text(
                                                      "Aucune photo selectionnée"),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {},
                                                    child: const Text(
                                                        "Enregistrer"))
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  icon: const Icon(Icons.add_a_photo)),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      username.text,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        "Age : ${DateTime.now().year - widget.userModel.age.year} ans"),
                                    Text(widget.userModel.userPoints != null
                                        ? "Fidélité : ${widget.userModel.userPoints!} points"
                                        : "Fidélité : 00 points"),
                                    FilledButton.tonal(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Modifier mon profil"),
                                                    content: SizedBox(
                                                      height: 120,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            controller:
                                                                username,
                                                          ),
                                                          ListTile(
                                                            title: Text(birthday !=
                                                                    null
                                                                ? birthday
                                                                    .toString()
                                                                : "Date de naissance"),
                                                            trailing:
                                                                const Icon(Icons
                                                                    .calendar_month),
                                                            onTap: () {
                                                              showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    birthday,
                                                                firstDate:
                                                                    DateTime(
                                                                        1961),
                                                                lastDate:
                                                                    DateTime
                                                                        .now(),
                                                              ).then((value) {
                                                                setState(() {
                                                                  birthday =
                                                                      value;
                                                                });
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            userController
                                                                .updateUserInfo(
                                                                    widget
                                                                        .userId,
                                                                    "nom",
                                                                    username
                                                                        .text);
                                                            userController
                                                                .updateUserInfo(
                                                                    widget
                                                                        .userId,
                                                                    "birthday",
                                                                    birthday);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Enregistrer"))
                                                    ],
                                                  );
                                                });
                                              });
                                        },
                                        child: const Text("Modifier"))
                                  ],
                                ))
                          ],
                        ))),
                Card(
                    child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Column(
                    children: [
                      const Text(
                        "Sortons comme des stars",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Image.network(
                            "https://i.pinimg.com/564x/50/dd/56/50dd56c2c9cb0dd152527cc0a193b792.jpg"),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                              "Partager a des amis et gagner des points")),
                      const ListTile(
                        title: Text("Notifications"),
                        trailing: Icon(Icons.notifications),
                      ),
                      /*const ListTile(
                        title: Text("Mes Sorties"),
                      ),
                      const ListTile(
                        title: Text("Mes préférences"),
                      ),
                      FilledButton.tonal(
                          onPressed: () {},
                          child: const Text(
                            "Devenir partenaire evenementiel",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          )),*/
                      const ListTile(
                        title: Text("Conditions d'utilisation"),
                      ),
                      const ListTile(
                        title: Text("Politique de confidentialité"),
                      ),
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Notification"),
                                    content: const Text(
                                        "Voulez vous vraiment vous deconnecter ?"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Annuler")),
                                      TextButton(
                                          onPressed: () {
                                            AuthController().deconnexion();
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Oui"))
                                    ],
                                  );
                                });
                          },
                          child: const Text("Déconnexion")),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 60,
                )
              ],
            )),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              print("Instruction de reduction a faire !!");
            },
            icon: const Icon(Icons.add),
            label: const Text("Ajouter")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
