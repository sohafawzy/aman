import 'package:aman/bloc/branches/model/SuccessBranchesResponse.dart';

import 'branches_repository.dart';

import '../../../utils/result.dart';

class BranchesBloc{
  BranchesRepository branchesRepository = BranchesRepository();

  Future<Result<SuccessBranchesResponse>> checkBranch(String id) async {
    Result<SuccessBranchesResponse> result = await branchesRepository.checkBranch(id);
    return result;
  }

}