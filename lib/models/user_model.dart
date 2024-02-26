import 'package:decouvrir/models/interet_model.dart';

class UserModel {
  String? nom;
  DateTime age;
  DateTime? connect;
  List<InteretModel>? centreI;
  List<InteretModel>? hiddenI;

  UserModel({this.nom, required this.age, this.centreI, this.hiddenI});
}
