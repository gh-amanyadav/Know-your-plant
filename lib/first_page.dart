import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: IconButton(
                onPressed: () {},
                tooltip: 'Menu Icon will work soon!',
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 35,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                "Location",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ]),
          Row(children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 45),
              child: Text(
                "Hey, ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)),//0xFF69F0AE
              ),
            ),
            Text(
              "Aman Kumar",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000)),//0xFF35A8EA
            ),
          ]),
          const Padding(
            padding: EdgeInsets.only(left: 45, top: 20),
            child: Text(
              "Welcome to\nKnow Your Plant",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset('assets/images/plant_image1.png'),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 45, right: 42),
              child: Text(
                "Click or Upload your image to know about it",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(
                    0xFF4A4E4D)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
