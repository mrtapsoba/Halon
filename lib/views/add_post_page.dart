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
      body: ListView(
        children: [
          Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                //controller: username,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Titre de la publication"),
              )),
          Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                //controller: username,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description de la publication"),
              )),
          Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                //controller: username,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Adresse ..."),
              )),
          Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Constantes().mainColor, blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                //controller: username,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Menu disponible ..."),
              )),
        ],
      ),
    );
  }
}
