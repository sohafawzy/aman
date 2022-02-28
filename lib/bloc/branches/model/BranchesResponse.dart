/// id : "1"
/// branchname : "tahreir"
/// address : null
/// message : "sucess"

class BranchesResponse {
  BranchesResponse({
      String id, 
      String branchname, 
      dynamic address, 
      String message,}){
    _id = id;
    _branchname = branchname;
    _address = address;
    _message = message;
}

  BranchesResponse.fromJson(dynamic json) {
    _id = json['id'];
    _branchname = json['branchname'];
    _address = json['address'];
    _message = json['message'];
  }
  String _id;
  String _branchname;
  dynamic _address;
  String _message;

  String get id => _id;
  String get branchname => _branchname;
  dynamic get address => _address;
  String get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['branchname'] = _branchname;
    map['address'] = _address;
    map['message'] = _message;
    return map;
  }

}