import 'package:e_commerce_flutter/controllers/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_flutter/core/utils/app_size.dart';
import 'package:e_commerce_flutter/core/widget/circular_progress_component.dart';
import 'package:e_commerce_flutter/models/cart_model.dart';

import 'package:e_commerce_flutter/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../controllers/cart_provider.dart';
import '../../../core/network/local/sql_server.dart';
import '../../../core/routes/app_routers.dart';
import '../../../core/utils/screen_config.dart';
import '../../../core/widget/show_snack_bar.dart';

class CategoriesComponent extends StatelessWidget {
  final List<ProductModel> productList;
  const CategoriesComponent({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    SqliteService dioHelper = SqliteService();
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.35,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.02,
              vertical: SizeConfig.screenHeight * 0.02,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            separatorBuilder: (context, index) => AppSize.sh_15,
            itemBuilder: (context, index) {
              final cart = Provider.of<CartProvider>(context, listen: false);
              var item = productList[index];
              return Container(
                width: SizeConfig.screenWidth * 0.50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(5, 6), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () =>
                              LayoutCubit.get(context).insertToFavorites(item),
                          icon: LayoutCubit.get(context)
                                  .isFavoriteFromDatabase(item.id)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                ),
                        ),
                        IconButton(
                          onPressed: () {
                            dioHelper
                                .insert(
                              CartModel(
                                id: item.id,
                                productId: index.toString(),
                                name: item.name,
                                description: item.description,
                                image: item.imageUrl,
                                price: item.price,
                                quantity: ValueNotifier(1),
                              ),
                            )
                                .then((value) {
                              if (value == 1) {
                                cart.addTotalPrice(item.price);
                                cart.addCounter();
                                showSnackBar(
                                  context: context,
                                  message: 'Added to Cart',
                                  color: Colors.green,
                                );
                              } else {
                                showSnackBar(
                                  context: context,
                                  message: 'Product already in cart',
                                  color: Colors.red,
                                );
                              }
                            }).onError((error, stackTrace) {
                              showSnackBar(
                                context: context,
                                message: error.toString(),
                                color: Colors.red,
                              );
                              print(error.toString());
                            });
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                              Routers.PRODUCT_DETAILS,
                              arguments: item,
                            ),
                            child: Hero(
                              tag: 'product_image_${item.id}',
                              child: Container(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight * 0.17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(item.imageUrl),
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.low,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AppSize.sv_10,
                          Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppSize.sv_5,
                          Text(
                            '\$ ${item.price}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
