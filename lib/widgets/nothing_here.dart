import 'package:flutter/material.dart';

class NothingHere extends StatelessWidget {
  const NothingHere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height / 3,
          width: size.width / 0.5,
          child: Image.asset('assets/images/wentWrong.png'),
        ),
        Text(
          "Nothing to see here",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "Move Along",
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
