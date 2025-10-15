import 'package:flutter/material.dart';
import 'package:news_api_app_bloc/screens/home/widgets/button.dart';
import 'package:news_api_app_bloc/screens/newsScreen/UI/news_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "World News",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: "Load News",
              color: Colors.red,
              width: 200,
              height: 50,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NewsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
