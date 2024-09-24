import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen_a extends StatelessWidget {
  const Screen_a({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(40)),
                  child: const Image(
                      image: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1664202219210-abf6ae3bdf04?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8bWFya2V0fGVufDB8fDB8fHww')))),
          const Text('welcome 1')
        ],
      ),
    );
  }
}
