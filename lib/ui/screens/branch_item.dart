import 'package:aman/bloc/branches/data/branches_bloc.dart';
import 'package:aman/bloc/branches/model/Branches.dart';
import 'package:aman/bloc/branches/model/BranchesResponse.dart';
import 'package:aman/ui/screens/branch_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_button.dart';

class BranchItem extends StatefulWidget {
  BranchesResponse branchesResponse;
  @override
  _BranchItemState createState() => _BranchItemState(branchesResponse);

  BranchItem(this.branchesResponse);
}

class _BranchItemState extends State<BranchItem> {
  BranchesResponse branchesResponse;

  _BranchItemState(this.branchesResponse);

  @override
  Widget build(BuildContext context) {

    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 8.0),
        child: SizedBox(
          width: double.infinity,
          height: 48.0,
          child: AppButton(
            text: branchesResponse.branchname,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BranchDetailsScreen(branchesResponse)
                ),
              );
            },
          ),
        ),
      )
    ]);
  }

}

