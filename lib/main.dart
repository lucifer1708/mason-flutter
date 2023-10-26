import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: RotatingComponent(),
  ));
}

class RotatingComponent extends StatefulWidget {
  @override
  _RotatingComponentState createState() => _RotatingComponentState();
}

class _RotatingComponentState extends State<RotatingComponent> {
  double rotation = 0.0;
  double previousAngle = 0.0;
  String selectedLanguage = 'English';
  String selectedRegion = 'Upper Himachal';

  void toggleLanguage() {
    setState(() {
      selectedLanguage = (selectedLanguage == 'English') ? 'Hindi' : 'English';
    });
  }

  void toggleRegion() {
    setState(() {
      selectedRegion = (selectedRegion == 'Upper Himachal')
          ? 'Lower Himachal'
          : 'Upper Himachal';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Himachal Pradesh'),
        actions: [
          ElevatedButton(
            onPressed: toggleLanguage,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedLanguage == 'English' ? Colors.indigo : Colors.grey,
            ),
            child: Text('English'),
          ),
          ElevatedButton(
            onPressed: toggleLanguage,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedLanguage == 'Hindi' ? Colors.indigo : Colors.grey,
            ),
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

          final dx = details.localPosition.dx - centerX;
          final dy = details.localPosition.dy - centerY;

          final angle = atan2(dy, dx);

          setState(() {
            rotation += angle - previousAngle;
            previousAngle = angle;
          });
        },
        child: Center(
          child: Stack(
            children: [
              Container(
                color: Colors.grey,
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  () {
                    if (selectedLanguage == 'Hindi' &&
                        selectedRegion == 'Upper Himachal') {
                      return 'assets/background.png';
                    } else if (selectedLanguage == 'Hindi' &&
                        selectedRegion == 'Lower Himachal') {
                      return 'assets/english/lower_background.png';
                    } else if (selectedLanguage == 'English' &&
                        selectedRegion == 'Upper Himachal') {
                      return 'assets/english/upper_eglish_BG.png';
                    } else if (selectedLanguage == 'English' &&
                        selectedRegion == 'Lower Himachal') {
                      return 'assets/english/lower_english_bg.png';
                    } else {
                      return '';
                    }
                  }(),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Center(
                child: Transform.rotate(
                  angle: rotation,
                  child: Image.asset(
                    () {
                      if (selectedLanguage == 'Hindi' &&
                          selectedRegion == 'Upper Himachal') {
                        return 'assets/rotating.png';
                      } else if (selectedLanguage == 'Hindi' &&
                          selectedRegion == 'Lower Himachal') {
                        return 'assets/upper_rotate.png';
                      } else if (selectedLanguage == 'English' &&
                          selectedRegion == 'Upper Himachal') {
                        return 'assets/pics/upper_eglish_rotate.png';
                      } else if (selectedLanguage == 'English' &&
                          selectedRegion == 'Lower Himachal') {
                        return 'assets/pics/lower_english_rotate.png';
                      } else {
                        return '';
                      }
                    }(),
                    width: 290,
                    height: 290,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: double.infinity, // Set the width to full screen
          height: 60,
          child: ElevatedButton(
            onPressed: toggleRegion,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text(
              'Flip',
              style: TextStyle(
                fontSize: 24, // Set the text size here
              ),
            ),
          ),
        ),
      ),
    );
  }
}
