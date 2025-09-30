import 'package:Cricbites/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;

  const CustomDateField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
  });

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.text =
      "${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}-${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: CustomTextField(
          icon: icon,
          controller: controller,
          hintText: hintText,
          readOnly: true,
        ),
      ),
    );
  }
}
