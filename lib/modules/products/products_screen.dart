import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';
class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context , state)
      {
      },
      builder: (context,state)
      {
        return ConditionalBuilder(
          condition: AppCubit.get(context).model != null && AppCubit.get(context).categoryModel != null ,
          builder: (context) {
            return  productsBuilder(AppCubit.get(context).model,AppCubit.get(context).categoryModel,context);
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      }
    );
  }

  Widget productsBuilder(HomeModel? model , CategoryModel? categoryModel,context)=> SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model?.data.banners.map((e) => Image(
              image: NetworkImage(e.image),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal
            )
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: defaultColor,
                    radius: 10,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'Categories',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: defaultColor
                      )
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildCategoryItem(AppCubit.get(context).categoryModel!.data.data[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 1,);
                    },
                    itemCount:categoryModel!.data.data.length,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: defaultColor,
                    radius: 10,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: defaultColor
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1/1.18,
          children: List.generate(model!.data.products.length, (index) => buildProductItem(model.data.products[index],context)),
        )
      ],
    ),
  );

  Widget buildCategoryItem(ModelData model)
  {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 120,
          width: 120,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.6),
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white
            ),
          ),
        )
      ],
    );
  }

  Widget buildProductItem(ProductModel model,context)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children : [
              Image(
                image: NetworkImage(model.image),
                height: 150.0,
              ),
              if(model.discount != 0)
                Container(
                padding : const EdgeInsets.all(1.0),
                color: Colors.red,
                child: const Text(
                  'Discount',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]
          ),
          const SizedBox(height: 5),
          Text(
            model.name,
            maxLines: 2,
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
              if(model.discount != 0)
                Text(
                  '${model.oldPrice}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough
                  ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeFavoritesState(model.id);
                  },
                  icon:AppCubit.get(context).favorites[model.id]! ? const Icon(Icons.favorite,color: defaultColor,) : const Icon(Icons.favorite_border)
              )
            ],
          )
        ],
      ),
    );
  }
}
