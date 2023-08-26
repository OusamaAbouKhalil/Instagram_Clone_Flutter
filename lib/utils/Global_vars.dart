import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/HomeScreen.dart';
import 'package:instagram_clone/Screens/addPost_Screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  HomeScreen(),
  Text("Search"),
  addPost(),
  Text("Activity"),
  Text("Profile"),
];
