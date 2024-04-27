import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isnumber;

  String? confirmedpass;
  bool? notconfirmedpass;
  final TextEditingController myController;
  CustomTextField(
      {super.key,
      required this.hint,
      required this.myController,
      required this.isnumber,
      this.confirmedpass});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextFormField(
        validator: (value) => (value!.isEmpty) ? 'Please enter $hint' : null,
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 12 * 4),
        controller: myController,
        keyboardType: (isnumber) ? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.purple[200]),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(12),
            )),
      ),
    );
  }
}
