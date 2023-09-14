class Posts {
  List<Data>? data;

  Posts({this.data});

  Posts.fromJson(Map<String, dynamic> json) {
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
  List<String>? likes;
  String? post;
  String? image;
  String? userId;
  String? userName;
  String? createdAt;
  String? updatedAt;
  List<Comments>? comments;
  int? iV;
  String? userPhoto ; 
  Data(
      {this.sId,
      this.likes,
      this.post,
      this.image,
      this.userId,
      this.userName,
      this.createdAt,
      this.updatedAt,
      this.comments,
      this.iV,
      this.userPhoto
      });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    likes = json['likes'].cast<String>();
    post = json['post'];
    image = json['image'];
    userId = json['userId'];
    userName = json['userName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    iV = json['__v'];
    userPhoto = json['userPhoto']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['likes'] = this.likes;
    data['post'] = this.post;
    data['image'] = this.image;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    data['userPhoto'] = this.userPhoto ;
    return data;
  }
}

class Comments {
  String? userCommentId;
  String? comment;
  String? commmentUserName;
  String? sId;
  String? userCommentPhoto ; 
  String? commentImage ; 

  Comments({this.userCommentId, this.comment, this.commmentUserName, this.sId, this.userCommentPhoto,this.commentImage});

  Comments.fromJson(Map<String, dynamic> json) {
    userCommentId = json['userCommentId'];
    comment = json['comment'];
    commmentUserName = json['commmentUserName'];
    sId = json['_id'];
    userCommentPhoto = json['userCommentPhoto'];
    commentImage = json['commentImage']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userCommentId'] = this.userCommentId;
    data['comment'] = this.comment;
    data['commmentUserName'] = this.commmentUserName;
    data['_id'] = this.sId;
    data['userCommentPhoto'] = this.userCommentPhoto ; 
    data['commentImage'] = this.commentImage;
    return data;
  }
}