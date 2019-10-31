class User {
  String uuid;
  String email;
  String photoURL;
  String displayName;
  String timestamp;

  User({
    this.uuid,
    this.email,
    this.photoURL,
    this.displayName,
    this.timestamp
  });

  
  User.fromJsonMap(Map<String, dynamic> json) {
    uuid = json["uuid"];
    email = json["email"];
    photoURL = json["photoURL"];
    displayName = json["displayName"];
    timestamp = json["timestamp"];
  }

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "email": email,
        "photoURL": photoURL,
        "displayName": displayName,
        "timestamp": timestamp
  };
}