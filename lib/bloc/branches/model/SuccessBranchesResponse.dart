/// message : "sucess"
/// status : true

class SuccessBranchesResponse {
  SuccessBranchesResponse({
      String message, 
      bool status,}){
    _message = message;
    _status = status;
}

  SuccessBranchesResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
  }
  String _message;
  bool _status;

  String get message => _message;
  bool get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    return map;
  }

}