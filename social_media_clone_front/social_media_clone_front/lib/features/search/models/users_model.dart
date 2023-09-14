class Users {
  List<Data>? data;

  Users({this.data});

  Users.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? email;
  String? password;
  List<String>? follows;
  List<String>? followers;
  List<String>? likes;
  String? username;
  String? createdAt;
  int? iV;
  String? photo;

  Data(
      {this.sId,
      this.email,
      this.password,
      this.follows,
      this.followers,
      this.likes,
      this.username,
      this.createdAt,
      this.iV,
      this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    follows = json['follows'].cast<String>();
   followers = json['followers'].cast<String>(); 
    likes = json['likes'].cast<String>(); 
    username = json['username'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['follows'] = this.follows;
     data['followers'] = this.followers;
    data['likes'] = this.likes;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['photo'] = this.photo;
    return data;
  }
}