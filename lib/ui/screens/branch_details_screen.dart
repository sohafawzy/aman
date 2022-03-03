import 'package:aman/bloc/branches/data/branches_bloc.dart';
import 'package:aman/bloc/branches/model/BranchesResponse.dart';
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
  @override
  _BranchDetailsScreenState createState() => _BranchDetailsScreenState();
}

class _BranchDetailsScreenState extends State<BranchDetailsScreen> {
  bool isLoading = false;
  BranchesBloc _bloc = BranchesBloc();


  _BranchDetailsScreenState();

  @override
  void initState() {
    super.initState();
    _bloc.getBranches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Branch Details"),backgroundColor: AppColors.primary,),
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
                  stream: _bloc.branchesList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data is SuccessResult) {
                        List<BranchesResponse> branchesList =
                        snapshot.data.getSuccessData().toList();
                        return branchesList.length < 1
                            ? Container(
                            child: const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                    child: Text(
                                      "No Branches",
                                    ))))
                            : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.only(
                                  top: 18,
                                  bottom: 18,
                                  right: 4,
                                  left: 4),
                              itemCount: branchesList.length,
                              itemBuilder: (context, index) {
                                var item = branchesList[index];
                                print(item.toJson());
                                return ListTile(
                                  title: BranchItem(
                                      item
                                  ),
                                );
                              },
                            ));
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
