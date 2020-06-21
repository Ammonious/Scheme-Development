import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scheme_components/src/textfields/controllers/currency_controller.dart';

class SchemeFieldController extends GetController {

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