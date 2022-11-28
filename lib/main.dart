import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/shared/network/local/hive.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'modules/login/login_screen.dart';
import 'modules/onboarding/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // to do line by line
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox('hive');
  CacheHelper.box.get('onBoarding');
  CacheHelper.box.get('token');
  if (CacheHelper.getHiveData(key:'onBoarding') == null)
    {
      await CacheHelper.putHiveData(key: 'onBoarding', value: false);
    }

  bool onBoarding = CacheHelper.getHiveData(key:'onBoarding');
  token = CacheHelper.getHiveData(key:'token');
  late Widget widget ;
  
  if (onBoarding) {
    if (token != null)
    {
      widget = const LayoutScreen();
    } else
    {
      widget = LoginScreen();
    }

  }else {
    widget = OnBoardingScreen();
  }

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp(startWidget:widget));
}

class MyApp extends StatelessWidget {

  late Widget startWidget ;

  MyApp({
    required this.startWidget,
});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => ShopAppCubit()..getHomeData()..getCategoryData()..getFavoriteData()..getUserData()),
          BlocProvider(
              create: (BuildContext context) => BottomNavCubit()),
        ],
        child: BlocConsumer<ShopAppCubit, ShopAppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            ShopAppCubit cu = ShopAppCubit.get(context);
            return MaterialApp(
              theme: lightMode,
              debugShowCheckedModeBanner: false,
              home:  startWidget,
            );
          },
        ));
  }
}
