import 'package:flutter/material.dart';

class ModeButton extends StatelessWidget {
  final String image;
  final Function onTap;
  final String text;

  const ModeButton({Key key, this.image, @required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Colors.red,
          border: Border.all(), borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      padding: EdgeInsets.all(15.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Image.asset("assets/$image.png"),
            ),
            Expanded(
                child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
            )),
          ],
        ),
      ),
    );
  }
}
