import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Login/LoginScreen.dart';
import '../Networking/Dio.dart';
import 'Networking/SharedPrefrance.dart';
import 'ShopLayout/cuibt/shop_cuibt_cubit.dart';
import 'ShopLayout/homeLayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  networkdata.init();
  await ChachHelper.init();
  Widget widget;
  if (Login.tokenS == null) {
    widget = const Login();
  } else {
    widget = const homeLayout();
  }
  runApp(MyApp(starwidget: widget));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.starwidget});

  final Widget starwidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCuibtCubit(),
      // ..getData()
      // ..getPosts(),
      child: MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(bodySmall: TextStyle(color: Colors.grey[700])),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedIconTheme: IconThemeData(color: Colors.blue),
            ),
            primaryColor: Colors.blue,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white38,
                toolbarHeight: 40,
                titleTextStyle: TextStyle(
                  color: Colors.amber,
                  fontSize: 15,
                ))),
        debugShowCheckedModeBanner: false,
        home: starwidget,
      ),
    );
  }
}
