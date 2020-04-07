import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veli/authentication/auth.dart';
import 'package:veli/root.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationItems = Provider.of<Auth>(context);
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.only(top: 25, left: 10),
          alignment: Alignment.centerLeft,
          child: Text("User Profile",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black87)),
        ),
        SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Log Out"),
          onTap: () {
            authenticationItems.signOut();
          },
        )
      ],
    );
  }
}
