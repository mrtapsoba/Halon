import 'package:cloud_firestore/cloud_firestore.dart';

class InteretModel {
  String nom;
  int poids;
  InteretModel({required this.nom, required this.poids});

  factory InteretModel.fromDatabase(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return InteretModel(nom: data['nom'], poids: data['poids']);
  }
}
