class User {
  String? sId;
  String? email;
  String? password;
  List<String>? follows;
  List<String>? followers;
  List<String>? likes;
  String? photo ; 
  String? username;
  int? iV;
  String? createdAt; 

  User(
      {this.sId,
      this.email,
      this.password,
      this.follows,
      this.followers,
      this.likes,
      this.username,
      this.iV, 
      this.photo,
this.createdAt
      });

 User.fromJson(Map<String, dynamic> json) {
  sId = json['_id'];
  email = json['email'];
  password = json['password'];
  if (json['follows'] != null) {
    follows = List.from(json['follows']);
  }
  if (json['followers'] != null) {
    followers = List.from(json['followers']);
  }
  if (json['likes'] != null) {
    likes = List.from(json['likes']);
  }
  username = json['username'];
  iV = json['__v'];
  photo = json['photo']; 
  createdAt = json['createdAt'];
}


}