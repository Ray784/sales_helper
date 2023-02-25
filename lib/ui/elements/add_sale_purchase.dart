// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:my_sales/constants.dart';
import 'package:my_sales/database/model/model.dart';
import 'package:my_sales/ui/elements/dialog.dart';

class SalePurchaseForm extends StatefulWidget {
  final Function(Account) onStateChange;
  final bool isSale;

  const SalePurchaseForm({required this.onStateChange, this.isSale = true});

  @override
  State<StatefulWidget> createState() {
    return _FormState();
  }
}

class _FormState extends State<SalePurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                controller: dateController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ${widget.isSale ? 'sale' : 'purchase'} date';
                  }
                  return null;
                },
                cursorColor: darkPrimary.shade300,
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  suffixIcon: const IconTheme(
                    data: IconThemeData(color: darkPrimary),
                    child: Icon(Icons.calendar_month_outlined),
                  ),
                  icon: const IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: Icon(Icons.timeline_outlined),
                  ),
                  hintText:
                      "${widget.isSale ? 'sale' : 'purchase'} date (yyyy-mm-dd)",
                  border: OutlineInputBorder(
                      gapPadding: 0, borderRadius: BorderRadius.circular(10)),
                  fillColor: lighterPrimary,
                  filled: true,
                ),
                showCursor: false,
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 5),
                          lastDate: DateTime.now(),
                          initialDate: (dateController.text.isNotEmpty)
                              ? DateTime.parse(dateController.text)
                              : DateTime.now())
                      .then((DateTime? value) {
                    if (value != null) {
                      _formKey.currentState!.setState(() {
                        dateController.text = value.toString().split(" ").first;
                      });
                    }
                  });
                },
              )),
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                controller: descriptionController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  return null;
                },
                cursorColor: darkPrimary.shade300,
                maxLines: 5,
                decoration: InputDecoration(
                  icon: const IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: Icon(Icons.description_outlined),
                  ),
                  iconColor: Colors.white,
                  hintText:
                      "${widget.isSale ? 'sale' : 'purchase'} description",
                  border: OutlineInputBorder(
                      gapPadding: 0, borderRadius: BorderRadius.circular(10)),
                  fillColor: lighterPrimary,
                  filled: true,
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                controller: amountController,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a ${widget.isSale ? 'sale' : 'purchase'} value';
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a ${widget.isSale ? 'sale' : 'purchase'} value";
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
                  hintText:
                      "${widget.isSale ? 'sale' : 'purchase'} value (1000)",
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
                double? amount = double.tryParse(amountController.text);
                String? description = descriptionController.text;
                String? date = dateController.text;
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                      dialogText:
                          "Do you want to add ${widget.isSale ? 'sale' : 'purchase'} of value $amount on $date?"),
                ).then((value) {
                  if (value == true) {
                    Account account = Account(
                        dateTime: date.isEmpty
                            ? DateTime.now()
                            : DateTime.parse(date),
                        amount: amount ?? 0,
                        description: description,
                        isPurchase: !widget.isSale);
                    widget.onStateChange(account);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Processing data")),);
                      _formKey.currentState!.setState(() {
                        amountController.text = "";
                        descriptionController.text = "";
                        dateController.text = "";
                      });
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
