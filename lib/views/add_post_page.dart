import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decouvrir/controllers/post_controller.dart';
import 'package:decouvrir/models/constantes.dart';
import 'package:decouvrir/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:decouvrir/controllers/file_controller.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String? type;
  DateTime? dateDebut;
  DateTime? dateFin;
  TimeOfDay? heureDebut;
  TimeOfDay? heureFin;
  TextEditingController titre = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController lienmaps = TextEditingController();
  TextEditingController menus = TextEditingController();

  List<XFile> _selectedImage = [];
  List<String> _imagesLinks = [];

  TextEditingController entree = TextEditingController();
  TextEditingController ageMin = TextEditingController();

  bool publication = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Publication"),
        backgroundColor: Constantes().mainColor,
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(10)),

                ///color: Colors.lightBlue,
                child: DropdownButton<String>(
                    hint: const Text('Choisir ce que vous publier !'),
                    value: type,
                    iconSize: 20,
                    items: const [
                      DropdownMenuItem(
                          value: "Event", child: Text("Evenement")),
                      DropdownMenuItem(
                          value: "Tourisme", child: Text("Tourisme")),
                      DropdownMenuItem(
                          value: "Divertissement",
                          child: Text("Divertissement")),
                      DropdownMenuItem(
                          value: "Restaurant", child: Text("Restaurant")),
                    ],
                    onChanged: (String? cat) {
                      setState(() {
                        type = cat;
                      });
                    }),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: titre,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Titre de la publication"),
                  )),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    //textAlign: TextAlign.center,
                    controller: description,
                    keyboardType: TextInputType.text,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description de la publication"),
                  )),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: entree,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Prix d'entree minimum"),
                  )),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: ageMin,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Age minimum"),
                  )),
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton.tonalIcon(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: dateDebut,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2027),
                        ).then((value) {
                          setState(() {
                            dateDebut = value;
                          });
                        });
                      },
                      icon: const Icon(Icons.start),
                      label: Text(dateDebut != null
                          ? "${dateDebut!.day} / ${dateDebut!.month} / ${dateDebut!.year}"
                          : "Date debut")),
                  FilledButton.tonalIcon(
                      onPressed: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          setState(() {
                            heureDebut = value;
                          });
                        });
                      },
                      icon: const Icon(Icons.start),
                      label: Text(heureDebut != null
                          ? "${heureDebut!.hour}H${heureDebut!.minute}"
                          : "Heure debut")),
                ],
              )),
              SizedBox(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilledButton.icon(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: dateDebut,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2027),
                        ).then((value) {
                          setState(() {
                            dateFin = value;
                          });
                        });
                      },
                      icon: const Icon(Icons.stop),
                      label: Text(dateFin != null
                          ? "${dateFin!.day} / ${dateFin!.month} / ${dateFin!.year}"
                          : "Date Fin")),
                  FilledButton.icon(
                      onPressed: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          setState(() {
                            heureFin = value;
                          });
                        });
                      },
                      icon: const Icon(Icons.stop),
                      label: Text(heureFin != null
                          ? "${heureFin!.hour}H${heureFin!.minute}"
                          : "Heure Fin")),
                ],
              )),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    //textAlign: TextAlign.center,
                    controller: adresse,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Adresse ..."),
                  )),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    //textAlign: TextAlign.center,
                    controller: lienmaps,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Lien vers le maps (localisation)"),
                  )),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    //textAlign: TextAlign.center,
                    controller: menus,
                    keyboardType: TextInputType.text,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Menu disponible ..."),
                  )),
              ListTile(
                  title: const Text("Ajouter des images, photos illustratifs"),
                  trailing: const Icon(Icons.add_a_photo),
                  onTap: () {
                    _pickImageFromGallery();
                  }),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImage.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        child: Image.file(File(_selectedImage[index].path)),
                      );
                    }),
              ),
            ],
          )),
      bottomNavigationBar: (publication == false)
          ? FloatingActionButton.extended(
              onPressed: () async {
                setState(() {
                  publication = true;
                });

                String message = "";
                if (type == null || type!.isEmpty) {
                  message = "Le champ 'type' est null ou vide.";
                  //} else if (dateDebut == null) {
                  //  message = "Le champ 'dateDebut' est null.";
                  //} else if (dateFin == null) {
                  //  message = "Le champ 'dateFin' est null.";
                  //} else if (heureDebut == null) {
                  //  message = "Le champ 'heureDebut' est null.";
                  //} else if (heureFin == null) {
                  //  message = "Le champ 'heureFin' est null.";
                } else if (titre.text.isEmpty) {
                  message = "Le champ 'titre' est vide.";
                } else if (description.text.isEmpty) {
                  message = "Le champ 'description' est vide.";
                } else if (adresse.text.isEmpty) {
                  message = "Le champ 'adresse' est vide.";
                  //} else if (lienmaps.text.isEmpty) {
                  //  message = "Le champ 'lienmaps' est vide.";
                  //} else if (menus.text.isEmpty) {
                  //  message = "Le champ 'menus' est vide.";
                } else if (_selectedImage.isEmpty) {
                  message = "Le champ '_selectedImage' est vide.";
                  //} else if (_imagesLinks.isEmpty) {
                  //  message = "Le champ '_imagesLinks' est vide.";
                  //} else if (entree.text.isEmpty) {
                  //  message = "Le champ 'entree' est vide.";
                  //} else if (ageMin.text.isEmpty) {
                  //  message = "Le champ 'ageMin' est vide.";
                }

                if (message != "") {
                  setState(() {
                    publication = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(message), backgroundColor: Colors.orange));
                } else {
                  if (_selectedImage.isNotEmpty) {
                    print(_selectedImage);
                    for (var element in _selectedImage) {
                      await FileController()
                          .uploadFile(element, "png", "eventsfolder");
                      if (Constantes.fileLink != null) {
                        _imagesLinks.add(Constantes.fileLink!);
                      }
                    }
                    PostController().setNewPost(PostModel(
                        id: "id",
                        type: type,
                        nom: titre.text,
                        description: description.text,
                        adresse: adresse.text,
                        mapUrl: lienmaps.text,
                        entree: int.parse(entree.text),
                        fermeture: "${heureDebut!.hour}H${heureDebut!.minute}",
                        ouverture: "${heureFin!.hour}H${heureFin!.minute}",
                        dateDebut: Timestamp.fromDate(dateDebut!),
                        dateFin: Timestamp.fromDate(dateFin!),
                        ageMin: int.parse(ageMin.text),
                        menus: menus.text,
                        lien: "............",
                        imageUrl: _imagesLinks));

                    setState(() {
                      publication = false;
                      type = null;
                      dateDebut = null;
                      dateFin = null;
                      heureDebut = null;
                      heureFin = null;
                      titre.clear();
                      description.clear();
                      adresse.clear();
                      lienmaps.clear();
                      menus.clear();
                      _selectedImage.clear();
                      _imagesLinks.clear();
                      entree.clear();
                      ageMin.clear();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Publication effectuée avec succes"),
                        backgroundColor: Colors.green));
                  }
                }
              },
              label: const Text("Publiier maintenant",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)))
          : const ListTile(
              title: Text("Publication en cours, veuillez patienter"),
              trailing: CircularProgressIndicator(),
            ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickMultiImage();
    if (returnedImage == []) return;
    setState(() {
      _selectedImage = returnedImage;
    });
  }
}
