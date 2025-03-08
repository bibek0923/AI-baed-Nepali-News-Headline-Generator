import 'package:flutter/material.dart';
import 'package:headline_generator/headlinegenerator.dart';

class FirstSCreen extends StatelessWidget {
  const FirstSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                // Added Expanded to fill available height
                child: Container(
                  width: double.infinity, // Makes container take full width
                  height: double.infinity, // Makes container take full height
                  child: Image.asset(
                    "assets/images/one.jpeg",
                    fit: BoxFit.cover,
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.55),
                    colorBlendMode: BlendMode.colorBurn,
                  ),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return HeadlineGenerator();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Circular border
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 4, 2)),
                ),
              ))
        ],
      ),
    );
  }
}
