import 'package:e_commerce_flutter/core/utils/app_strings.dart';
import 'package:e_commerce_flutter/core/utils/dummy_data.dart';
import 'package:e_commerce_flutter/core/utils/screen_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/routes/app_routers.dart';
import '../../../core/utils/app_size.dart';
import '../../widgets/cart/botton_pay.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Payment'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  height: SizeConfig.screenHeight * 0.4,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => _buildItemList(
                      context: context,
                      data: DummyPayment.dummyPayment[index],
                    ),
                    separatorBuilder: (context, index) => Container(
                      height: 10.0,
                      color: Colors.white,
                    ),
                    itemCount: DummyPayment.dummyPayment.length,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: SizeConfig.screenHeight * 0.3,
                    width: SizeConfig.screenWidth,
                    color: Colors.grey[100],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order Details:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(color: Colors.grey.shade400, thickness: 1.0),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              'Total Price:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '100\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomPayment(text: 'Payment Processes ', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildItemList({
    required BuildContext context,
    required DummyPayment data,
  }) {
    return InkWell(
      child: Container(
        color: Colors.grey.shade100,
        height: SizeConfig.screenHeight * 0.08,
        child: Row(
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.2,
              height: SizeConfig.screenHeight * 0.05,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            AppSize.sh_5,
            Expanded(
              child: Text(
                data.title,
                style: GoogleFonts.ubuntu(
                  fontSize: 20.0,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
