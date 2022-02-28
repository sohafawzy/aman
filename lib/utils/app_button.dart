import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'global.dart';

class AppButton extends StatelessWidget {
  String text;
  Color accentColor;
  ButtonType type;
  bool enabled;
  Function onPressed;
  double width;
  double fontSize;
  RoundedLoadingButtonController _btnController;

  @override
  Widget build(BuildContext context) {
    Color bgColor, textColor, borderColor;
    if (type == ButtonType.Filled) {
      if (enabled) {
        textColor = AppColors.white;
        bgColor = accentColor;
        borderColor = accentColor;
      } else {
        textColor = AppColors.white;
        bgColor = AppColors.lightGray;
        borderColor = AppColors.lightGray;
      }
    } else if (type == ButtonType.Outlined) {
      textColor = accentColor;
      bgColor = Colors.transparent;
      borderColor = accentColor;
    } else if (type == ButtonType.Plain) {
      textColor = accentColor;
      bgColor = Colors.transparent;
      borderColor = Colors.transparent;
    }
    return SizedBox(
      height: 45,
      width: width,
      child: _btnController != null
          ? buildRoundedLoadingButton(context, textColor, bgColor)
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: bgColor,
                elevation: type == ButtonType.Filled ? 4 : 0,
                textStyle: TextStyle(color: textColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: borderColor)),
              ),
              onPressed: onPressed,
              child: Text( text ,
                  style: TextStyle(
                      fontSize: fontSize??16,
                      color: textColor,
                      fontWeight: FontWeight.bold)),
            ),
    );
  }

  RoundedLoadingButton buildRoundedLoadingButton(
      BuildContext context, Color textColor, Color bgColor) {
    return RoundedLoadingButton(
      child: Text(text,
          style: TextStyle(
              fontSize: 16, color: textColor, fontWeight: FontWeight.bold)),
      controller: _btnController,
      color: bgColor,
      onPressed: enabled ? onPressed : null,
      resetAfterDuration: true,
      resetDuration: const Duration(seconds: 2),
    );
  }

  AppButton(
      {Color accentColor = AppColors.primary,
      ButtonType type = ButtonType.Filled,
      bool enabled = true,
      RoundedLoadingButtonController controller,
      double width,
      String text,
        double fontSize,
      Function onPressed}) {
    this.accentColor = accentColor;
    this.type = type;
    this.enabled = enabled;
    this._btnController = controller;
    this.width = width;
    this.text = text;
    this.fontSize = fontSize;

    if (enabled) {
      this.onPressed = () {
        onPressed();
      };
    } else {
      this.onPressed = () {};
    }
  }
}

enum ButtonType { Filled, Outlined, Plain }
