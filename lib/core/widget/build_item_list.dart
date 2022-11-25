import 'package:e_commerce_flutter/models/product_model.dart';
import 'package:flutter/material.dart';

import '../utils/app_size.dart';
import '../utils/app_strings.dart';
import '../utils/screen_config.dart';

class BuildItemListComponent extends StatelessWidget {
  final ProductModel? item;
  const BuildItemListComponent({super.key, this.item});

  @override
  Widget build(BuildContext context) {
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
          Container(
            width: SizeConfig.screenWidth * 0.3,
            height: SizeConfig.screenWidth * 0.34,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: item?.imageUrl != null
                    ? NetworkImage(item!.imageUrl) as ImageProvider
                    : const AssetImage(AppImage.testImage03),
                fit: BoxFit.contain,
              ),
            ),
          ),
          AppSize.sh_10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.name ?? 'product name',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSize.sv_10,
                Text(
                  item?.description ?? 'product description',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                AppSize.sv_10,
                Text(
                  '\$ ${item?.price ?? '0.0'}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
