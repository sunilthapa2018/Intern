import 'package:flutter/material.dart';

class CustomLeaderShipTile extends StatelessWidget {
  final String title;
  final String description;
  final Function() onTap;

  const CustomLeaderShipTile({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
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
            )),
        // color: Color(0xFF52adc8),
        child: Column(
          children: [
            _buildTitleText(),
            _buildCompletedText(),
          ],
        ),
      ),
    );
  }

  Align _buildCompletedText() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
        child: Text(
          description,
          style: TextStyle(
            //color: Color(0xFFff6600),

            color: Colors.white,
            //fontWeight: FontWeight.w400,
            fontSize: 16,
            //letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Align _buildTitleText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
        child: Text(
          title,
          style: TextStyle(
            //color: Color(0xFFff6600),
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 24,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
