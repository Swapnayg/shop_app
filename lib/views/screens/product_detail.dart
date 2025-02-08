import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constant/app_color.dart';
import 'package:shop_app/core/model/product.dart';
import 'package:shop_app/views/screens/image_viewer.dart';
import 'package:shop_app/views/widgets/custom_app_bar.dart';
import 'package:shop_app/views/widgets/modals/add_to_cart_modal.dart';
import 'package:shop_app/views/widgets/rating_tag.dart';
import 'package:shop_app/views/widgets/review_tile.dart';
import 'package:shop_app/views/widgets/selectable_circle_color.dart';
import 'package:shop_app/views/widgets/selectable_circle_size.dart';
//import 'package:pecahan_rupiah/pecahan_rupiah.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetail extends StatefulWidget {
  final Product product1;
  const ProductDetail({super.key, required this.product1});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  PageController productImageSlider = PageController();
  @override
  Widget build(BuildContext context) {
    Product product_2 = widget.product1;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColor.border, width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              margin: const EdgeInsets.only(right: 14),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: () {},
                child: SvgPicture.asset('assets/icons/Chat.svg',
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 64,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return const AddToCartModal();
                      },
                    );
                  },
                  child: const Text(
                    'Add To Cart',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - appbar & product image
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // product image
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageViewer(imageUrl: product_2.image),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 310,
                  color: Colors.white,
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: productImageSlider,
                    children: List.generate(
                      product_2.image.length,
                      (index) => Image.asset(
                        product_2.image[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // appbar
              CustomAppBar(
                title: "",
                leftIcon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
                rightIcon: SvgPicture.asset(
                  'assets/icons/Bookmark.svg',
                  color: Colors.black.withOpacity(0.5),
                ),
                leftOnTap: () {
                  Navigator.of(context).pop();
                },
                rightOnTap: () {},
              ),
              // indicator
              // Positioned(
              //   bottom: 16,
              //   // child: SmoothPageIndicator(
              //   //   controller: productImageSlider,
              //   //   count: product_2.image.length,
              //   //   effect: ExpandingDotsEffect(
              //   //     dotColor: AppColor.primary.withOpacity(0.2),
              //   //     activeDotColor: AppColor.primary.withOpacity(0.2),
              //   //     dotHeight: 8,
              //   //   ),
              //   // ),
              // ),
            ],
          ),
          // Section 2 - product info
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product_2.name.toString(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: AppColor.secondary),
                        ),
                      ),
                      RatingTag(
                        margin: const EdgeInsets.only(left: 10),
                        value: product_2.rating!,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: const Text(
                    //'${Pecahan.rupiah(value: product_2.price, withRp: true)}',
                    "",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                        color: AppColor.primary),
                  ),
                ),
                Text(
                  'Bringing a new look to the Waffle sneaker family, the Nike Waffle One balances everything you love about heritage Nike running with fresh innovations.',
                  style: TextStyle(
                      color: AppColor.secondary.withOpacity(0.7),
                      height: 150 / 100),
                ),
              ],
            ),
          ),
          // Section 3 - Color Picker
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Color',
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins',
                  ),
                ),
                SelectableCircleColor(
                  colorWay: product_2.colors,
                  margin: const EdgeInsets.only(top: 12),
                ),
              ],
            ),
          ),

          // Section 4 - Size Picker
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Size',
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'poppins',
                  ),
                ),
                SelectableCircleSize(
                  productSize: product_2.sizes,
                  margin: const EdgeInsets.only(top: 12),
                ),
              ],
            ),
          ),

          // Section 5 - Reviews
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  initiallyExpanded: true,
                  childrenPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                  tilePadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  title: const Text(
                    'Reviews',
                    style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'poppins',
                    ),
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          ReviewTile(review_t: product_2.reviews[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemCount: 2,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 52, top: 12, bottom: 6),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                // ReviewsPage(reviews_page: product_2.reviews[0]),
                                const ListTile(title: Text('index: 123')),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColor.primary,
                          elevation: 0,
                          backgroundColor: AppColor.primarySoft,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'See More Reviews',
                          style: TextStyle(
                              color: AppColor.secondary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
