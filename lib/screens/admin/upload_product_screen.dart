import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:grocery_app_2022/controller/product_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

import '../../models/product.dart';
import '../../services/firestore_db.dart';
import '../../services/storage_db.dart';
import '../../styles/app_layout.dart';
import '../../styles/styles.dart';
import '../../widgets/build_image.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key, this.product});
  final dynamic product;

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  StorageDB storageDB = StorageDB();

  FirestoreDB firestoreDB = FirestoreDB();
  final formKey = GlobalKey<FormState>();

  ProductController productController = Get.put(ProductController());

  XFile? image;

  Future pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      setState(() {
        image = pickedFile;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:  $e');
    }
  }

  Future uploadProduct() async {
    if (image == null) {
      Get.snackbar(
        'Error',
        'No image selected',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
      return;
    }

    await storageDB.uploadImage(image!, 'products_images');
    var imageUrl = await storageDB.getImageUrl(image!.name, 'products_images');
    productController.newProduct
        .update('imageUrl', (_) => imageUrl, ifAbsent: () => imageUrl);

    firestoreDB.addProduct(
        product: Product(
            id: '',
            category: productController.newProduct['category'],
            description: productController.newProduct['description'],
            discount: int.parse(productController.newProduct['discount']),
            imageUrl: productController.newProduct['imageUrl'],
            price: double.parse(productController.newProduct['price']),
            title: productController.newProduct['title'],
            unit: productController.newProduct['unit']));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text('Add a new product', style: Styles.headLineStyle3),
                const Gap(40),
                BuildImage(imagePath: image, callback: () => pickImage()),
                const Gap(40),
                BuildTextFormField('Title', 'Product name', productController),
                const Gap(10),
                BuildTextFormField('Price', 'Price', productController),
                const Gap(10),
                BuildTextFormField('Discount', '25%', productController),
                const Gap(10),
                DropdownButtonFormField(
                    decoration: Styles.dropdownDecoration.copyWith(
                      prefixIcon:
                          Icon(UniconsLine.apps, color: Styles.orangeColor),
                    ),
                    onChanged: (value) => {
                          productController.newProduct.update(
                              'category', (_) => value,
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
                              'unit', (_) => value,
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
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a valid value' : null,
                  onChanged: (value) => {
                    productController.newProduct.update(
                        'description', (_) => value,
                        ifAbsent: () => value)
                  },
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: Styles.inputDecoration.copyWith(
                    prefixIcon: Icon(Icons.description_outlined,
                        color: Styles.orangeColor),
                    labelText: 'Description',
                    hintText: 'Write product description here..',
                  ),
                ),
                const Gap(20),
                SizedBox(
                  height: AppLayout.getHeight(50),
                  child: ElevatedButton(
                    onPressed: () {
                      final isValidForm = formKey.currentState!.validate();
                      if (isValidForm) uploadProduct();
                    },
                    child: Text('Upload Product'),
                  ),
                ),
                const Gap(10),
              ],
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
  ) {
    return TextFormField(
      validator: (value) => value!.isEmpty ? 'Enter a valid value' : null,
      onChanged: (value) => {
        productController.newProduct
            .update(title, (_) => value, ifAbsent: () => value)
      },
      decoration: Styles.inputDecoration.copyWith(
        prefixIcon:
            Icon(Icons.attach_money_outlined, color: Styles.orangeColor),
        hintText: hintText,
        labelText: title,
      ),
    );
  }
}
