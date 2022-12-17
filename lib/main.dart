import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/login/login_cubit/bloc_odserve.dart';
import 'modules/on_boarding/on_boarding.dart';
void main()async {

  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initialObject();
  await CacheHelper.initialCacheObject();
  Bloc.observer = MyBlocObserver();

  Widget widget;
  bool? onBoardingShow = CacheHelper.getData('onBoarding');
  token = CacheHelper.getData('token');
  if(onBoardingShow != null )
  {
    if(token != null )
    {
      widget = const ShopLayout();
    }
    else
    {
      widget = ShopLoginScreen();
    }
  }
  else
  {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return  BlocProvider(
      create: (context) => AppCubit()..getHomeData(token)..getCategoryData(token)..getFavoritesData(token)..getProfile(token),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        themeMode: ThemeMode.light,
        home: widget
      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


