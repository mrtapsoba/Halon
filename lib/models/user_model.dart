import 'package:decouvrir/models/interet_model.dart';

class UserModel {
  String? nom;
  DateTime age;
  String? imageUrl;
  String? userPoints;
  DateTime? connect;
  List<InteretModel>? centreI;
  List<InteretModel>? hiddenI;

  UserModel(
      {this.nom,
      this.imageUrl,
      this.userPoints,
      required this.age,
      this.centreI,
      this.hiddenI});
}
