import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cuibt/shop_cuibt_cubit.dart';
import 'cuibt/shop_cuibt_state.dart';

class homeLayout extends StatelessWidget {
  const homeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCuibtCubit(),
      child: BlocConsumer<ShopCuibtCubit, ShopCuibtState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ShopCuibtCubit.get(context);
          return Scaffold(
            appBar: AppBar(
                title: const Center(
                  child: Text('Shop App '),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 18,
                    ),
                  ),
                ]),
            body: cubit.screens[cubit.currentIndx],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndx,
              onTap: (index) {
                cubit.ChangeNavBar(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'category')
              ],
            ),
          );
        },
      ),
    );
  }
}
