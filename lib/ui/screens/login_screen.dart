import 'dart:math';

import 'package:aman/bloc/auth/data/auth_bloc.dart';
import 'package:aman/bloc/auth/model/AuthResponse.dart';
import 'package:aman/ui/screens/main_screen.dart';
import 'package:aman/utils/Utils.dart';
import 'package:aman/utils/app_button.dart';
import 'package:aman/utils/global.dart';
import 'package:aman/utils/preference_utils.dart';
import 'package:aman/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginForm extends StatefulWidget {


  @override
  _LoginFrom createState() {
    return _LoginFrom();
  }
}

class _LoginFrom extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthBloc authBloc = AuthBloc();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _actionBtnController =
  RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 0.0),
                  child: Center(
                      child: Image(
                    image: AssetImage('assets/images/ic_aman.jpeg'),
                    width: 200.0,
                    height: 100.0,
                    fit: BoxFit.scaleDown,
                  )),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 64),
                  child: TextFormField(
                    controller: _usernameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primary)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primary)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primary)),
                        hintText: 'Username',
                        hintStyle: TextStyle(color: AppColors.primary),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0)),
                    style: const TextStyle(color: AppColors.primary, fontSize: 14),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Username';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 64),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primary)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primary)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.primary)),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: AppColors.primary),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 0.0)),
                    style: const TextStyle(color: AppColors.primary, fontSize: 14),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 64.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40.0,
                    child:  AppButton(
                      controller: _actionBtnController,
                      text: "Login",
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          login(_usernameController.text, _passwordController.text);
                        }else{
                          _actionBtnController.stop();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  RoundedLoadingButton buildRoundedLoadingButton(
      BuildContext context, Color textColor, Color bgColor,Function onPressed,{bool enabled = true}) {
    return RoundedLoadingButton(
      child: Text("",
          style: TextStyle(
              fontSize: 16, color: textColor, fontWeight: FontWeight.bold)),
      controller: _actionBtnController,
      color: bgColor,
      onPressed: enabled ? onPressed() : null,
      resetAfterDuration: true,
      resetDuration: const Duration(seconds: 2),
    );
  }

  void login (String username, String pass)async{
    var result = await authBloc.login(username, pass);
    if(result.getSuccessData() != null){
      PreferenceUtils.setString("apiKey", result.getSuccessData().tokenType+" "+result.getSuccessData().accessToken);
      PreferenceUtils.setBoolean("isManager", result.getSuccessData().ismanager);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainScreen()
        ),
      );
    }else if(result.getErrorMessage()!= null){
      showSnackbar(context, result.getErrorMessage());
    }
  }
}
