import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo/first_xo_screen.dart';
import 'package:win_money_game/shared/component/component.dart';

class XoSelectBetScreen extends StatelessWidget {
  XoSelectBetScreen({Key? key}) : super(key: key);

  final List <String> xoImage = [

    'assets/images/50_coins.png',
    'assets/images/100_coins.png',
    'assets/images/500_coins.png',
    'assets/images/1k_coins.png',
    'assets/images/2.5k_coins.png',
    'assets/images/5k_coins.png',
    'assets/images/10k_coins.png',
    'assets/images/25k_coins.png',
    'assets/images/50k_coins.png',
    'assets/images/100k_coins.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(height: 400.0),
            items: xoImage.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                          color: Colors.amberAccent
                      ),
                      child: InkWell(
                        child: Image.asset(i,fit: BoxFit.cover,),
                        onTap: (){
                          navigateTo(context, FirstXOScreen());
                        },
                      ),
                  );
                },
              );
            }).toList(),
          )
        ],
       ),
    );
  }
}