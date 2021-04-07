import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:my_gym/configuration.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import '../provider/payment.dart';
import 'package:provider/provider.dart';

/// My app class to display the date range picker
class BottomSheetFilterPayment extends StatefulWidget {
  @override
  BottomSheetFilterPaymentState createState() =>
      BottomSheetFilterPaymentState();
}

class BottomSheetFilterPaymentState extends State<BottomSheetFilterPayment> {
  String _selectedDate;
  String _dateCount;
  String _range;
  String _rangeCount;

  List<RangeSliderData> rangeSliders;

  @override
  void initState() {
    rangeSliders = _rangeSliderDefinitions();
    _selectedDate = '';
    _dateCount = '';
    _range = '';
    _rangeCount = '';
    super.initState();
  }

  List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        Provider.of<PaymentProvider>(context, listen: false).setPriceFilter(
            lower,
            upper,
            Provider.of<PaymentProvider>(context, listen: false).startFilter,
            Provider.of<PaymentProvider>(context, listen: false).endFilter);

        rangeSliders[index].lowerValue =
            Provider.of<PaymentProvider>(context, listen: false)
                .startPriceFilter;

        rangeSliders[index].upperValue =
            Provider.of<PaymentProvider>(context, listen: false).endPriceFilter;
      }));
      children.add(SizedBox(height: SizeConfig.smallText));
    }

    return children;
  }

  List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 0,
          max: 10000,
          lowerValue: 0,
          upperValue: 10000,
          divisions: 10,
          valueIndicatorMaxDecimals: 0),
    ];
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      if (args.value.startDate != null)
        Provider.of<PaymentProvider>(context, listen: false)
            .setStartFilter(args.value.startDate);
      if (args.value.endDate != null)
        Provider.of<PaymentProvider>(context, listen: false)
            .setEndFilter(args.value.endDate);

      Provider.of<PaymentProvider>(context, listen: false).setPriceFilter(
          Provider.of<PaymentProvider>(context, listen: false).startPriceFilter,
          Provider.of<PaymentProvider>(context, listen: false).endPriceFilter,
          args.value.startDate,
          args.value.endDate != null ?args.value.endDate : args.value.startDate);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.largText),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Filter By",
              style: TextStyle(
                  fontSize: SizeConfig.meduim2Text,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeConfig.meduim2Text,
            ),
            Text("Date"),
            SizedBox(
              height: SizeConfig.meduimText,
            ),
            SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange: PickerDateRange(
                  Provider.of<PaymentProvider>(context, listen: true)
                              .startFilter ==
                          DateTime.parse(
                              "22/04/2020".split('/').reversed.join())
                      ? DateTime.now().subtract(const Duration(days: 1))
                      : Provider.of<PaymentProvider>(context, listen: true)
                          .startFilter,
                  Provider.of<PaymentProvider>(context, listen: true)
                              .endFilter ==
                          DateTime.parse(
                              "22/04/2100".split('/').reversed.join())
                      ? DateTime.now().add(const Duration(days: 1))
                      : Provider.of<PaymentProvider>(context, listen: true)
                          .endFilter,
                )),
            Text("Price"),
            Container(
              padding: EdgeInsets.only(
                  top: SizeConfig.meduim2Text,
                  left: SizeConfig.meduimText,
                  right: SizeConfig.meduimText),
              child: Column(children: <Widget>[]..addAll(_buildRangeSliders())),
            ),
            SizedBox(
              height: SizeConfig.meduimText,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: SizeConfig.meduimText + SizeConfig.xlargText,
                    width: SizeConfig.screenWidth * 0.35,
                    decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: SizeConfig.smallText),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.meduimText + SizeConfig.xlargText,
                    width: SizeConfig.screenWidth * 0.35,
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(
                              color: accentColor,
                              fontSize: SizeConfig.smallText),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 1,
    this.forceValueIndicator: false,
  });

  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);

  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  Widget build(BuildContext context, frs.RangeSliderCallback callback) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: Text(Provider.of<PaymentProvider>(context, listen: true)
                .startPriceFilter
                .toInt()
                .toString()),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                overlayColor: accentColor,
                activeTickMarkColor: accentColor,
                activeTrackColor: buttonColor,
                inactiveTrackColor: Colors.grey,
                //trackHeight: 8.0,
                thumbColor: buttonColor,
                valueIndicatorColor: buttonColor,
                showValueIndicator: showValueIndicator
                    ? ShowValueIndicator.always
                    : ShowValueIndicator.onlyForDiscrete,
              ),
              child: frs.RangeSlider(
                min: min,
                max: max,
                lowerValue: Provider.of<PaymentProvider>(context, listen: true)
                    .startPriceFilter,
                upperValue: Provider.of<PaymentProvider>(context, listen: true)
                    .endPriceFilter,
                divisions: divisions,
                showValueIndicator: showValueIndicator,
                valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                onChanged: (double lower, double upper) {
                  // call
                  callback(lower, upper);
                },
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: Text(Provider.of<PaymentProvider>(context, listen: true)
                .endPriceFilter
                .toInt()
                .toString()),
          ),
        ],
      ),
    );
  }
}
