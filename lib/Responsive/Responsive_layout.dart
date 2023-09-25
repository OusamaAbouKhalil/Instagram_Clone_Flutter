import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/Global_vars.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key, required this.mobileScreenLayout, required this.WebScreenLayout}) : super(key: key);
  final Widget mobileScreenLayout;
  final Widget WebScreenLayout;
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if(constrains.maxWidth >=  webScreenSize){
          return WebScreenLayout; 
        }else{
          return mobileScreenLayout; 
        }
      },


    );

  }

}