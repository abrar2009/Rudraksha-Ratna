// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// import 'package:country_code_picker/country_code_picker.dart';

// class CountryCodeSelector extends StatefulWidget {
//   const CountryCodeSelector({
//     Key? key,
//     this.width,
//     this.height,
//   }) : super(key: key);

//   final double? width;
//   final double? height;

//   @override
//   State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
// }

// class _CountryCodeSelectorState extends State<CountryCodeSelector> {
//   String? _selectedCountryCode;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       //padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CountryCodePicker(
//             onChanged: (countryCode) {
//               setState(() {
//                 _selectedCountryCode = countryCode.dialCode;
//                 FFAppState().update(
//                   () {
//                     FFAppState().countrycode = _selectedCountryCode!;
//                   },
//                 );
//               });
//             },
//             initialSelection: 'IN',
//             favorite: ['+91', 'IN'],
//             showCountryOnly: false,
//             showOnlyCountryWhenClosed: false,
//             alignLeft: true,
//             textStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//             ),
//           ),
//           Container(
//             height: 1,
//             color: Colors.black,
//             margin: EdgeInsets.only(top: 4.0),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CountryCodeSelector extends StatefulWidget {
  const CountryCodeSelector({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  String? _selectedCountryCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              setState(() {
                _selectedCountryCode = number.dialCode;
                FFAppState().update(
                  () {
                    FFAppState().countrycode = _selectedCountryCode!;
                  },
                );
              });
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
              showFlags: false,
              useEmoji: false,
              leadingPadding: 0,
              trailingSpace: false,
              setSelectorButtonAsPrefixIcon: false,
            ),
            initialValue: PhoneNumber(isoCode: 'US'),
            textFieldController: TextEditingController(),
            formatInput: false,
            inputDecoration: InputDecoration(
              hintText: 'Select Country Code',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
          Container(
            height: 1,
            color: Colors.black,
            margin: EdgeInsets.only(top: 4.0),
          ),
        ],
      ),
    );
  }
}
