class Name {
  String firstName;
  String lastName;
  Map toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName
    };
  }

  String toString() => "$firstName $lastName";
}



class DbName {
  String id;
  String firstName;
  String lastName;
}
