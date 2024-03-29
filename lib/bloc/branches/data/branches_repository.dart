import 'package:aman/bloc/auth/data/auth_api_service.dart';
import 'package:aman/bloc/auth/model/AuthResponse.dart';
import 'package:aman/bloc/branches/data/branches_api_service.dart';
import 'package:aman/bloc/branches/model/BranchFiles.dart';
import 'package:aman/bloc/branches/model/Branches.dart';
import 'package:aman/bloc/branches/model/SuccessBranchesResponse.dart';

import '../../../utils/result.dart';

class BranchesRepository{
  BranchesApiService branchesApiService = BranchesApiService();

  Future<Result<SuccessBranchesResponse>> checkBranch(String id) =>
      branchesApiService.checkBranch(id);


  Future<Result<Branches>> getBranches() =>
      branchesApiService.getBranches();

  Future<Result<BranchFiles>> getBranchFiles(String id) =>
      branchesApiService.getBranchDetails(id);
}