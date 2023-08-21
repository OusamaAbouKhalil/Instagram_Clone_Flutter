import 'package:flutter/material.dart';
import 'package:instagram/utilities/Dimantions.dart';

class Responsive_Layout extends StatelessWidget {
  const Responsive_Layout({Key? key, required this.mobileScreenLayout, required this.WebScreenLayout}) : super(key: key);
  final Widget mobileScreenLayout;
  final Widget WebScreenLayout;
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if(constrains.maxWidth >=  webScreeSize){
          return WebScreenLayout; 
        }else{
          return mobileScreenLayout; 
        }
      },


    );

  }

}