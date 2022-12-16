import 'package:e_commerce_flutter/core/network/local/sql_server.dart';
import 'package:e_commerce_flutter/core/routes/app_routers.dart';
import 'package:e_commerce_flutter/models/cart_model.dart';
import 'package:e_commerce_flutter/modules/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/utils/screen_config.dart';
import '../../widgets/cart/botton_pay.dart';
import '../../widgets/cart/plus_minus_buttons.dart';
import '../../widgets/cart/reusable_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  SqliteService? dbHelper = SqliteService();

  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartProvider>(
              builder: (BuildContext context, provider, widget) {
                if (provider.cart.isEmpty) {
                  return const Center(
                    child: EmptyScreen(
                      image: AppImage.errorImage,
                      text: "No Items in Cart",
                    ),
                  );
                } else {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    separatorBuilder: (context, index) => AppSize.sv_10,
                    itemCount: provider.cart.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: SizeConfig.screenWidth * 0.34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(provider.cart[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            AppSize.sh_5,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    provider.cart[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  AppSize.sv_10,
                                  Text(
                                    provider.cart[index].description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  AppSize.sv_10,
                                  Text(
                                    '\$ ${provider.cart[index].price}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.28,
                                  child: ValueListenableBuilder<int>(
                                    valueListenable:
                                        provider.cart[index].quantity!,
                                    builder: (context, val, child) {
                                      final cart =
                                          Provider.of<CartProvider>(context);
                                      return PlusMinusButtons(
                                        addQuantity: () {
                                          cart.addQuantity(
                                              provider.cart[index].id);
                                          dbHelper!
                                              .updateQuantity(
                                            CartModel(
                                              id: provider.cart[index].id,
                                              productId: index.toString(),
                                              name: provider.cart[index].name,
                                              description: provider
                                                  .cart[index].description,
                                              image: provider.cart[index].image,
                                              price: provider.cart[index].price,
                                              quantity: ValueNotifier(
                                                provider.cart[index].quantity!
                                                    .value,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {
                                              cart.addTotalPrice(double.parse(
                                                  provider.cart[index].price
                                                      .toString()));
                                            });
                                          });
                                        },
                                        deleteQuantity: () {
                                          cart.deleteQuantity(
                                              provider.cart[index].id);

                                          dbHelper!
                                              .updateQuantity(
                                            CartModel(
                                              id: provider.cart[index].id,
                                              productId: index.toString(),
                                              name: provider.cart[index].name,
                                              description: provider
                                                  .cart[index].description,
                                              image: provider.cart[index].image,
                                              price: provider.cart[index].price,
                                              quantity: ValueNotifier(
                                                provider.cart[index].quantity!
                                                    .value,
                                              ),
                                            ),
                                          )
                                              .then((value) {
                                            setState(() {
                                              cart.removeTotalPrice(
                                                  double.parse(provider
                                                      .cart[index].price
                                                      .toString()));
                                            });
                                          });
                                        },
                                        text: val.toString(),
                                      );
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    dbHelper!.deleteCartItem(
                                        provider.cart[index].id);
                                    provider
                                        .removeItem(provider.cart[index].id);
                                    provider.removeCounter();
                                  },
                                ),
                              ],
                            ),
                            //delete button
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (BuildContext context, value, Widget? child) {
              final ValueNotifier<double?> totalPrice = ValueNotifier(null);
              for (var element in value.cart) {
                totalPrice.value = (element.price * element.quantity!.value) +
                    (totalPrice.value ?? 0);
              }
              return Column(
                children: [
                  ValueListenableBuilder<double?>(
                    valueListenable: totalPrice,
                    builder: (context, val, child) {
                      return ReusableWidget(
                          title: 'Sub-Total',
                          value: (val?.toInt().toString() ?? '0'));
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
