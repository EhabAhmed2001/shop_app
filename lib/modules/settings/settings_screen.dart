import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/local/hive.dart';
import '../../shared/cubit/cubit.dart';
import '../login/login_screen.dart';
import 'settings_const.dart';

class SettingsScreen extends StatelessWidget {

  double sizeBoxHeight = 20;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopAppUpdateProfileSuccessStates) {
          toast(text: state.msg, state: toastColor.SUCCESS);
        }
      },
      builder: (context, state) {
        var cu = ShopAppCubit.get(context).userModel.data!;
        nameController.text = cu.name!;
        emailController.text = cu.email!;
        phoneController.text = cu.phone!;

        return Form(
          key: formKey,
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      defaultFormField(
                        lable: 'name',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name mustn\'t be empty';
                          }
                          return null;
                        },
                        controller: nameController,
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(
                        height: sizeBoxHeight,
                      ),
                      defaultFormField(
                        lable: 'email',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Email mustn\'t be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(
                        height: sizeBoxHeight,
                      ),
                      defaultFormField(
                        lable: 'phone',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone mustn\'t be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        prefixIcon: Icons.phone,
                      ),
                      SizedBox(
                        height: 2 * sizeBoxHeight,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: defaultButton(
                              text: 'update',
                              radius: 30,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopAppCubit.get(context).updateProfile(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: defaultButton(
                              text: 'logout',
                              radius: 30,
                              buttonColor: Colors.grey,
                              onPressed: () {
                                BottomNavCubit.get(context).current = 0;
                                CacheHelper.deleteHiveData(key: 'token');
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
