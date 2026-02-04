import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    
    // Показываем 0.8 секунд, затем анимируем исчезновение 0.2 секунды
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _opacity = 0.0;
        });
      }
    });

    // Через 1 секунду переходим
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _opacity,
          child: FittedBox(
            child: SvgPicture.asset('assets/mark-dark.svg'),
          ),
        ),
      ),
    );
  }
}