class MyUser {
  String name;
  String phoneNumber;
  String img;
  Map<String, dynamic> socialMediaPlatforms;
  String uid;
  MyUser({
    this.img = '',
    this.name = '',
    this.phoneNumber = '',
    this.socialMediaPlatforms = const {},
    this.uid = '',
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': phoneNumber,
      'img': img,
      'socialMediaPlatforms': socialMediaPlatforms,
    };
  }

  MyUser fromMap(Map<String, dynamic>? mymap) {
    return MyUser(
      img: mymap!['img'],
      name: mymap['name'],
      phoneNumber: mymap['number'],
      socialMediaPlatforms: mymap['socialMediaPlatforms'],
    );
  }

  // MyUser createFriend(Map<String, dynamic>? mymap) {
  //   return MyUser(
  //     img: mymap!['img'],
  //     name: mymap['name'],
  //     phoneNumber: mymap['number'],
  //     // socialMediaPlatforms: mymap['socialMediaPlatforms'],
  //   );
  // }
}

class MyNetwork {
  List<dynamic> myNerwork;
  MyNetwork({
    this.myNerwork = const [],
  });
  Map<String, dynamic> toMap() {
    return {
      'myNetwork': myNerwork,
    };
  }

  MyNetwork fromMap(Map<String, dynamic>? mymap) {
    return MyNetwork(myNerwork: mymap!['myNetwork']);
  }
}

class Group {
  String name;
  String img;
  String uid;
  List<dynamic> members;
  Group({
    this.img = '',
    this.name = '',
    this.uid = '',
    this.members = const [],
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'img': img,
      'members': members,
    };
  }

  Group fromMap(Map<String, dynamic>? mymap) {
    return Group(
      img: mymap!['img'],
      name: mymap['name'],
      members: mymap['members'],
      // phoneNumber: mymap['number'],
    );
  }
}
