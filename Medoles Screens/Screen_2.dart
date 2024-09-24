import 'package:flutter/material.dart';

class Screen_b extends StatelessWidget {
  const Screen_b({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          Expanded(
            child: Image(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1514425263458-109317cc1321?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bWFya2V0fGVufDB8fDB8fHww')),
          ),
          Text('welcome 2')
        ],
      ),
    );
  }
}
