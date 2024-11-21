import 'package:flutter/material.dart';

class MetalDropdown extends StatefulWidget {
  final List<String?> items;
  final String? initialValue;
  final String? selectedValue; // Allow nullable selectedValue
  final ValueChanged<String?> onChanged;

  MetalDropdown({
    required this.items,
    required this.initialValue,
    required this.onChanged,
    this.selectedValue, // Make selectedValue nullable
  });

  @override
  _MetalDropdownState createState() => _MetalDropdownState();
}

class _MetalDropdownState extends State<MetalDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownButtonFormField<String>(
        /*value: widget.selectedValue != null && widget.items.contains(widget.selectedValue)
            ? widget.selectedValue
            : null, */
        value: widget.initialValue!.isNotEmpty && widget.items.contains(widget.initialValue)
            ? widget.initialValue
            : null,
        onChanged: (newValue) {
          widget.onChanged(newValue);
        },
        hint: Text(widget.initialValue!), // Display hint when no value is selected
        //hint: Text(widget.initialValue.isEmpty ? 'Select Metal' : ''),
        icon: Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.arrow_drop_down),
        ),
        items: widget.items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item!),
          );
        }).toList(),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
