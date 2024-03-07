import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const RandomColors());
}

class RandomColors extends StatefulWidget {
  const RandomColors({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RandomColorsState createState() => _RandomColorsState();
}

class _RandomColorsState extends State<RandomColors> {
  int points = 0;
  late String randomName;
  late Color randomColor;
  var colorNames = ['azul', 'verde', 'naranja', 'rosa', 'rojo', 'amarillo'];
  var colorHex = [
    const Color(0xFF0000FF),
    const Color(0xFF00FF00),
    const Color(0xFFFF914D),
    const Color(0xFFFF66C4),
    const Color(0xFFFF0000),
    const Color(0xFFFBC512)
  ];
  late Timer timer;
  double speed = 1.5;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: (1500 ~/ speed).toInt()),
        (timer) {
      getRandomColor();
      getRandomName();
      setState(() {});
    });
  }

  void getRandomColor() {
    Random random = Random();
    int randomNumber = random.nextInt(6);
    randomColor = colorHex[randomNumber];
  }

  void getRandomName() {
    Random random = Random();
    int randomNumber = random.nextInt(6);
    randomName = colorNames[randomNumber];
  }

  String hexToStringConverter(Color hexColor) {
    if (hexColor == const Color(0xFF0000FF)) {
      return 'azul';
    } else if (hexColor == const Color(0xFF00FF00)) {
      return 'verde';
    } else if (hexColor == const Color(0xFFFF914D)) {
      return 'naranja';
    } else if (hexColor == const Color(0xFFFF66C4)) {
      return 'rosa';
    } else if (hexColor == const Color(0xFFFF0000)) {
      return 'rojo';
    } else {
      return 'amarillo';
    }
  }

  void onGiftTap(String name, Color color) {
    var colorToString = hexToStringConverter(color);
    if (name == colorToString) {
      points++;
      if (points % 5 == 0) {
        speed -= 0.1;
        timer.cancel();
        startTimer();
      }
    } else {
      points--;
      if (speed < 2.0) {
        speed += 0.1;
        timer.cancel();
        startTimer();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Puntos: $points',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  onGiftTap(randomName, randomColor);
                },
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      color: randomColor,
                      height: 120,
                    ),
                    Text(
                      randomName,
                      style: TextStyle(
                          color: randomColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
