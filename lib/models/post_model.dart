import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String id;
  String? type;
  String? nom;
  String? description;
  String? adresse;
  String? mapUrl;
  int? entree;
  String? fermeture;
  String? ouverture;
  Timestamp? dateDebut;
  Timestamp? dateFin;
  List<dynamic>? categories;
  List<dynamic> imageUrl;
  int? ageMin;
  int? commentNbr;
  int? noteMoy;
  int? visiteNbr;
  int? poidsForUser;
  Timestamp? datePost;
  String? menus;
  String? lien;

  PostModel(
      {required this.id,
      this.type,
      this.nom,
      this.description,
      this.adresse,
      this.mapUrl,
      this.entree,
      this.ouverture,
      this.fermeture,
      this.dateDebut,
      this.dateFin,
      this.categories,
      required this.imageUrl,
      this.ageMin,
      this.commentNbr,
      this.noteMoy,
      this.poidsForUser,
      this.visiteNbr,
      this.datePost,
      this.menus,
      this.lien});

  factory PostModel.fromDatabase(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return PostModel(
        id: snapshot.id,
        type: data['type'],
        nom: data['nom'],
        description: data['description'],
        adresse: data['adresse'],
        mapUrl: data['map_url'],
        entree: data['entree'] as int,
        ouverture: data['ouverture'],
        fermeture: data['fermeture'],
        dateDebut: data['date_debut'],
        dateFin: data['date_fin'],
        datePost: data['date_post'],
        categories: data['categories'],
        imageUrl: data['image_url'],
        ageMin: data['age_min'] as int,
        commentNbr: data['comment_nbr'] as int,
        noteMoy: data['note_moy'] as int,
        visiteNbr: data['visite_nbr'] as int,
        menus: data['menus'],
        lien: data['lien']);
  }
}
