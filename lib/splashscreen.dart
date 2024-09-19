import 'dart:async';


import 'package:flutter/material.dart';
import 'package:virus_app/main.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Homepage ())

      );
    }
    );
    return Scaffold(
     body: Center(
         child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjVjNgQrncb-GI25gD4e3Wlqs4MUurE-Cofw&s')
     ),

     );


  }
}
