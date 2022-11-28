import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/network/local/hive.dart';
import '../../shared/constant.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  bool isPass = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
                key: formKey,
                child: BlocConsumer<ShopAppCubit, ShopAppStates>(
                  listener: (context, state) {
                    if (state is RegisterSuccessStates) {
                      if (state.mode.status) {
                        print('message => ${state.mode.message}');
                        print('token =>${state.mode.data!.token}');

                        toast(
                          text: state.mode.message!,
                          state: toastColor.SUCCESS,
                        );
                        CacheHelper.putHiveData(
                            key: 'token', value: state.mode.data!.token);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LayoutScreen()),
                          (route) => false,
                        );
                      } else {
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
                          'Register',
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
                          'CREAT ACCOUNT IN OUR SHOP',
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
                          lable: 'name',
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Name mustn\'t be empty';
                            }
                            return null;
                          },
                          controller: nameController,
                          hint: 'Enter your name',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                        ),
                        //===================
                        const SizedBox(
                          height: 20,
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
                              if (value!.isEmpty) {
                                return 'password is short';
                              }
                              return null;
                            },
                            controller: passController,
                            prefixIcon: Icons.lock,
                            keyboardType: TextInputType.emailAddress,
                            isPass: isPass,
                            suffixIcon: isPass
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                            suffixFun: () {
                              setState(() {
                                isPass = !isPass;
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),

                        defaultFormField(
                          lable: 'phone',
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone mustn\'t be empty';
                            }
                            return null;
                          },
                          controller: phoneController,
                          hint: 'Enter your Phone',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        //===================
                        const SizedBox(
                          height: 24,
                        ),
                        //=====================
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingStates,
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          builder: (BuildContext context) {
                            return defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopAppCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    pass: passController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              radius: 20,
                              text: 'Create Account',
                            );
                          },
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
