class UserModel {
  String? uid;
  String? name;


  UserModel(
      {this.uid,
      this.name,
    });

//reciving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
    );
  }

//sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,

    };
  }
}
