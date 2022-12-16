class UserModel {
  UserModel(
    {
      required this.uid,
      required this.email,
      required this.displayName,
      required this.photoURL,
      required this.rating
    }
  );
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final double? rating;

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId){
    return UserModel(uid: documentId, email: data['email'], displayName: data['displayName'], photoURL: data['photoURL'], rating: data['rating']);
  }

  Map<String,dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'rating': rating,
    };
  }
}