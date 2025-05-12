import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  List<Map<String, dynamic>> lstUsers = [];
  final db = FirebaseFirestore.instance;

  void fetchUserData() async {
    final docRef = db.collection("users").doc("1OgahxpoXoxc93IGYypC");
    // final docRef = db.collection("cities").doc("SF");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        // ...
        print("data ${data}");
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  void getMultiDoc() async {
    db.collection("users").get().then(
      // db.collection("cities").where("capital", isEqualTo: true).get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          lstUsers.add(docSnapshot.data());
        }
        setState(() {});
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  void initState() {
    // fetchUserData();
    getMultiDoc();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User View'),
      ),
      body: ListView.builder(
        itemCount: lstUsers.length,
        itemBuilder: (context, index) {
          final user = lstUsers[index];
          return Card(
            child: ListTile(
              title: Text('${user['name']}'),
              subtitle: Text("Age: ${user['age']}"),
            ),
          );
        },
      ),
    );
  }
}
