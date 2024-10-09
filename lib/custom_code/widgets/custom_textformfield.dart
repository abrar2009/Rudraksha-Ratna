import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool isObscureText;
  final String? Function(String?) validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.isObscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: false,
      obscureText: isObscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
          fontFamily: 'Montserrat',
          letterSpacing: 0,
        ),
        hintText: hintText,
        hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
          fontFamily: 'Montserrat',
          color: FlutterFlowTheme.of(context).primaryText,
          fontSize: 16,
          letterSpacing: 0,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).labelText,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(0, 6, 0, 12),
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
        fontFamily: 'Montserrat',
        fontSize: 16,
        letterSpacing: 0,
      ),
      keyboardType: keyboardType,
      cursorColor: FlutterFlowTheme.of(context).primary,
      validator: validator,
    );
  }
}
