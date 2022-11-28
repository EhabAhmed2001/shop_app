import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/network/local/hive.dart';
import '../../shared/constant.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passController = TextEditingController();

  bool isPass = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
                key: formKey,
                child: BlocConsumer<ShopAppCubit, ShopAppStates>(
                  listener: (context, state) {
                    if(state is ShopAppSuccessStates)
                      {
                        if(state.mode.status)
                          {
                            print('message => ${state.mode.message}');
                            print('token =>${state.mode.data!.token}');

                            toast(
                              text: state.mode.message!,
                              state: toastColor.SUCCESS,
                            );
                            CacheHelper.putHiveData(key: 'token', value: state.mode.data!.token);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder:(context)=> const LayoutScreen()),
                                  (route) => false,
                            );
                          }
                        else
                            {
                              print('message => ${state.mode.message}');
                              toast(
                                text: state.mode.message!,
                                state: toastColor.ERROR,
                              );
                            }


                      }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'LOGIN TO OUR SHOP',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          lable: 'E-mail',
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email mustn\'t be empty';
                            }
                            return null;
                          },
                          controller: emailController,
                          hint: 'Enter your account',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        //===================
                        const SizedBox(
                          height: 20,
                        ),
                        //===================
                        defaultFormField(
                            lable: 'Password',
                            validate: (String? value) {
                              if (value!.isEmpty ) {
                                return 'password is short';
                              }
                              return null;
                            },

                            controller: passController,
                            prefixIcon: Icons.lock,
                            keyboardType: TextInputType.emailAddress,
                            isPass: isPass,
                            onSubmit: (v) {
                              if (formKey.currentState!.validate()) {
                                ShopAppCubit.get(context).userLogin(
                                    email: emailController.text,
                                    pass: passController.text,
                                       );
                                      }
                                    },
                            suffixIcon: isPass ? Icons.remove_red_eye : Icons.visibility_off,
                            suffixFun: () {
                              setState(() {
                                isPass = !isPass;
                              });
                            }),
                        //================
                        const SizedBox(
                          height: 24,
                        ),
                        //=====================
                        ConditionalBuilder(
                          condition: state is! ShopAppLoadingStates,
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          builder: (BuildContext context) {
                            return defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopAppCubit.get(context).userLogin(
                                    email: emailController.text,
                                    pass: passController.text,
                                  );
                                }
                              },
                              radius: 20,
                              text: 'login',
                            );
                          },
                        ),

                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account ?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>const RegisterScreen()
                                    ),
                                );
                              },
                              child: const Text('Register now'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}
