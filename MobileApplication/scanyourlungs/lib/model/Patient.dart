class Patient {
  int id;
  String nom;
  String email;

  Patient({this.id, this.nom, this.email});

  //from json
  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    email = json['email'];
  }
}
