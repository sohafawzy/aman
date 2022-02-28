/// timestamp : "2022-02-28T01:06:52.771+0000"
/// status : 401
/// error : "Unauthorized"
/// message : "Error: Unauthorized"
/// path : "/amanstore/api/auth/signin"

class ErrorResponse {
  ErrorResponse({
      String timestamp, 
      int status, 
      String error, 
      String message, 
      String path,}){
    _timestamp = timestamp;
    _status = status;
    _error = error;
    _message = message;
    _path = path;
}

  ErrorResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _error = json['error'];
    _message = json['message'];
    _path = json['path'];
  }
  String _timestamp;
  int _status;
  String _error;
  String _message;
  String _path;

  String get timestamp => _timestamp;
  int get status => _status;
  String get error => _error;
  String get message => _message;
  String get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['error'] = _error;
    map['message'] = _message;
    map['path'] = _path;
    return map;
  }

}