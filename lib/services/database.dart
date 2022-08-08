import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference UserCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String fullName, String phone) async{

    return await UserCollection.doc(uid).set({
      'full name': fullName,
      'phone': phone,
    });
  }
  List<String> docIDs = [];
  Future getUserId(String uid) async{
    await FirebaseFirestore.instance.collection('users').get().then(
            (snapshot) => snapshot.docs.forEach((document) {
              docIDs.add(document.reference.id);
        })
    );
  }

  Future getUserType(String uid) async{
    await FirebaseFirestore.instance.collection('users').get().then(
        (snapshot) => snapshot.docs.forEach((element) {
          print(element.reference);
        })
    );
    //DocumentSnapshot variable = await FirebaseFirestore.instance.collection('COLLECTION NAME').collection('DOCUMENT ID').get();
    //CollectionReference document = await FirebaseFirestore.instance.collection('users').collection(uid);
    //var document = await FirebaseFirestore.instance.collection('users/$uid');
    //document.get() => then(function(document) {
    //print(document("name"));
    // });
  }





}