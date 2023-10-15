import 'package:flutter/material.dart';

class RotatingComponent extends StatefulWidget {
  @override
  _RotatingComponentState createState() => _RotatingComponentState();
}

class _RotatingComponentState extends State<RotatingComponent> {
  double rotation = 0.0;
  double previousAngle = 0.0;
  String selectedLanguage = 'English';
  String selectedRegion = 'Upper Himachal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Himachal Pradesh - $selectedRegion'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedLanguage = 'English';
              });
            },
            style: ElevatedButton.styleFrom(primary: Colors.blue),
            child: Text('English'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedLanguage = 'Hindi';
              });
            },
            style: ElevatedButton.styleFrom(primary: Colors.green),
            child: Text('Hindi'),
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;
          final centerX = width / 2;
          final centerY = height / 2;

          final dx = details.localPosition.dx;
          final dy = details.localPosition.dy;

          final angle = -((dy - centerY) / (dx - centerX));
          final newRotation = angle - previousAngle;

          setState(() {
            rotation += newRotation;
            previousAngle = angle;
          });
        },
        child: Center(
          child: Stack(
            children: [
              Container(
                // Use a Container to set background color
                color: Colors.grey,
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  selectedLanguage=='Hindi' ? 'assets/background.png' : '',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Center(
                child: Transform.rotate(
                  angle: rotation,
                  child: Image.asset(
                    selectedLanguage=='Hindi' ? 'assets/rotating.png' : '',
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedRegion = 'Upper Himachal';
                });
              },
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              child: Text('Upper Himachal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedRegion = 'Lower Himachal';
                });
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Text('Lower Himachal'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RotatingComponent(),
  ));
}

