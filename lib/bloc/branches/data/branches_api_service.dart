import 'dart:convert';
import 'dart:io';

import 'package:aman/bloc/auth/model/AuthResponse.dart';
import 'package:aman/bloc/auth/model/ErrorResponse.dart';

import '../../../network/web_service.dart';
import '../../../utils/result.dart';
import '../../../utils/url_helper.dart';
import '../model/SuccessBranchesResponse.dart';

class BranchesApiService {
  Future<Result<SuccessBranchesResponse>> checkBranch(String branch) async {
    try {
      final response = await WebService.get().dioGet(UrlHelper.checkBranchUrl+branch);
      if (response.statusCode == 200) {
        Result<SuccessBranchesResponse> res =
            Result.success(SuccessBranchesResponse.fromJson(response.data));
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
