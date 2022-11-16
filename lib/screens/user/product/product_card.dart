import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grocery_app_2022/screens/user/product/product_details_screen.dart';

import '../../../styles/styles.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => ProductDetails()))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: LayoutBuilder(
          builder: (BuildContext, BoxConstraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 125,
                        width: 200,
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: 1,
                          child: Image.network(
                              'http://clipart-library.com/image_gallery2/Banana-PNG-File.png'),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.discount_outlined,
                            color: Styles.orangeColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('object');
                          },
                          child: Icon(
                            Icons.favorite_border,
                            color: Styles.orangeColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(10),
                Text(
                  'title ',
                  style: Styles.textStyle,
                  maxLines: 2,
                ),
                Text('unit', style: Styles.headLineStyle4),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          ' price',
                          style: Styles.headLineStyle4.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Styles.orangeColor),
                        ),
                        const Gap(4),
                        Text('discount', style: Styles.headLineStyle4),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Styles.orangeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
