import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model/categories_model.dart';
import 'package:shop_app/shared/styles/colors.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context, state) {

      },
      builder: (context, state) => ListView.separated(
          itemBuilder: (context, index) => buildCategoriesItem(AppCubit.get(context).categoryModel!.data.data[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: AppCubit.get(context).categoryModel!.data.data.length
      ),
    );
  }

  Widget buildCategoriesItem(ModelData model)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 120,
            width: 120,
          ),
          const SizedBox(width: 20),
          Text(model.name,style: const TextStyle(color: defaultColor,fontSize: 17),),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
