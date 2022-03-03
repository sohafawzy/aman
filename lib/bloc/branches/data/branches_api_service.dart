import 'dart:convert';
import 'dart:io';

import 'package:aman/bloc/auth/model/AuthResponse.dart';
import 'package:aman/bloc/auth/model/ErrorResponse.dart';
import 'package:aman/bloc/branches/model/Branches.dart';
import 'package:aman/bloc/branches/model/BranchesResponse.dart';

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


  Future<Result<Branches>> getBranches() async {
    try {
      final response = await WebService.get().dioGet(UrlHelper.branchesUrl);
      if (response?.statusCode == 200) {
        Result<Branches> res =
        Result.success(Branches(List<BranchesResponse>.from(response.data.map((x) => BranchesResponse.fromJson(x)))));
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

  Future<Result<Branches>> getBranchDetails(int id) async {
    try {
      final response = await WebService.get().dioGet(UrlHelper.branchesUrl+"/${id}");
      if (response?.statusCode == 200) {
        Result<Branches> res =
        Result.success(Branches(List<BranchesResponse>.from(response.data.map((x) => BranchesResponse.fromJson(x)))));
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
