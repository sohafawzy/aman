import 'package:aman/bloc/branches/data/branches_bloc.dart';
import 'package:aman/bloc/branches/model/BranchFile.dart';
import 'package:aman/bloc/branches/model/BranchesResponse.dart';
import 'package:aman/ui/screens/branch_image_item.dart';
import 'package:aman/ui/screens/branch_item.dart';
import 'package:aman/ui/screens/login_screen.dart';
import 'package:aman/ui/screens/qr_code_screen.dart';
import 'package:aman/utils/preference_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_button.dart';
import '../../utils/global.dart';
import '../../utils/result.dart';
import '../widgets/AppLoader.dart';

class BranchDetailsScreen extends StatefulWidget {
  BranchesResponse branch;

  BranchDetailsScreen(this.branch, {Key key}) : super(key: key);
  @override
  _BranchDetailsScreenState createState() => _BranchDetailsScreenState(branch);
}

class _BranchDetailsScreenState extends State<BranchDetailsScreen> {
  bool isLoading = false;
  BranchesBloc _bloc = BranchesBloc();

  BranchesResponse branch;

  _BranchDetailsScreenState(this.branch);

  @override
  void initState() {
    super.initState();
    _bloc.getBranchFiles(branch.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(branch.branchname),backgroundColor: AppColors.primary,),
        body: Container(
          color: Colors.white,
          child: isLoading
              ? Container(
            child: AppLoader(
              color: AppColors.primary,
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: StreamBuilder(
                  stream: _bloc.branchFilesList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data is SuccessResult) {
                        List<BranchFile> branchFiles =
                        snapshot.data.getSuccessData().toList();
                        return branchFiles.length < 1
                            ? Container(
                            child: const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: Text(""
                                    ))))
                            : Expanded(
                            child:  GridView(
                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                               mainAxisSpacing: 3,
                               crossAxisSpacing: 3
                        ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(4),
                              children: List<Widget>.generate(
                                  branchFiles.length, // same length as the data
                                      (index) => BranchImageItem(
                                          branchFiles[index]
                                      ),
                            )));
                        } else if (snapshot.data is LoadingResult) {
                        return Container(
                          height: 500,
                          child: Center(child:AppLoader(color: AppColors.primary)),
                        );
                      } else if (snapshot.data is ErrorResult) {
                        return Container();
                      } else {
                        return Container();
                      }
                    } else {
                      return Container(
                        height: 500,
                        child: Center(child:AppLoader(color: AppColors.primary)),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
