import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_components/src/text_field/controllers/currency_controller.dart';

class SchemeFieldController extends GetxController {

  FocusNode currentFocus;

  CurrencyTextFieldController currencyController;
  TextEditingController textController;


  @override
  void onInit() {
    super.onInit();


  }

  @override
  void onReady() {
    super.onReady();
  }

}