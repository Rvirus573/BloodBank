// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Document {
  final Stream<QuerySnapshot> info =
      FirebaseFirestore.instance.collection('info').snapshots();
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Widget DocumentID() {
    return StreamBuilder<QuerySnapshot>(
      stream: info,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Stack(children: [
              Card(
                elevation: 3,
                child: SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Image.network(
                        data['icon'],
                        height: 150,
                        width: 150,
                      ),
                      Text(
                        data['name'],
                        style: const TextStyle(fontSize: 40),
                      ),

                      
                    ],
                  ),
                ),
              ),
                     
            ]);
          }).toList(),
        );
      },
    );
  }
}
