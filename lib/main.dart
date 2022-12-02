import 'package:flutter/material.dart';

import 'home_view/view/home_view.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: "Posts",
     home: HomeView(),
   );
  }

}
