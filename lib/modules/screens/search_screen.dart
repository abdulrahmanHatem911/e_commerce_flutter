import 'package:e_commerce_flutter/core/style/icon_broken.dart';
import 'package:e_commerce_flutter/core/utils/app_size.dart';
import 'package:flutter/material.dart';

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
            child: Container(
              color: Colors.grey,
            ),
          ),
        ]),
      ),
    );
  }
}
