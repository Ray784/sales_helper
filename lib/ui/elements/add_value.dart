// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:my_sales/constants.dart';
import 'package:my_sales/database/model/model.dart';
import 'package:my_sales/ui/elements/dialog.dart';
import 'package:my_sales/ui/elements/toggle_tab.dart';

class ValueForm extends StatefulWidget {
  final Function(Account) onStateChange;

  const ValueForm({required this.onStateChange});

  @override
  State<StatefulWidget> createState() {
    return _ValueFormState();
  }
}

class _ValueFormState extends State<ValueForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const List<String> toggleIndices = ["sale", "purchase"];
    final ToggleTab toggleTab = ToggleTab(indices: toggleIndices);
    final TextEditingController amountController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          toggleTab,
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                controller: amountController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a number";
                  }
                  return null;
                },
                cursorColor: darkPrimary.shade300,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: const IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: Icon(Icons.currency_rupee_sharp),
                  ),
                  iconColor: Colors.white,
                  hintText: "1000",
                  border: OutlineInputBorder(
                      gapPadding: 0, borderRadius: BorderRadius.circular(10)),
                  fillColor: lighterPrimary,
                  filled: true,
                ),
              )),
          ElevatedButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text("Processing data")),
                // );
                String toggle = toggleIndices[toggleTab.selectedIndex];
                double? amount = double.tryParse(amountController.text);
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(dialogText: "Do you want to add $toggle of value $amount?"),
                ).then((value){
                  if (value == true) {
                    Account account = Account(dateTime: DateTime.now(), amount: amount ?? 0, isPurchase: toggle == "purchase"? true: false);
                    widget.onStateChange(account);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Processing data")),
                    );
                  }
                });
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(lighterPrimary),
            ),
            child: Text(
              "Add",
              style: ubuntuStyle.copyWith(color: darkPrimary),
            ),
          )
        ],
      ),
    );
  }
}
