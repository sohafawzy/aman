import 'package:aman/bloc/branches/model/Branches.dart';
import 'package:aman/bloc/branches/model/BranchesResponse.dart';
import 'package:aman/bloc/branches/model/SuccessBranchesResponse.dart';

import 'branches_repository.dart';

import '../../../utils/result.dart';
import 'package:rxdart/rxdart.dart' as rx;

class BranchesBloc{
  BranchesRepository branchesRepository = BranchesRepository();

  final _branchesList = rx.PublishSubject<Result<List<BranchesResponse>>>();
  Stream<Result<List<BranchesResponse>>> get branchesList => _branchesList.stream;

  Future<Result<SuccessBranchesResponse>> checkBranch(String id) async {
    Result<SuccessBranchesResponse> result = await branchesRepository.checkBranch(id);
    return result;
  }


  Future<Result<Branches>> getBranches() async {
    Result<Branches> result = await branchesRepository.getBranches();
    if (result != null && result.getSuccessData() != null && result.getSuccessData().branchesList!= null ) {
      _branchesList.sink.add(Result.success(result.getSuccessData().branchesList));
    } else {
      _branchesList.sink.add(Result.error(result.getErrorMessage()));
    }
    return result;
  }
}