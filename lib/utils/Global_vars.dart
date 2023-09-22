import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/Feed.dart';
import 'package:instagram_clone/Screens/HomeScreen.dart';
import 'package:instagram_clone/Screens/SearchScreen.dart';
import 'package:instagram_clone/Screens/addPost_Screen.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
 const HomeScreen(),
 const SearchScreen(),
 const addPost(),
 const FeedPage(),
  UserProfile(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
