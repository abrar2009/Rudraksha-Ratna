import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/api_requests/api_calls.dart';

class DeleteItemDialog extends StatelessWidget {
  final String? deletionId;
  final String title;
  final String deleteButtonText;
  final Future<ApiCallResponse> Function(String? id) deleteApiCall;
  final String successMessageField;
  final String errorMessageField;

  const DeleteItemDialog({
    required this.deletionId,
    required this.title,
    required this.deleteButtonText,
    required this.deleteApiCall,
    required this.successMessageField,
    required this.errorMessageField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.24,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 20.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          context.safePop();
                        },
                        text: 'Cancel',
                        options: FFButtonOptions(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.35,
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF3E3E40),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          final result = await deleteApiCall(deletionId);

                          if (result.succeeded ?? false) {
                            final status = getJsonField(result.jsonBody ?? '', r'''$.status''');
                            final message = getJsonField(result.jsonBody ?? '', r'''$.msg''');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  message.toString(),
                                  style: TextStyle(color: FlutterFlowTheme.of(context).primaryBackground),
                                ),
                                duration: const Duration(milliseconds: 4000),
                                backgroundColor: status == 'success' ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primary,
                              ),
                            );

                            if (status == 'success') {
                              Navigator.pop(context);
                            }
                          }
                        },
                        text: deleteButtonText,
                        options: FFButtonOptions(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.35,
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                          ),
                          elevation: 0.0,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
