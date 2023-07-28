import 'package:flutter/material.dart';

import '../../widgets/add.paypal.dart';

class ErrorView extends StatelessWidget {
  //ROUTER
  static const String routeName = '/error';
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPaint(
                      size: Size(200, (200 * 1).toDouble()),
                      painter: AddPaypalWidget(),
                    ),
                    const Text(
                      'Something went wrong!   ',
                      style: TextStyle(
                        color: Color(0xA537474F),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
              child: const Text(
                'Go Home',
                style: TextStyle(
                  color: Color(0xFF3366CC),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
