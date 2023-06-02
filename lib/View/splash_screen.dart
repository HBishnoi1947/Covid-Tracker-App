import 'dart:async';
import 'dart:math';

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5),()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldStatesScreen())));
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
              animation: _controller, 
              child: Container(
                height: 200,
                width: 200,
                child: const Center(
                  child: Image(image: AssetImage("images/virus.png")),
                ),
              ),
              builder: (BuildContext context, Widget? child){
                // print("harsh : ${_controller.value * 2.0 * pi}");
                return Transform.rotate(
                  angle: _controller.value * 2.0 * pi, 
                  child: child 
                  );
              }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            Align(alignment: Alignment.center,child: const Text('Covid 19\nTracker App',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }
}
