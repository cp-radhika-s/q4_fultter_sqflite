class User {
  late int id;
  late String name;
  late String email;
  late int age;

  User(this.name, this.email, this.age);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'email': email,
      'age': age
    };
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    age = map['age'];
  }
}
