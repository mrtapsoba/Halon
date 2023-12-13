class PostModel {
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
      {this.type,
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
}
