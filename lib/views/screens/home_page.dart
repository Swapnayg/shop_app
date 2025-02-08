import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constant/app_color.dart';
import 'package:shop_app/core/model/category.dart';
import 'package:shop_app/core/model/product.dart';
import 'package:shop_app/core/services/CategoryService.dart';
import 'package:shop_app/core/services/productservice.dart';
import 'package:shop_app/views/screens/empty_cart_page.dart';
import 'package:shop_app/views/screens/message_page.dart';
import 'package:shop_app/views/screens/search_page.dart';
import 'package:shop_app/views/widgets/category_card.dart';
import 'package:shop_app/views/widgets/custom_icon_button_widget.dart';
import 'package:shop_app/views/widgets/dummy_search_widget_1.dart';
import 'package:shop_app/views/widgets/flashsale_countdown_tile.dart';
import 'package:shop_app/views/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categoryData = CategoryService.categoryData;
  List<Product> productData = Productservice.productData;

  late Timer flashsaleCountdownTimer;
  Duration flashsaleCountdownDuration = Duration(
    hours: 24 - DateTime.now().hour,
    minutes: 60 - DateTime.now().minute,
    seconds: 60 - DateTime.now().second,
  );

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      setCountdown();
    });
  }

  void setCountdown() {
    if (mounted) {
      setState(() {
        final seconds = flashsaleCountdownDuration.inSeconds - 1;

        if (seconds < 1) {
          flashsaleCountdownTimer.cancel();
        } else {
          flashsaleCountdownDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  void dispose() {
    flashsaleCountdownTimer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String seconds = flashsaleCountdownDuration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String minutes = flashsaleCountdownDuration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String hours = flashsaleCountdownDuration.inHours
        .remainder(24)
        .toString()
        .padLeft(2, '0');

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1
          Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 26),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Find the best \noutfit for you.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          height: 150 / 100,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        children: [
                          CustomIconButtonWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const EmptyCartPage()));
                            },
                            value: 0,
                            icon: SvgPicture.asset(
                              'assets/icons/Bag.svg',
                              color: Colors.white,
                            ),
                          ),
                          CustomIconButtonWidget(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MessagePage()));
                            },
                            value: 2,
                            margin: const EdgeInsets.only(left: 16),
                            icon: SvgPicture.asset(
                              'assets/icons/Chat.svg',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DummySearchWidget1(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Section 2 - category
          Container(
            width: MediaQuery.of(context).size.width,
            color: AppColor.secondary,
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          'View More',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                // Category list
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  height: 96,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categoryData.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 16);
                    },
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        data: categoryData[index],
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Section 3 - banner
          // Container(
          //   height: 106,
          //   padding: EdgeInsets.symmetric(vertical: 16),
          //   child: ListView.separated(
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 3,
          //     separatorBuilder: (context, index) {
          //       return SizedBox(width: 16);
          //     },
          //     itemBuilder: (context, index) {
          //       return Container(
          //         width: 230,
          //         height: 106,
          //         decoration: BoxDecoration(color: AppColor.primarySoft, borderRadius: BorderRadius.circular(15)),
          //       );
          //     },
          //   ),
          // ),

          // Section 4 - Flash Sale
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Flash Sale',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: hours[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: hours[1],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 2.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: minutes[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: minutes[1],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 2.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: seconds[0],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: FlashsaleCountdownTile(
                              digit: seconds[1],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 310,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            productData.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ItemCard(
                                    productI: productData[index],
                                    titleColor: AppColor.primarySoft,
                                    priceColor: AppColor.accent,
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child:
                                                  const LinearProgressIndicator(
                                                minHeight: 10,
                                                value: 0.4,
                                                color: AppColor.accent,
                                                backgroundColor:
                                                    AppColor.border,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.local_fire_department,
                                          color: AppColor.accent,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         color: Colors.amber,
                                  //         height: 10,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Section 5 - product list

          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              'Todays recommendation...',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(
                productData.length,
                (index) => ItemCard(
                  productI: productData[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
