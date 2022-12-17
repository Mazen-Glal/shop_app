import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/search/search_screen.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder:(context,state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home',style: TextStyle(color: Colors.deepOrange),),
            actions:  [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: const Icon(Icons.search),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>SearchScreen()
                    ));
                  },
                ),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Category'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomTap(index);
            },
          ),
        );
      } ,
    );
  }
}
