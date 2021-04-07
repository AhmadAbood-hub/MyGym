import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Payment {
  DateTime date;
  String name;
  double price;

  Payment({
    @required this.date,
    @required this.name,
    @required this.price,
  });
}

class PaymentProvider with ChangeNotifier {
  List<Payment> paymentList = [
    Payment(date: DateTime.now(), name: "SSS", price: 3000.0),
    Payment(date: DateTime.now(), name: "aa", price: 4000.0),
    Payment(date: DateTime.now(), name: "dd", price: 5000.0),
    Payment(date: DateTime.now(), name: "ee", price: 6000.0),
    Payment(date: DateTime.now(), name: "ee", price: 9000.0),
    Payment(date: DateTime.now(), name: "ee", price: 9500.0),
    Payment(date: DateTime.now(), name: "SSS", price: 80000.0),
    Payment(date: DateTime.now(), name: "SSS", price: 70000.0),
    Payment(
        /*   date: DateFormat('dd/MM/yyyy')
            .format(DateTime.parse("22/04/2020".split('/').reversed.join()))
            .toString(),*/
        date: DateTime.now(),
        name: "SSS",
        price: 6500.0),
  ];

  List<Payment> searchResult = [];

  DateTime startFilter =
      DateTime.parse("22/04/2020".split('/').reversed.join()); // initDate
  DateTime endFilter =
      DateTime.parse("22/04/2100".split('/').reversed.join()); // initDate
  double startPriceFilter = 0;
  double endPriceFilter = 10000;

  void add(Payment payment) {
    paymentList.add(
        Payment(date: payment.date, name: payment.name, price: payment.price));
    notifyListeners();
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    notifyListeners();

    if (text.isEmpty) {
      return;
    }

    paymentList.forEach((paymentDetail) {
      if (paymentDetail.name.contains(text) &&
          paymentDetail.price >= startPriceFilter &&
          paymentDetail.price <= endPriceFilter &&
          paymentDetail.date.isAfter(startFilter) &&
          paymentDetail.date.isBefore(endFilter)) {
        searchResult.add(paymentDetail);
        notifyListeners();
      }
    });
  }

  List<Payment> getPaymentList() {
    return [...paymentList];
  }

  void setStartFilter(DateTime startFilter) {
    this.startFilter = startFilter;
    notifyListeners();
  }

  void setEndFilter(DateTime endFilter) {
    this.endFilter = endFilter;
    notifyListeners();
  }

  void setPriceFilter(double startPriceFilter, double endPriceFilter,DateTime startFilter , DateTime endFilter ) {
    this.startFilter = startFilter;
    this.endFilter = endFilter;
    this.startPriceFilter = startPriceFilter;
    this.endPriceFilter = endPriceFilter;

    searchResult.clear();

    notifyListeners();
    paymentList.forEach((paymentDetail) {
      if (paymentDetail.price >= startPriceFilter &&
          paymentDetail.price <= endPriceFilter  &&
          paymentDetail.date.isAfter(startFilter) &&
          paymentDetail.date.isBefore(endFilter)) {
        searchResult.add(paymentDetail);
        notifyListeners();
      }
    });
    if (searchResult.length == 0) {
      searchResult.add(Payment(date:   DateTime.parse("22/04/2000".split('/').reversed.join()), name: "", price: 0));
      notifyListeners();
    }
  }
}
