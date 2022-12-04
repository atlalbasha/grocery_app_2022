import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/product_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

import '../../controller/image_controller.dart';
import '../../models/product.dart';
import '../../services/firestore_db.dart';
import '../../services/storage_db.dart';
import '../../styles/app_layout.dart';
import '../../styles/styles.dart';
import '../../widgets/build_appbar.dart';
import '../../widgets/build_image.dart';

class UploadProductScreen extends StatelessWidget {
  UploadProductScreen({super.key, this.product});
  final dynamic product;

  ProductController productController = Get.put(ProductController());
  ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    imageController.image = null;
    print(product);
    return Scaffold(
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => Form(
              autovalidateMode: product == null
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              key: productController.formKey,
              child: ListView(
                children: [
                  product != null
                      ? BuildAppBar(
                          title: product == null
                              ? 'Upload Product'
                              : 'Edit Product',
                        )
                      : Text('Add a new product', style: Styles.headLineStyle3),
                  const Gap(40),
                  product == null
                      ? BuildImage(
                          imagePath: imageController.image,
                          callback: () => imageController.pickImage())
                      : BuildImage(
                          imageUrl: product.imageUrl,
                          imagePath: imageController.image,
                          callback: () => imageController.pickImage()),
                  const Gap(40),
                  BuildTextFormField(
                    'Title',
                    product != null ? product.title : 'Product name',
                    productController,
                    UniconsLine.label_alt,
                    TextInputType.text,
                  ),
                  const Gap(10),
                  BuildTextFormField(
                    'Price',
                    product != null
                        ? product.price.toString()
                        : 'Product price 25.99\$',
                    productController,
                    UniconsLine.bill,
                    const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const Gap(10),
                  BuildTextFormField(
                      'Discount',
                      product != null
                          ? product.discount.toString()
                          : 'Product discount 25%',
                      productController,
                      Icons.discount_outlined,
                      TextInputType.number),
                  const Gap(10),
                  DropdownButtonFormField(
                      decoration: Styles.dropdownDecoration.copyWith(
                        prefixIcon:
                            Icon(UniconsLine.apps, color: Styles.orangeColor),
                      ),
                      onChanged: (value) => {
                            productController.newProduct.update(
                                'Category', (_) => value,
                                ifAbsent: () => value)
                          },
                      value: productController.selectedCategory,
                      items: productController.category
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ))
                          .toList()),
                  const Gap(10),
                  DropdownButtonFormField(
                      decoration: Styles.dropdownDecoration.copyWith(
                        prefixIcon:
                            Icon(UniconsLine.weight, color: Styles.orangeColor),
                      ),
                      onChanged: (value) => {
                            productController.newProduct.update(
                                'Unit', (_) => value,
                                ifAbsent: () => value)
                          },
                      value: productController.selectedUnits,
                      items: productController.units
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ))
                          .toList()),
                  const Gap(10),
                  TextFormField(
                    validator: (value) => value!.isEmpty
                        ? 'Please this field must be filled'
                        : null,
                    onChanged: (value) => {
                      productController.newProduct.update(
                          'Description', (_) => value,
                          ifAbsent: () => value)
                    },
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: Styles.inputDecoration.copyWith(
                      prefixIcon: Icon(Icons.description_outlined,
                          color: Styles.orangeColor),
                      labelText: 'Description',
                      hintText: product != null
                          ? product.description
                          : 'Write product description here..',
                    ),
                  ),
                  const Gap(20),
                  product == null
                      ? SizedBox(
                          height: AppLayout.getHeight(50),
                          child: ElevatedButton(
                            onPressed: () {
                              productController.uploadProduct();
                            },
                            child: Text('Upload Product'),
                          ),
                        )
                      : Container(),
                  product != null
                      ? SizedBox(
                          height: AppLayout.getHeight(50),
                          child: ElevatedButton(
                            onPressed: () {
                              productController.updateProduct(product);
                            },
                            child: const Text('Update Product'),
                          ),
                        )
                      : Container(),
                  const Gap(10),
                  product != null
                      ? SizedBox(
                          height: AppLayout.getHeight(50),
                          child: ElevatedButton(
                            onPressed: () async {
                              await productController.deleteProduct(product.id);
                              Navigator.pop(context);
                            },
                            child: const Text('Delete Product'),
                          ),
                        )
                      : Container(),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField BuildTextFormField(
    String title,
    String hintText,
    ProductController productController,
    IconData icon,
    TextInputType textInputType,
  ) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? 'Enter a valid value' : null,
      onChanged: (value) => {
        productController.newProduct
            .update(title, (_) => value, ifAbsent: () => value)
      },
      keyboardType: textInputType,
      decoration: Styles.inputDecoration.copyWith(
        prefixIcon: Icon(icon, color: Styles.orangeColor),
        hintText: hintText,
        labelText: title,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: 'xx',
      ),
    );
  }
}
