import 'package:first_01/pages/home_Page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

return MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HomePage()
);
}
}