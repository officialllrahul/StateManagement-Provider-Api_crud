
class UserProfile  {
  late String name;

// constructor
  UserProfile({
    required this.name,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson()=> {

    "name":name,

  };


}