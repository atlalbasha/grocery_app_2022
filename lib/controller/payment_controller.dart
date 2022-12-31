import 'package:get/get.dart';

class PaymentController extends GetxController {
  final _payment = 1.obs;
  get payment => _payment.value;
  set payment(value) => _payment.value = value;

  final _paymentMethod = 'Cash on Delivery'.obs;
  get paymentMethod => _paymentMethod.value;
  set paymentMethod(value) => _paymentMethod.value = value;
}
