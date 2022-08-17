import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivational_leadership/screen/question_type_selection.dart';
import 'package:page_transition/page_transition.dart';

class LeadershipPage extends StatelessWidget{
  const LeadershipPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
      title: Text("Menu"),
      // toolbarHeight: 20,
      // backgroundColor: Colors.transparent,
      // elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    body: Container(
      color: Color(0xFFD9D9D9),
      // color: Color(0xFF6495ED),
      child: ListView(
        // Removing any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            child: Container(
              //color: Color(0xFF6495ED),
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              //height: 120,
              decoration: BoxDecoration(
                  // color: Color(0xFFF2811D),
                  color: Color(0xFF417CA9),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(25.0),
                    bottomLeft: const Radius.circular(25.0),
                    bottomRight: const Radius.circular(5.0),
                  )
              ),
              // color: Color(0xFF52adc8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,20),
                        child: Text(
                          'AUTONOMY',
                          style: TextStyle(
                            //color: Color(0xFFff6600),
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : 9/10',
                          style: TextStyle(
                            //color: Color(0xFFff6600),

                            color: Colors.white,
                            //fontWeight: FontWeight.w400,
                            fontSize: 16,
                            //letterSpacing: 2,
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),

            onTap: () {
              Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.rightToLeftJoined,
                  childCurrent: this,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                  child: QuestionTypeSelection(questionType: 'AUTONOMY')
              ));
            },
          ),        GestureDetector(
            child: Container(
              //color: Color(0xFF6495ED),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              //height: 120,
              decoration: BoxDecoration(
                  color: Color(0xFF417CA9),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(25.0),
                    bottomLeft: const Radius.circular(25.0),
                    bottomRight: const Radius.circular(5.0),
                  )
              ),
              // color: Color(0xFF52adc8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,20),
                        child: Text(
                          'BELONGING',
                          style: TextStyle(
                            //color: Color(0xFFff6600),
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : 9/10',
                          style: TextStyle(
                            //color: Color(0xFFff6600),

                            color: Colors.white,
                            //fontWeight: FontWeight.w400,
                            fontSize: 16,
                            //letterSpacing: 2,
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),

            onTap: () {
              Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.rightToLeftJoined,
                  childCurrent: this,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                  child: QuestionTypeSelection(questionType: 'BELONGING')
              ));
            },
          ),        GestureDetector(
            child: Container(
              //color: Color(0xFF6495ED),
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              //height: 120,
              decoration: BoxDecoration(
                  color: Color(0xFF417CA9),
                  // color: Color(0xFF46eb34),
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(5.0),
                    topRight: const Radius.circular(25.0),
                    bottomLeft: const Radius.circular(25.0),
                    bottomRight: const Radius.circular(5.0),
                  )
              ),
              // color: Color(0xFF52adc8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(30,20,0,20),
                        child: Text(
                          'COMPETENCE',
                          style: TextStyle(
                            //color: Color(0xFFff6600),
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,20,20),
                        child: Text(
                          'Completed : 9/10',
                          style: TextStyle(
                            //color: Color(0xFFff6600),

                            color: Colors.white,
                            //fontWeight: FontWeight.w400,
                            fontSize: 16,
                            //letterSpacing: 2,
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),

            onTap: () {
              Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.rightToLeftJoined,
                  childCurrent: this,
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                  child: QuestionTypeSelection(questionType: 'COMPETENCE')
              ));
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,40,0,0),
            child: Image.asset('assets/complete_logo.png',

              height: 80,
              width: 120,
              fit: BoxFit.contain,
            ),
          )


        ],
      ),
    )

  );

}