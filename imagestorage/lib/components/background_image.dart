import 'package:flutter/widgets.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;


    return Container(
       height: size.height *0.45,
       decoration: const BoxDecoration(
        image:DecorationImage(
          image: AssetImage("images/back.jpeg"),fit: BoxFit.cover),
        ),
    );
  }
}