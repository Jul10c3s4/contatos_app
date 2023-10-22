import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:contatos_app/pages/contact_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nextPage();
  }

  void nextPage() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const ContactPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/icon.png", width: 200, height: 200),
            AnimatedTextKit(
              pause: const Duration(milliseconds: 1500),
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  'Caregando contatos',
                  textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
