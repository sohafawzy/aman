import 'auth_repository.dart';
import '../model/AuthResponse.dart';

import '../../../utils/result.dart';

class AuthBloc{
  AuthRepository authRepository = AuthRepository();

  Future<Result<AuthResponse>> login(String username, String pass) async {
    Result<AuthResponse> result = await authRepository.login(username,pass);
    return result;
  }

}