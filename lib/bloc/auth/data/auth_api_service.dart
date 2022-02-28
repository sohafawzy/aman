import 'dart:convert';
import 'dart:io';

import 'package:aman/bloc/auth/model/AuthResponse.dart';
import 'package:aman/bloc/auth/model/ErrorResponse.dart';

import '../../../network/web_service.dart';
import '../../../utils/result.dart';
import '../../../utils/url_helper.dart';

class AuthApiService {
  Future<Result<AuthResponse>> login(String username, String pass) async {
    try {
      final response = await WebService.get().dioPost(UrlHelper.login,
          body: {"username": username, "password": pass});
      if (response.statusCode == 200) {
        Result<AuthResponse> res =
            Result.success(AuthResponse.fromJson(response.data));
        return res;
      } else {
        return Result.error(ErrorResponse.fromJson(response.data).message);
      }
    } on SocketException catch (e) {
      return Result.error("No Internet Connection");
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
