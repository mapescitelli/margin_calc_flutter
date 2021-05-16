import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  String cost;
  String margin;
  String revenue;
  String profit;

  final dollar = new NumberFormat("#,##0.00", "en_US");

  void updateValues() {
    if (cost != null && margin != null) {
      print("$cost and $margin");
      log("$cost and $margin");

      revenue = dollar
          .format(double.tryParse(cost) / (1 - (double.tryParse(margin))));
      profit =
          dollar.format(double.tryParse(revenue) * double.tryParse(margin));

      print("revenue: $revenue");

      setState(() {
        _revenueTextController.text = "$revenue";
        _profitTextController.text = "$profit";
      });
    } else if (margin != null && revenue != null) {
    } else if (revenue != null && profit != null) {
    } else if (profit != null && cost != null) {}
  }

  var _revenueTextController = TextEditingController();
  var _profitTextController = TextEditingController();
  var _marginTextController = TextEditingController();
  var _costTextController = TextEditingController();

  final FocusNode _revenueFocusNode = FocusNode();
  final FocusNode _profitFocusNode = FocusNode();
  final FocusNode _marginFocusNode = FocusNode();
  final FocusNode _costFocusNode = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: _costFocusNode,
            toolbarButtons: [
              //button 1
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "CLOSE",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
              //button 2
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "DONE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            ],
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Margin Calculator",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Cost",
                  style: kTextStyle,
                ),
                TextFormField(
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  //focusNode: _costFocusNode,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    cost = value ?? 0;

                    updateValues();

                    if (_formKey.currentState.validate()) {}
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      //..return 'Please enter text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        "\$",
                        style: kTextStyle,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        " ",
                        style: kTextStyle,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Margin",
                  style: kTextStyle,
                ),
                TextFormField(
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    margin = (double.tryParse(value) * .01).toString() ?? "";

                    updateValues();

                    if (_formKey.currentState.validate()) {}
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      //return 'Please enter text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        " ",
                        style: kTextStyle,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        "%",
                        style: kTextStyle,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Revenue",
                  style: kTextStyle,
                ),
                TextFormField(
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: _revenueTextController,
                  onChanged: (value) {
                    revenue = value ?? 0;

                    updateValues();

                    if (_formKey.currentState.validate()) {}
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      //return 'Please enter text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        "\$",
                        style: kTextStyle,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        " ",
                        style: kTextStyle,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Profit",
                  style: kTextStyle,
                ),
                TextFormField(
                  style: kTextStyle,
                  textAlign: TextAlign.center,
                  controller: _profitTextController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    profit = value ?? 0;

                    updateValues();

                    if (_formKey.currentState.validate()) {}
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      //return 'Please enter text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        "\$",
                        style: kTextStyle,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        " ",
                        style: kTextStyle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
