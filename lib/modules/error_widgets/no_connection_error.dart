import 'package:flutter/material.dart';

import 'reusable_widget.dart';

class NoConnection extends StatelessWidget {
  final Function() onRetry;

  const NoConnection({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/Connection_Lost.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            bottom: 200,
            left: 30,
            child: Text(
              'No Connection',
              style: kTitleTextStyle,
            ),
          ),
          const Positioned(
            bottom: 150,
            left: 30,
            child: Text(
              'Please check your internet connection\nand try again.',
              style: kSubtitleTextStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: ReusablePrimaryButton(
              childText: 'Retry',
              buttonColor: Colors.blue[800]!,
              childTextColor: Colors.white,
              onPressed: () => onRetry(),
            ),
          ),
        ],
      ),
    );
  }
}

const kTitleTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25,
  letterSpacing: 1,
  fontWeight: FontWeight.w500,
);

const kSubtitleTextStyle = TextStyle(
  color: Colors.black38,
  fontSize: 16,
  letterSpacing: 1,
  fontWeight: FontWeight.w500,
);
