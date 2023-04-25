import 'package:e_commerce_flutter/modules/widgets/build_flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../controllers/cart_provider.dart';
import '../../../controllers/layout_cubit/layout_cubit.dart';
import '../../../core/network/local/sql_server.dart';
import '../../../core/routes/app_routers.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/screen_config.dart';
import '../../../core/widget/show_snack_bar.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';

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
          height: SizeConfig.screenHeight * 0.4,
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.02),
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            separatorBuilder: (context, index) => AppSize.sh_15,
            itemBuilder: (context, index) {
              final cart = Provider.of<CartProvider>(context, listen: false);
              var item = productList[index];
              return Container(
                width: SizeConfig.screenWidth * 0.39,
                height: SizeConfig.screenHeight * 0.4,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(5, 6), // changes position of shadow
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 2.0,
                  ),
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
                                showFlutterToast(
                                  message: 'Added to Cart',
                                  toastColor: Colors.green,
                                );
                              } else {
                                showFlutterToast(
                                  message: 'Product already in cart',
                                  toastColor: Colors.red,
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
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
                                  height: SizeConfig.screenHeight * 0.16,
                                  decoration: BoxDecoration(
                                    //color: Colors.amber,
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
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
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
