import 'package:flutter/material.dart';

class CircleDot extends StatefulWidget {
  final bool isSelected;
  final Color color;
  final Function onTap;

  const CircleDot({Key key, this.color, this.isSelected = false, this.onTap})
      : super(key: key);
  @override
  _CircleDotState createState() => _CircleDotState();
}

class _CircleDotState extends State<CircleDot> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: widget.isSelected ? Colors.black : Colors.transparent,
            width: 3,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
