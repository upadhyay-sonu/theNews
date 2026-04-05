import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 300,),


          FadeInImage(

            placeholder : AssetImage("assets/img/news-logo-vector-27684751.jpg"),
            image: AssetImage("assets/img/news-logo-vector-27684751.jpg") ,

            height: 230 , width: 230,),

          const Spacer(),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
              children: [
                TextSpan(text: "Developed and Designed by\n"),
                TextSpan(
                  text: "Sonu Upadhyay",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      )),
    );
  }
}