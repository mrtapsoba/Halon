import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String id;
  String? type;
  String? nom;
  String? description;
  PostModel? lieu;
  String? adresse;
  String? mapUrl;
  int? entree;
  String? fermeture;
  String? ouverture;
  DateTime? dateDebut;
  DateTime? dateFin;
  Map<String, dynamic>? categories;
  String? imageUrl;
  int? ageMin;
  int? commentNbr;
  int? noteMoy;
  int? visiteNbr;
  int? poidsForUser;
  DateTime? datePost;

  PostModel(
      {required this.id,
      this.type,
      this.nom,
      this.description,
      this.lieu,
      this.adresse,
      this.mapUrl,
      this.entree,
      this.ouverture,
      this.fermeture,
      this.dateDebut,
      this.dateFin,
      this.categories,
      this.imageUrl,
      this.ageMin,
      this.commentNbr,
      this.noteMoy,
      this.poidsForUser,
      this.visiteNbr,
      this.datePost});

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
      ageMin: data['age_min'],
      commentNbr: data['comment_nbr'],
      noteMoy: data['note_moy'],
      visiteNbr: data['visite_nbr'],
    );
  }
}
