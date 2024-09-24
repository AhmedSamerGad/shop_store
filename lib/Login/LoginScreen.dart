import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Networking/SharedPrefrance.dart';
import '../Register/registScreen.dart';
import '../ShopLayout/homeLayout.dart';
import '../compnant.dart';
import 'login_cubit.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    var FormKey = GlobalKey<FormState>();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    var emailControllar = TextEditingController();
    var passwordControllar = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccessStates) {
            if (state.model.status!) {
              print(state.model.message);
              ChachHelper.SetData(key: 'token', data: state.model.data!.token!)
                  .then((value) => token = ChachHelper.getData(key: 'token'));

              print(ChachHelper.getData(key: 'token'));
              Fluttertoast.showToast(
                  msg: state.model.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => homeLayout()));
            } else {
              Fluttertoast.showToast(
                  msg: state.model.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(19),
                    child: Form(
                      key: FormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Login ',
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Welcome to my shop app ',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: emailControllar,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter the email address';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                label: Text('email'),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide: BorderSide(color: Colors.blue)),
                                prefix: Icon(Icons.email),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: passwordControllar,
                            obscureText: LoginCubit.get(context).isPassword,
                            onFieldSubmitted: (value) {
                              if (FormKey.currentState!.validate()) {
                                LoginCubit.get(context).putData(
                                    email: emailControllar.text,
                                    password: passwordControllar.text);
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter the password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  borderSide: BorderSide(color: Colors.blue)),
                              label: Text('password'),
                              prefix: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  LoginCubit.get(context).ChangeIcon();
                                },
                                icon: Icon(LoginCubit.get(context).iconData),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                              condition: state is! LoginLoadingStates,
                              builder: (context) => Container(
                                    width: double.infinity,
                                    color: Colors.blue,
                                    margin: const EdgeInsets.all(20),
                                    padding: const EdgeInsets.all(5),
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (FormKey.currentState!.validate()) {
                                          LoginCubit.get(context).putData(
                                              email: emailControllar.text,
                                              password:
                                                  passwordControllar.text);
                                        }
                                      },
                                      child: const Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                              fallback: (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'You do not have account ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Registscreen()));
                                  },
                                  icon: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.blue),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
