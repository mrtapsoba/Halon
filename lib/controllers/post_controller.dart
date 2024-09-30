import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decouvrir/models/notation_model.dart';
import 'package:decouvrir/models/post_model.dart';

class PostController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<List<PostModel>> getPost() async {
    // Charger les nouvelles données depuis Firestore
    QuerySnapshot post = await db
        .collection("posts")
        .orderBy("date_post", descending: true)
        .get();

    List<PostModel> newPosts =
        post.docs.map((e) => PostModel.fromDatabase(e)).toList();
    // Vérifier les nouveaux posts par rapport au cache
    for (var newPost in newPosts) {
      print(newPost);
      int existingIndex =
          _cachedPosts.indexWhere((post) => post.id == newPost.id);

      if (existingIndex != -1) {
        // Si le post existe dans le cache, le remplacer par le nouveau post
        _cachedPosts[existingIndex] = newPost;
      } else {
        // Si le post n'existe pas dans le cache, l'ajouter
        _cachedPosts.add(newPost);
      }
    }
    return _cachedPosts;
  }

  List<PostModel> _cachedPosts =
      []; // Variable pour stocker les données précédemment chargées

  Future<List<PostModel>> getCategorie(String categorie,
      {bool isSimulaire = false}) async {
    QuerySnapshot post;
    // Charger les nouvelles données depuis Firestore
    if (isSimulaire == false) {
      post = await db
          .collection("posts")
          .where("type", isEqualTo: categorie)
          .orderBy("date_post", descending: true)
          .get();
    } else {
      post = await db
          .collection("posts")
          .where("type", isEqualTo: categorie)
          .orderBy(FieldPath
              .documentId) // Ordre aléatoire en utilisant les IDs des documents
          .limit(10) // Limiter le nombre de documents récupérés
          .get();
    }

    List<PostModel> newPosts =
        post.docs.map((e) => PostModel.fromDatabase(e)).toList();
    // Vérifier les nouveaux posts par rapport au cache
    for (var newPost in newPosts) {
      print(newPost);
      int existingIndex =
          _cachedPostsCat.indexWhere((post) => post.id == newPost.id);

      if (existingIndex != -1) {
        // Si le post existe dans le cache, le remplacer par le nouveau post
        _cachedPostsCat[existingIndex] = newPost;
      } else {
        // Si le post n'existe pas dans le cache, l'ajouter
        _cachedPostsCat.add(newPost);
      }
    }
    return _cachedPostsCat;
  }

  List<PostModel> _cachedPostsCat =
      []; // Variable pour stocker les données précédemment chargées

  Future setVisite(String postId, String userId) async {
    db
        .collection("posts")
        .doc(postId)
        .update({"visite_nbr": FieldValue.increment(1)});
  }

  Future setLike(String postId, String userId, bool isLiked) async {
    if (!isLiked) {
      db
          .collection("posts")
          .doc(postId)
          .collection("likes")
          .doc(userId)
          .delete();
      db
          .collection("posts")
          .doc(postId)
          .update({"note_moy": FieldValue.increment(-1)});
    } else {
      db
          .collection("posts")
          .doc(postId)
          .collection("likes")
          .doc(userId)
          .set({"user_id": userId, "date_visite": DateTime.now()});
      db
          .collection("posts")
          .doc(postId)
          .update({"note_moy": FieldValue.increment(1)});
    }
  }

  Future setNotation(String postId, NotationModel notationModel) async {
    db
        .collection("posts")
        .doc(postId)
        .collection("notations")
        .doc(notationModel.userId)
        .set({
      "user_id": notationModel.userId,
      "note": notationModel.note,
      "date_note": DateTime.now()
    });
  }

  Future setNewPost(PostModel postModel) async {
    db.collection("posts").add({
      "type": postModel.type,
      "nom": postModel.nom,
      "description": postModel.description,
      "adresse": postModel.adresse,
      "map_url": postModel.mapUrl,
      "entree": postModel.entree,
      "ouverture": postModel.ouverture,
      "fermeture": postModel.fermeture,
      "date_fin": postModel.dateFin,
      "date_debut": postModel.dateDebut,
      "categories": postModel.categories,
      "image_url": postModel.imageUrl,
      "age_min": postModel.ageMin,
      "comment_nbr": 0,
      "note_moy": 0,
      "visite_nbr": 0,
      "menus": postModel.menus,
      "lien": postModel.lien,
      "date_post": DateTime.now()
    });
  }
}
