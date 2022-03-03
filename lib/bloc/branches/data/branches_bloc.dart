import 'package:aman/bloc/branches/model/BranchFile.dart';
import 'package:aman/bloc/branches/model/BranchFiles.dart';
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

  final _branchesFilesList = rx.PublishSubject<Result<List<BranchFile>>>();
  Stream<Result<List<BranchFile>>> get branchFilesList => _branchesFilesList.stream;


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

  Future<Result<BranchFiles>> getBranchFiles(String id) async {
    Result<BranchFiles> result = await branchesRepository.getBranchFiles(id);
    if (result != null && result.getSuccessData() != null && result.getSuccessData().branchFilesList!= null ) {
      _branchesFilesList.sink.add(Result.success(result.getSuccessData().branchFilesList));
    } else {
      _branchesFilesList.sink.add(Result.error(result.getErrorMessage()));
    }
    return result;
  }
}