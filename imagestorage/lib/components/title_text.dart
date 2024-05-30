import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text:
              "Rakebni car provides the best services for you ", 
          style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white,
                  letterSpacing: 1.2,
                  fontWeight:FontWeight.bold,
                ),
          children:const [
            TextSpan(
              text:"Contribution By MNS",
              style:TextStyle(color: Color.fromARGB(255, 15, 160, 93)))
          ]),
    );
  }
}