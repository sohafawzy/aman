import 'package:aman/bloc/auth/data/auth_api_service.dart';
import 'package:aman/bloc/auth/model/AuthResponse.dart';

import '../../../utils/result.dart';

class AuthRepository{
  AuthApiService authApiService = AuthApiService();

  Future<Result<AuthResponse>> login(String username, String pass) =>
      authApiService.login(username,pass);
}