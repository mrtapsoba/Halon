import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decouvrir/models/interet_model.dart';

class InteretController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<InteretModel>> getUserInter(String userId) async {
    QuerySnapshot interet =
        await db.collection("users").doc(userId).collection("interets").get();
    return interet.docs.map((e) => InteretModel.fromDatabase(e)).toList();
  }

  Future setUserInteret(String userId, InteretModel interetModel) async {
    await db
        .collection("users")
        .doc(userId)
        .collection("intertets")
        .doc(interetModel.nom)
        .set({
      "nom": interetModel.nom,
      "poids": interetModel.poids,
      "update": DateTime.now()
    });
  }
}
