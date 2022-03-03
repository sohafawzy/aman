import 'package:aman/bloc/branches/data/branches_bloc.dart';
import 'package:aman/bloc/branches/model/BranchFile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_button.dart';

class BranchImageItem extends StatefulWidget {
  BranchFile branchFile;
  @override
  _BranchImageItemState createState() => _BranchImageItemState(branchFile);

  BranchImageItem(this.branchFile);
}

class _BranchImageItemState extends State<BranchImageItem> {
  BranchFile branchFile;

  _BranchImageItemState(this.branchFile);

  @override
  Widget build(BuildContext context) {

    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          width: double.infinity,
          height: 80.0,
          child: CachedNetworkImage(imageUrl:branchFile.url,
            fit: BoxFit.fill,

          ),
        ),
      )
    ]);
  }

}

