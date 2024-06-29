class photo {
  //int? id;
  String photoName;

  photo({ required this.photoName});

  Map<String, dynamic> toMap() {
    return {
    //  'id': id,
      'photoName': photoName,
    };
  }

  factory photo.fromMap(Map<String, dynamic> map) {
    return photo(
      //id: map['id'],
      photoName: map['photoName'],
    );
  }
}