
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/layout_cubit/layout_cubit.dart';
import '../../core/style/icon_broken.dart';
import '../../core/utils/app_size.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/screen_config.dart';
import '../../models/product_model.dart';
import '../widgets/text_form_filed.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Search",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormFiledComponent(
                          controller: searchController,
                          hintText: 'Search',
                          prefixIcon: IconBroken.Search,
                          onChanged: (value) {
                            print(value);
                            cubit.searchForProduct(value.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                  AppSize.sv_10,
                  if (state is LayoutSearchLoadingState)
                    const Center(child: CircularProgressIndicator()),
                  if (state is LayoutSearchErrorState ||
                      cubit.searchProducts.isEmpty)
                    Expanded(
                      child: Container(
                        height: SizeConfig.screenHeight * 0.4,
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          image: const DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(AppImage.errorImage),
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => _buildItemList(
                          context: context,
                          data: cubit.searchProducts[index],
                        ),
                        separatorBuilder: (context, index) => AppSize.sv_10,
                        itemCount: cubit.searchProducts.length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemList(
      {required BuildContext context, required ProductModel data}) {
    return Container(
      height: SizeConfig.screenWidth * 0.31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: SizeConfig.screenWidth * 0.21,
              height: SizeConfig.screenWidth * 0.29,
              decoration: BoxDecoration(
                //color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(data.imageUrl),
                ),
              ),
            ),
          ),
          AppSize.sh_10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSize.sv_10,
                Text(
                  data.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                AppSize.sv_10,
                Text(
                  data.price.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
