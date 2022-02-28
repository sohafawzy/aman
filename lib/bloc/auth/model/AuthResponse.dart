/// id : 3
/// username : "amro"
/// email : "allamnj@gmail.com"
/// roles : ["ROLE_MODERATOR","ROLE_USER"]
/// ismanager : true
/// accessToken : "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbXJvIiwiaWF0IjoxNjQ2MDA5ODI4LCJleHAiOjE2NDYwMTA3OTJ9.DlzMutubNYd34I5uXXArhu30ycf3OZAb9hF_g_cSHfRUmSPxXaZasRLF-ujIDIIG0EnVl9lTHYORvaC1D9Qohg"
/// tokenType : "Bearer"

class AuthResponse {
  AuthResponse({
      int id, 
      String username, 
      String email, 
      List<String> roles, 
      bool ismanager, 
      String accessToken, 
      String tokenType,}){
    _id = id;
    _username = username;
    _email = email;
    _roles = roles;
    _ismanager = ismanager;
    _accessToken = accessToken;
    _tokenType = tokenType;
}

  AuthResponse.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    _ismanager = json['ismanager'];
    _accessToken = json['accessToken'];
    _tokenType = json['tokenType'];
  }
  int _id;
  String _username;
  String _email;
  List<String> _roles;
  bool _ismanager;
  String _accessToken;
  String _tokenType;

  int get id => _id;
  String get username => _username;
  String get email => _email;
  List<String> get roles => _roles;
  bool get ismanager => _ismanager;
  String get accessToken => _accessToken;
  String get tokenType => _tokenType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['roles'] = _roles;
    map['ismanager'] = _ismanager;
    map['accessToken'] = _accessToken;
    map['tokenType'] = _tokenType;
    return map;
  }

}