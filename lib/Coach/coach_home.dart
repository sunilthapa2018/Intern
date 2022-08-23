import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/Coach/coach_navigation_drawer.dart';
import 'package:motivational_leadership/Coach/feedback_selection.dart';
import 'package:motivational_leadership/services/database.dart';
import 'package:page_transition/page_transition.dart';

import '../Widget/navigation_drawer.dart';

String uid = FirebaseAuth.instance.currentUser!.uid;
class CoachHome extends StatefulWidget {
  const CoachHome({Key? key}) : super(key: key);

  @override
  State<CoachHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<CoachHome> {
  Color backgroundColor =  Color(0xFFD9D9D9);
  Color itemColor =  Color(0xFF417CA9);
  Color appBarColor = Color(0xFFF2811D);
  List userSubmissionList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: const CoachNavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Students"),
        backgroundColor: appBarColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: ListView.builder(
            itemCount: userSubmissionList.length,
            itemBuilder: (context, index) {
              Future name;
              return Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Card(
                  child: GestureDetector(
                    child: ListTile(
                      // title: Text(getName(index).toString()),
                      title: FutureBuilder(
                        future: name = getName(index),
                        builder: (context, snapshot) {
                          return Text(snapshot.data.toString());
                        },
                      ),
                      onTap: (){
                        print("ListTile");
                      }

                    ),
                    // onTap: (){
                    //   print("ListTile");
                    //   //String name = getUserName();
                    //   // Navigator.of(context).push(PageTransition(
                    //   //     type: PageTransitionType.rightToLeftJoined,
                    //   //     childCurrent: widget,
                    //   //     child: FeedbackSelection(userID: '',)
                    //   // ));
                    //
                    // },
                  ),


                ),
              );
            },
          ),
        ),
      )
    );
  }
  @override
  void initState() {
    super.initState();
    fetDatabaseList();
    print(userSubmissionList);
  }

  Future<void> fetDatabaseList() async {
    dynamic resultant = await DatabaseService.getUserList();
    if(resultant == null){
      print("MYTAG: unable to retreive");
    }else{
      setState((){
        userSubmissionList = resultant;
      });
    }
  }

  Future<void> _refresh() async {
    await Future.wait([
      fetDatabaseList(),
    ]);
    this.setState((){});
  }

  Future getName(int index) async {
    String uID = await userSubmissionList[index].toString().trim();
    print("MYTAG : getName : uID = $uID");
    dynamic userName = await DatabaseService.getUserName(uID);
    print("MYTAG : getName : userName = $userName");
    return userName;
  }



}


