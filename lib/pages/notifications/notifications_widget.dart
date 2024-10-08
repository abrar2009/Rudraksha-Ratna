import 'package:flutter/material.dart';
import 'package:rudraksha_cart/flutter_flow/flutter_flow_util.dart';
import '../../auth/custom_auth/auth_util.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../backend/api_requests/api_manager.dart';
import '../../flutter_flow/custom_functions.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class NotificationItem {
  final String title;
  final String body;
  final DateTime receivedAt;

  NotificationItem(this.title, this.body, this.receivedAt);
}

class NotificationScreen extends StatelessWidget {
  final token = currentAuthenticationToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                offset: Offset(0, 4), // Move shadow downwards by 4 pixels
                blurRadius: 6, // Blur radius for a softer shadow
                spreadRadius: 1, // Spread radius for shadow expansion
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 60,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF272728),
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
                print('The notification token: $token');
              },
            ),
            title: Text(
              'Notifications',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Color(0xFF272728),
                fontSize: 16,
                letterSpacing: 0,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
      ),
      body: (token == null)
          ? Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/empty_notification.png',
                //width: 200,
                //height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ) : FutureBuilder<ApiCallResponse>(
        future: NotificationsListCall.call(
          token: currentAuthenticationToken,
          sanityurl: FFAppConstants.sanityurl,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          final columnNotificationsListResponse = snapshot.data!;
          final notificationList = getJsonField(
            columnNotificationsListResponse.jsonBody,
            r'''$.data''',
          ).toList();

          // Check if the notification list is empty
          if (notificationList.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/empty_notification.png', // Path to your default image
                      //width: 200,
                      //height: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                  decoration: BoxDecoration(
                    color: Color(0xFFE7E7E8),
                    border: Border.all(
                      color: Color(0xFFE7E7E8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 11, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(notificationList.length,
                            (notificationListIndex) {
                          final notificationListItem = notificationList[notificationListIndex];
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                'OrderTracking',
                                queryParameters: {
                                  'orderId': serializeParam(
                                    getJsonField(notificationListItem,
                                        r'''$.order_id'''),
                                    ParamType.int,
                                  ),
                                  'productIndex': '0', // Using the first product
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  kTransitionInfoKey: TransitionInfo(
                                    hasTransition: true,
                                    transitionType: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 400),
                                  ),
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        getJsonField(
                                          notificationListItem,
                                          r'''$.logo''',
                                        ).toString(),
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width *
                                                0.8,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  getJsonField(
                                                    notificationListItem,
                                                    r'''$.title''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    letterSpacing: 0,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  calculateDateDisplay(
                                                    getJsonField(
                                                      notificationListItem,
                                                      r'''$.createdAt''',
                                                    ).toString(),
                                                  ),
                                                  style: FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFA0A0A0),
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width *
                                                0.6,
                                            decoration: BoxDecoration(),
                                            child: Text(
                                              getJsonField(
                                                notificationListItem,
                                                r'''$.message''',
                                              ).toString(),
                                              textAlign: TextAlign.justify,
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                letterSpacing: 0,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 4)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
