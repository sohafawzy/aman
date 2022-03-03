import 'package:aman/ui/screens/branches_screen.dart';
import 'package:aman/ui/screens/login_screen.dart';
import 'package:aman/ui/screens/qr_code_screen.dart';
import 'package:aman/utils/preference_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_button.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  bool isManager = PreferenceUtils.getBoolean("isManager");
  _MainScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0, left: 48.0,right: 48.0,bottom: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: AppButton(
                        text: "Scan QR code",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QrCodeScreen()
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  isManager? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 48.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: AppButton(
                        text: "View Branches",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BranchesScreen()
                            ),
                          );
                        },
                      ),
                    ),
                  ):Row(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 48.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: AppButton(
                        text: "Logout",
                        onPressed: () {
                          PreferenceUtils.remove("apiKey");
                          PreferenceUtils.remove("isManager");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginForm()
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
