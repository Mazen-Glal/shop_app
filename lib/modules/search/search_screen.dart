import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/models/search_model/search_model.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){

        },
        builder:(context,state)=> Scaffold(

          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value){
                      SearchCubit.get(context).search(token: token, text: value);
                    },
                    onChanged: (value){
                    },
                    validator: (value) => 'search must not be empty..',
                    decoration: const InputDecoration(
                      hintText: 'search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 10),
                  if(state is LoadingSearchStates)
                    const LinearProgressIndicator(),
                  if(state is SuccessSearchStates)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index)=> buildSearchItems(SearchCubit.get(context).searchModel!.data!.data![index],AppCubit.get(context).model!.data.products[index],context),
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                        itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildSearchItems(Product model,ProductModel homeModel,context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      child: Row(
        children: [
          Stack(
              alignment: Alignment.bottomLeft,
              children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 150.0,
              width: 150.0,
            ),
            if (homeModel.discount != 0)
              Container(
                padding: const EdgeInsets.all(1.0),
                color: Colors.red,
                child: const Text(
                  'Discount',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: const TextStyle(color: defaultColor),
                    ),
                    const SizedBox(width: 10),
                    if (homeModel.discount != 0)
                      Text(
                        '${homeModel.oldPrice}',
                        style: const TextStyle(decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeFavoritesState(model.id);
                        },
                        icon: AppCubit.get(context).favorites[model.id]! ? const Icon(Icons.favorite, color: defaultColor,) : const Icon(Icons.favorite_border))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
