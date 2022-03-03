import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/branches/data/branches_bloc.dart';
import '../../utils/Utils.dart';
import 'attachment_preview.dart';

class UploadPhotosScreen extends StatefulWidget {
  String code;
  UploadPhotosScreen(this.code, {Key key}) : super(key: key);

  @override
  _UploadPhotosScreenState createState() => _UploadPhotosScreenState(code);
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {
  String code;
  bool isAvailable = false;
  final BranchesBloc _branchesBloc = BranchesBloc();

  _UploadPhotosScreenState(this.code);

  @override
  void initState() async{
    super.initState();
    var checkBranch = await _branchesBloc.checkBranch(code);
    if(checkBranch.getSuccessData() != null){
        setState(() {
          isAvailable= true;
        });
    }else if(checkBranch.getErrorMessage()!= null){
      showSnackbar(context, checkBranch.getErrorMessage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
                    child: Center(
                        child: Image(
                          image: AssetImage('assets/images/ic_aman.jpeg'),
                          width: 200.0,
                          height: 100.0,
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}


class AttachmentsWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _AttachmentsWidget();
}

class _AttachmentsWidget extends State<AttachmentsWidget> {
  bool isLoading = false;
  final picker = ImagePicker();
  bool hideAttachmentsButton = false;
  List<Attachment> attachments = [];
  bool showDeleteAttachmentButton = true;

  _AttachmentsWidget();

  @override
  void initState() {
    super.initState();
    setState(() {
      attachments.add(Attachment.create());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (_, index) => AttachmentPreview(
            attachment: attachments[index],
            onClick: (isVideo) {
              if (!attachments[index].containPicture()) {
                pickImageForAttachment(index);
              }
            },
            showDeleteBtn: true,
            onDelete: () {
              setState(
                    () {
                  attachments.remove(attachments[index]);
                },
              );
            },
          ),
          itemCount: attachments.length,
        ),
      ),
    ]);
  }

  Future pickImageForAttachment(int index) async {
    final XFile pickedFile =  await picker.pickImage(source: ImageSource.camera);


    print("file path is ${pickedFile.path}");
    File imageFile = File(pickedFile.path);
    // attachment.imageFile

    setState(() {
      isLoading = true;
    });

    var fileSize = (imageFile.lengthSync() / 1024) / 1024;

    setState(() {
      attachments.insert(
          index, Attachment(0, "", imageFile, null, inProgress: false));
    });


  }

  void stopLoadingAndShowError(String errorMessage) {
    showSnackbar(context, errorMessage);
    setState(() {
      isLoading = false;
    });
  }

}

class Attachment {
  int id;
  String name;
  File imageFile;
  String imageUrl;
  bool inProgress = false;

  Attachment(this.id, this.name, this.imageFile, this.imageUrl,{this.inProgress = false});

  Attachment.create();

  bool containPicture(){
    return imageFile != null || imageUrl != null;
  }
}

