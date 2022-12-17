import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/get_favorites_model/get_favorites_model.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index)=> buildFavoritesItems(AppCubit.get(context).favoritesDataModel!.data!.data![index],context),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: AppCubit.get(context).favoritesDataModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildFavoritesItems(FavoritesData model,context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      child: Row(
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            Image(
              image: NetworkImage('${model.product!.image}'),
              height: 150.0,
              width: 150.0,
            ),
            if (model.product!.discount != 0)
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
                  '${model.product!.name}',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product!.price}',
                      style: const TextStyle(color: defaultColor),
                    ),
                    const SizedBox(width: 10),
                    if (model.product!.discount != 0)
                      Text(
                        '${model.product!.oldPrice}',
                        style: const TextStyle(decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeFavoritesState(model.product!.id);
                        },
                        icon: AppCubit.get(context).favorites[model.product!.id]! ? const Icon(Icons.favorite, color: defaultColor,) : const Icon(Icons.favorite_border))
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
