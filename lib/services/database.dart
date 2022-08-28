import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motivational_leadership/utility/base_util.dart';

class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference UserCollection = FirebaseFirestore.instance.collection('users');


  Future updateUserData(String fullName, String phone, String type) async{

    return await UserCollection.doc(uid).set({
      'full name': fullName,
      'phone': phone,
    });
  }

  static Future<String> getUserName(String uid) async {
    final docRef = await FirebaseFirestore.instance.collection('users').doc(uid);
    DocumentSnapshot doc = await docRef.get();
    if(doc.exists){
      String name = await doc.get("full name");
      print('MYTAG getUserName NAME = $name');
      return name;
    }else{
      return "";
    }
  }

  static Future<String> getUserType(String uid) async {
    final docRef = await FirebaseFirestore.instance.collection('users').doc(uid);
    DocumentSnapshot doc = await docRef.get();
    if(doc.exists){
      String type = await doc.get("type");
      print('MYTAG getUserName NAME = $type');
      return type;
    }else{
      return "student";
    }
  }

  static Future<String> getUserId(String fullName) async {
    // final docRef = await FirebaseFirestore.instance.collection('users').doc(uid);
    // DocumentSnapshot doc = await docRef.get();
    // if(doc.exists){
    //   String name = await doc.get("full name");
    //   print('MYTAG getUserName NAME = $name');
    //   return name;
    // }else{
    //   // return "";
    // }


    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance.collection('users')
        .where('full name', isEqualTo: fullName)
        .get();
    // final qDocuments = qSnapshot.docs;
    String userId = qSnapshot.docs.first.id;
    return userId;
  }

  Future<String> getTotalQuestion(String _questionType, String _questionSubType,) async {
    final QuerySnapshot qSnapshot = await FirebaseFirestore.instance.collection('questions')
        .where('type', isEqualTo: _questionType)
        .where('sub type', isEqualTo: _questionSubType)
        .get();
    final int qDocuments = qSnapshot.docs.length;
    return qDocuments.toString();
  }

  static Future<String> hasThisDocument(String collectionName, String id) async {
    final docRef = await FirebaseFirestore.instance.collection("$collectionName").doc('$id');
    DocumentSnapshot doc = await docRef.get();
    if(doc.exists){
      return "true";
    }else{
      return "false";
    }
  }

  static Future<void> updateSubmissions(String type, String value) async {
    CollectionReference submissions = FirebaseFirestore.instance.collection('submissions');
    String _uid = FirebaseAuth.instance.currentUser!.uid;
    try{
      submissions.doc(_uid).update({'$type': value});
    } on FirebaseAuthException catch (e) {
      print("mytag " + e.toString());
      Utils.showSnackBar("Failed to update submissions: $e.message");
    }
  }

  static Future<void> addSubmissions(String plan, String reflect) async{
    final CollectionReference SubmissionsCollection = FirebaseFirestore.instance.collection('submissions');
    String _uid = FirebaseAuth.instance.currentUser!.uid;

    try{
      await SubmissionsCollection.doc(_uid).set({
        'plan': plan,
        'reflect': reflect,
      });
    } on FirebaseAuthException catch (e) {
      print("mytag " + e.toString());
      Utils.showSnackBar("Failed to add submissions: $e.message");
    }
  }
  static Future getUserList() async
  {
    List itemsList = [];
    final CollectionReference submissions = FirebaseFirestore.instance.collection('submissions');
    try{
      await submissions.get().then((querySnapshot){
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.id);
          // itemsList.add(element.data());
          print("MYTAG getUserList: " + element.id);
        });
      });
      print(itemsList);
      return itemsList;
    }catch(e){
      print(e.toString());
    }
  }
}