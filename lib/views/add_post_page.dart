import 'package:decouvrir/models/constantes.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Publication"),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    //controller: username,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Titre de la publication"),
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    //controller: username,
                    keyboardType: TextInputType.text,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description de la publication"),
                  )),
              Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    //controller: username,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Adresse ..."),
                  )),
              Container(
                  margin:const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    //controller: username,
                    keyboardType: TextInputType.text,
                    minLines: 2,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Menu disponible ..."),
                  )),
            ],
          )),
    );
  }
}
