class KioskList {
  String kioskTag;

  KioskList({
    this.kioskTag,
  });

  factory KioskList.fromJson(Map<String, dynamic> parsedJson){

    var kt = parsedJson['Status'];
    print('AAAAAAAAAAAAAAAAAAAAAAAAAAAA ' + kt);
    return KioskList(
        kioskTag: parsedJson['Status']
    );
  }
}

/*

class Body {
  final String userName;
  final List<KioskList> kioskList;

  Body({this.userName, this.kioskList});

  factory Body.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['kiosklist'] as List;
    print(list.runtimeType);
    List<KioskList> kioskList = list.map((i) => KioskList.fromJson(i)).toList();

    return Body(
        userName: parsedJson['username'],
        kioskList: kioskList
    );
  }
}

class KioskList {

  final String kioskTag;

  KioskList({
    this.kioskTag,
  });

  factory KioskList.fromJson(Map<String, dynamic> parsedJson){
    return KioskList(
        kioskTag: parsedJson['kiosktag']
    );
  }
}

*/
