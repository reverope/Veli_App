import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:veli/authentication/auth.dart';
import 'package:veli/drawercontent/drawer.dart';
import 'type.dart';

class Data {
  String nameofres;
  String menutype;
  String docID;
  Data({this.nameofres, this.docID, this.menutype});
}

class FindRestroScreen extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  FindRestroScreen({this.auth, this.onSignedOut});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: DrawerScreen()),
      appBar: AppBar(
        title: Text(
          'Select Restaurants',
          style: TextStyle(
              color: Colors.white, fontFamily: 'rob', letterSpacing: 2),
        ),
        primary: true,
        // actions: <Widget>[
        //   Image.network(
        //     x.photourl,width: 50,height: 50,
        //   )
        // ],
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: _buildBody(context),
    );
  }
}

Stream<QuerySnapshot> snapshot(String y) {
  final String x = y;
  return Firestore.instance.collection(x).snapshots();
}

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: snapshot('restaurants'),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      }

      return _buildList(context, snapshot.data.documents);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 10.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  var str1 = Data(
    nameofres: record.name,
    docID: data.documentID,
  );

  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FoodItemMenuType(
            str2: str1,
          ),
        ),
      );
    },
    child: Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(241, 241, 241, 1),
                  borderRadius: BorderRadius.circular(10.0),
                  // border: Border.all(color: Colors.black)
                ),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Image.network(
                      record.iconlogo,
                      width: 40,
                    ),
                  ),
                  title: Text(
                    record.name,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'rob',
                        letterSpacing: 1),
                  ),
                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                  subtitle: Row(
                    children: <Widget>[
                      Text(record.details,
                          style: TextStyle(
                              fontFamily: 'QuickSand',
                              letterSpacing: 1,
                              color: Colors.black87))
                    ],
                  ),
                  trailing: record.available
                      ? Text(
                          "Accepting orders",
                          style: TextStyle(color: Colors.green, fontSize: 8),
                        )
                      : Text(
                          "Not accepting orders",
                          style: TextStyle(color: Colors.red, fontSize: 8),
                        ),
                )))
      ],
    ),
  );
}

class Record {
  final String name;
  final String details;
  final String iconlogo;
  final bool available;
  final DocumentReference reference;

//Add variables/field
  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : name = map['name'],
        details = map['details'],
        iconlogo = map['icon'],
        available = map['available'];
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  @override
  String toString() => "Record<$name:$details:$iconlogo:$available>";
}

// Widget makeBottom = Container(
//   height: 75.0,
//   child: BottomAppBar(
//     color: Colors.white,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         IconButton(
//           icon: Icon(Icons.fastfood, color: Colors.grey),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: Icon(Icons.settings, color: Colors.grey),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: Icon(Icons.exit_to_app, color: Colors.grey),
//           onPressed: () async {
//             await googleSignIn.signOut().whenComplete(() {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return FindRestroScreen(); //DemoScreen can be user profile also
//                   },
//                 ),
//               );
//             });
//           },
//         ),
//       ],
//     ),
//   ),
// );