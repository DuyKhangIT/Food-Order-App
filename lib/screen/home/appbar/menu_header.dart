import 'package:flutter/material.dart';

import '../../../util/global.dart';
import '../../../util/share_preferences.dart';
import '../../sign_in/sign_in_page.dart';


class MenuHeader extends StatelessWidget {
  const MenuHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Colors.green
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Expanded(child: Text(
              "Account info",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )),
            GestureDetector(
              onTap: (){
                if(Global.isAvailableToClick()){
                  /// clear token
                  ConfigSharedPreferences()
                      .setStringValue(SharedData.TOKEN.toString(), "");
                  Global.token = '';
                      Navigator.pushNamedAndRemoveUntil(context, SignInPage.routeName,
                          (Route<dynamic> route) => false);
                }
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
