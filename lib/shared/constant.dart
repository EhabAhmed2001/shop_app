import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

const defaultColorLightMode = Colors.indigo;
const defaultColorDarkMode = Colors.grey;

String? token ;

ThemeData lightMode = ThemeData(
  primarySwatch: defaultColorLightMode,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor:defaultColorLightMode ,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 4.0,
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
  ),
  fontFamily: 'lora',
);

ThemeData darkMode = ThemeData(
  primarySwatch: defaultColorDarkMode,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: Colors.black54,
    type: BottomNavigationBarType.fixed,
    elevation: 4.0,
    selectedItemColor: Colors.white,
    backgroundColor: Colors.grey,
  ),
  scaffoldBackgroundColor: defaultColorDarkMode,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
        fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
    actionsIconTheme: IconThemeData(color: Colors.white),
    color: Colors.grey,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  fontFamily: 'lora',
);


Widget defaultFormField({
  required TextEditingController? controller,
  required String lable,
  required Function validate,
  TextInputType keyboardType = TextInputType.name,
  Function? suffixFun,
  Function? onSubmit,
  IconData? prefixIcon,
  IconData? suffixIcon,
  String? hint,
  bool isPass = false,
}) =>
    TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: () {
            suffixFun!();
          },
        ),
        label: Text(lable.toUpperCase()),
        hintText: hint?.toUpperCase(),
      ),
      keyboardType: keyboardType,
      onFieldSubmitted: (v) {
        onSubmit!(v);
      },
      controller: controller,
      validator: (value) {
        return validate(value);
      },
      obscureText: isPass,
    );

//============================================================================

Widget defaultButton({
  required String text,
  double height = 45,
  Function? onPressed,
  bool isUpperLetter = true,
  double width = double.infinity,
  double radius = 0,
  MaterialColor buttonColor = defaultColorLightMode,
}) =>
    Container(
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: () {
          onPressed!();
        },
        color: buttonColor,
        child: Text(
          isUpperLetter ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        height: height,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      decoration: BoxDecoration(
        color: defaultColorLightMode,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

//============================================================================
void toast({
  required String text,
  required toastColor state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum toastColor { SUCCESS, ERROR, WARNING }

Color chooseToastColor(toastColor state) {
  Color color;
  switch (state) {
    case toastColor.SUCCESS:
      color = Colors.green;
      break;
    case toastColor.ERROR:
      color = Colors.red;
      break;
    case toastColor.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
