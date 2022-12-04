import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:grocery_app_2022/models/product.dart';

import '../../../styles/app_layout.dart';
import '../../../styles/styles.dart';
import '../../../widgets/build_appbar.dart';
import '../cart/payment_cart.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double rating = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            BuildAppBar(title: 'Product Details'),
            Center(
              child: SizedBox(
                height: AppLayout.getHeight(300),
                width: AppLayout.getHeight(300),
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: widget.product,
                  child: Image.network(widget.product.imageUrl),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('title', style: Styles.headLineStyle2),
                        Text('Available in stock',
                            style: Styles.headLineStyle4),
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
            Row(
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
                    '1',
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
                Spacer(),
                Text('22', style: Styles.headLineStyle2)
              ],
            ),
            Divider(color: Colors.blueGrey),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Item Description'),
                  SizedBox(height: 8),
                  Text(
                      'Et non aliquip in consequat nulla velit minim et. Lorem commodo cillum cupidatat in Lorem. Tempor veniam amet nostrud ex minim officia occaecat culpa mollit tempor ipsum id duis. Cillum sunt pariatur esse ad et amet nostrud velit eu ullamco veniam amet veniam.'),
                ],
              ),
            ),
            GFRating(
              color: Styles.orangeColor,
              borderColor: Styles.orangeColor,
              value: rating,
              onChanged: (value) {
                setState(() {
                  rating = value;
                });
              },
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
            Gap(20),
          ],
        ),
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
