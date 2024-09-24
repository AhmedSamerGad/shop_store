import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screen_2.dart';
import 'screen_1.dart';

class Home extends StatelessWidget {
  @override
  Home({super.key});
  final Controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              height: 100,
              child: PageView(
                controller: Controller,
                scrollDirection: axisDirectionToAxis(AxisDirection.left),
                children: const [
                  Screen_a(),
                  Screen_b(),
                ],
              ),
            )),
            const Text('welcome from home')
          ],
        ),
      ),
    );
  }
}
