import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

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
  final formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController description = TextEditingController();

  List<String> category = ['Fruits', 'Vegetables', 'Drinks', 'Other'];
  String? selectedCategory = 'Fruits';

  List<String> units = ['1kg', '1pcs'];
  String? selectedUnits = '1kg';
  late String imageUrl = '';

  @override
  void dispose() {
    title.dispose();
    price.dispose();
    discount.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  XFile? image;
  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      setState(() {
        image = pickedImage;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image:  $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(
                  'Add a new product',
                  style: Styles.headLineStyle3,
                ),
                const Gap(40),
                BuildImage(imagePath: image, callback: () => pickImage()),
                const Gap(40),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a valid value' : null,
                  controller: title,
                  decoration: Styles.inputDecoration.copyWith(
                    prefixIcon: Icon(Icons.label_important_outline_rounded,
                        color: Styles.orangeColor),
                    labelText: 'Product Name',
                    hintText: 'Banana',
                  ),
                ),
                const Gap(10),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a valid value' : null,
                  controller: price,
                  keyboardType: TextInputType.number,
                  decoration: Styles.inputDecoration.copyWith(
                    prefixIcon: Icon(Icons.attach_money_outlined,
                        color: Styles.orangeColor),
                    hintText: '0.00 ',
                    labelText: 'Price',
                  ),
                ),
                const Gap(10),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a valid value' : null,
                  controller: discount,
                  keyboardType: TextInputType.number,
                  decoration: Styles.inputDecoration.copyWith(
                    prefixIcon: Icon(Icons.discount_outlined,
                        color: Styles.orangeColor),
                    labelText: 'Discount',
                    hintText: '25%',
                  ),
                ),
                const Gap(10),
                DropdownButtonFormField(
                    decoration: Styles.dropdownDecoration.copyWith(
                      prefixIcon:
                          Icon(UniconsLine.apps, color: Styles.orangeColor),
                    ),
                    onChanged: (item) =>
                        setState(() => selectedCategory = item),
                    value: selectedCategory,
                    items: category
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
                    onChanged: (item) => setState(() => selectedUnits = item),
                    value: selectedUnits,
                    items: units
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                              ),
                            ))
                        .toList()),
                const Gap(10),
                TextFormField(
                  controller: description,
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
                    onPressed: () {},
                    child: Text('Upload Product'),
                  ),
                ),
                const Gap(10),
                SizedBox(
                  height: AppLayout.getHeight(50),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Delete Product'),
                  ),
                ),
                const Gap(10),
                SizedBox(
                  height: AppLayout.getHeight(50),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Cancel'),
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
}
