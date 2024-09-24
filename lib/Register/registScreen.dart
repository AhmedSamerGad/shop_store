import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_cubit.dart';

class Registscreen extends StatelessWidget {
  Registscreen({super.key});
  var formKey = GlobalKey<FormState>();
  var nameControllar = TextEditingController();
  var emailControllar = TextEditingController();
  var passwordControllar = TextEditingController();
  var phoneControllar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Center(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Register now to connect with friends",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: nameControllar,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter the name ';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                label: Text('name'),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide: BorderSide(color: Colors.blue)),
                                prefix: Icon(Icons.person),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
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
                                prefix: Icon(Icons.person),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: passwordControllar,
                            obscureText: RegisterCubit.get(context).isPassword,
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {}
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
                                  RegisterCubit.get(context).ChangeIcon();
                                },
                                icon: Icon(RegisterCubit.get(context).iconData),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: phoneControllar,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter the phone address';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                label: Text('phone'),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide: BorderSide(color: Colors.blue)),
                                prefix: Icon(Icons.person),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                        ),
                        ConditionalBuilder(
                            condition: state is! RegisterDataLoading,
                            builder: (context) => Container(
                                  width: double.infinity,
                                  color: Colors.blue,
                                  margin: const EdgeInsets.all(20),
                                  padding: const EdgeInsets.all(5),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        RegisterCubit.get(context).postRegData(
                                            name: nameControllar.text,
                                            password: passwordControllar.text,
                                            phone: phoneControllar.text,
                                            email: emailControllar.text);
                                      }
                                    },
                                    child: const Text(
                                      'Regist',
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
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
