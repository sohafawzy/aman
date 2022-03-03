
import 'dart:typed_data';

import 'package:aman/ui/screens/upload_photos_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart' as p;

import '../../utils/global.dart';
import '../widgets/AppLoader.dart';

class AttachmentPreview extends StatelessWidget {
  final Attachment attachment;
  final Function onClick;
  final bool showDeleteBtn;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: isAttachmentFilled()
                  ? buildImagePreview()
                  : buildPlaceHolderImage(),
            ),
            buildInProgressView(),
            buildDeleteBtn()
          ],
        ),
      ),
    );
  }


  Widget buildInProgressView() {
    return Visibility(
      visible: attachment.inProgress,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: Colors.black87,
          width: Get.width / 3.2,
          height: Get.height * 0.2,
          child: Center(
            child: AppLoader(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDeleteBtn() {
    return Visibility(
        visible: showDeleteBtn,
        child: Positioned(
            right: 0,
            child: attachment.imageUrl != null
                ? InkWell(
              onTap: () {
                onDelete();
              },
              child: SvgPicture.asset(
                'assets/images/ic-delete-profile-image.svg',
              ),
            )
                : Container()));
  }

  Widget buildImagePreview() {
    if (attachment.imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: attachment.imageUrl,
        width: Get.width / 3.2,
        height: Get.height * 0.2,
        fit: BoxFit.fill,
      );
    }
    if (attachment.imageFile != null) {
      return Image.file(
        attachment.imageFile,
        width: Get.width / 3.2,
        height: Get.height * 0.2,
        fit: BoxFit.fill,
      );
    }

    return Container();
  }



  Widget buildPlaceHolderImage() {
    return SvgPicture.asset(
      "assets/images/add-image-place-holder-mini.svg",
      width: Get.width / 3.2,
      height: Get.height * 0.2,
      fit: BoxFit.fill,
    );
  }

  bool isAttachmentFilled() {
    return attachment.imageFile != null || attachment.imageUrl != null;
  }

  AttachmentPreview(
      {this.attachment, this.onClick, this.showDeleteBtn, this.onDelete});
}
