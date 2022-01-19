class Doctor {
  int id;
  String first_name;
  String last_name;
  String signature;
  String email;
  String password;
  String role;

  Doctor(
      {this.id,
      this.first_name,
      this.last_name,
      this.signature,
      this.email,
      this.password,
      this.role});

  //from json
  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    signature = json['signature'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{id: $id, first_name: $first_name, last_name: $last_name, signature: $signature, email: $email, password: $password, role: $role}';
  }
}
