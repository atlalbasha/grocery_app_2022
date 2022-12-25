import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:grocery_app_2022/models/product.dart';

import '../../../styles/app_layout.dart';
import '../../../styles/styles.dart';
import '../../../widgets/build_appbar.dart';
import '../cart/payment_cart.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.product});
  final Product product;

  double rating = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: BuildAppBar(title: 'Product Details'),
          ),
          Center(
            child: SizedBox(
              height: AppLayout.getHeight(300),
              width: AppLayout.getHeight(300),
              child: Hero(
                transitionOnUserGestures: true,
                tag: product,
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: AppLayout.getHeight(350),
                      // color: Styles.whiteColor,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Styles.whiteColor,
                            Styles.whiteColor,
                            // Styles.orangeColor,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Image.network(product.imageUrl),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title, style: Styles.headLineStyle2),
                        Text(
                            product.availableInStock
                                ? 'Available in stock'
                                : 'Out of stock',
                            style: Styles.headLineStyle4),
                        GFRating(
                          color: Styles.orangeColor,
                          borderColor: Styles.orangeColor,
                          size: AppLayout.getHeight(20),
                          value: rating,
                          onChanged: (value) {},
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      color: Colors.deepOrangeAccent,
                      icon: Icon(Icons.favorite_border),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Styles.orangeColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Styles.whiteColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    product.quantity.toString(),
                    style: Styles.headLineStyle2,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Styles.orangeColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(' ${product.price.toString()}\$',
                        style: Styles.headLineStyle2),
                    Text('  ${product.unit}', style: Styles.headLineStyle3)
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(color: Colors.blueGrey),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Product Description', style: Styles.headLineStyle2),
                const Gap(10),
                Text(product.description, style: Styles.headLineStyle4),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: AppLayout.getHeight(50),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => PaymentCart()))),
                child: Text('Add To Cart'),
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
