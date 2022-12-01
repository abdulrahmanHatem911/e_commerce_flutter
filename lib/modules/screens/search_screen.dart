import 'package:e_commerce_flutter/core/style/icon_broken.dart';
import 'package:e_commerce_flutter/core/utils/app_size.dart';
import 'package:e_commerce_flutter/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../core/utils/screen_config.dart';
import '../widgets/text_form_filed.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: TextFormFiledComponent(
                  controller: searchController,
                  hintText: 'Search',
                  prefixIcon: IconBroken.Search,
                ),
              ),
            ],
          ),
          AppSize.sv_10,
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => _buildItemList(context: context),
              separatorBuilder: (context, index) => AppSize.sv_10,
              itemCount: 15,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildItemList({required BuildContext context}) {
    return Container(
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
              width: SizeConfig.screenWidth * 0.27,
              height: SizeConfig.screenWidth * 0.31,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AppImage.beaneryImage1),
                ),
              ),
            ),
          ),
          AppSize.sh_10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Beanery",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSize.sv_10,
                const Text(
                  "this is a description of the product",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                AppSize.sv_10,
                const Text(
                  'this is a price of the product',
                  style: TextStyle(
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
