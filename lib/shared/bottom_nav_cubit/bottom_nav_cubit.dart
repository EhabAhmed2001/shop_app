import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/categories/category_screen.dart';
import 'package:shop_app/modules/favorites/favorite_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/bottom_nav_cubit/bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavInitial());

  static BottomNavCubit get(context) => BlocProvider.of(context);

  List<Widget> screens =
  [
    const home_screen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    SettingsScreen(),
  ];

  int current = 0;
  void changeBottomNavBar (index)
  {
    current = index;
    emit(ChangeBottomNav());
  }
}
