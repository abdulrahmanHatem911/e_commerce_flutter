import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../utils/app_size.dart';
import '../utils/app_strings.dart';
import '../utils/screen_config.dart';

class BuildItemListComponent extends StatelessWidget {
  final ProductModel? item;
  const BuildItemListComponent({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth * 0.30,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(10.0),
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
            width: SizeConfig.screenWidth * 0.24,
            height: SizeConfig.screenWidth * 0.29,
            decoration: BoxDecoration(
              color: Colors.white,
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppSize.sv_5,
                Expanded(
                  child: Text(
                    item?.description ?? 'product description',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
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
        ],
      ),
    );
  }
}
