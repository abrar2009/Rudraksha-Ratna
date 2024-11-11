import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:rudraksha_cart/components/shimmer_widget.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_html/src/utils.dart';
import '../../flutter_flow/custom_functions.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
// //import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'article_detail_model.dart';
export 'article_detail_model.dart';

class ArticleDetailWidget extends StatefulWidget {
  const ArticleDetailWidget({
    super.key,
    required this.slugValue,
  });

  final String? slugValue;

  @override
  State<ArticleDetailWidget> createState() => _ArticleDetailWidgetState();
}

class _ArticleDetailWidgetState extends State<ArticleDetailWidget> {
  late ArticleDetailModel _model;
  bool _isCommentFormVisible = false;

  final ArticleDetailWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArticleDetailModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.nameController ??= TextEditingController();
    _model.nameFieldFocusNode ??= FocusNode();

    _model.emailController ??= TextEditingController();
    _model.emailFieldFocusNode ??= FocusNode();

    _model.commentController ??= TextEditingController();
    _model.commentFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: ArticleDetailWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                  context.pop();
                },
              ),
              title: Text(
                'Articles',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF272728),
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 0,
            ),
          ),
        ),
        body: SafeArea(
          top: true,
          child: FutureBuilder<ApiCallResponse>(
            future: BlogDetailsCall.call(
              slugUrl: widget.slugValue,
              sanityurl: FFAppConstants.sanityurl,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child:
                      SizedBox(width: 50, height: 50, child: ShimmerWidget()),
                );
              }
              final columnBlogDetailsResponse = snapshot.data!;

              // Get the list from the JSON data
              final blogsCommentList = getJsonField(
                columnBlogDetailsResponse.jsonBody,
                r'''$.data.blogs_comment''',
              ).toList();

              // Get the length of the list
              final blogsCommentCount = blogsCommentList.length;

              final blogId = getJsonField(
                      columnBlogDetailsResponse.jsonBody, r'''$.data.id''')
                  .toString();

              // Decode the JSON data if necessary
              final decodedDescription = utf8.decode(getJsonField(
                      columnBlogDetailsResponse.jsonBody,
                      r'''$.data.long_description''')
                  .toString()
                  .codeUnits);

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
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getJsonField(
                                columnBlogDetailsResponse.jsonBody,
                                r'''$.data.blog_title''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: /*Image.network(
                                  getJsonField(
                                    columnBlogDetailsResponse.jsonBody,
                                    r'''$.data.image''',
                                  ).toString(),
                                  width: double.infinity,
                                  height: 228,
                                  fit: BoxFit.cover,
                                ),*/
                                    CachedNetworkImage(
                                  fadeInDuration: Duration(milliseconds: 100),
                                  fadeOutDuration: Duration(milliseconds: 100),
                                  imageUrl: utf8.decode(
                                    (getJsonField(
                                      columnBlogDetailsResponse.jsonBody,
                                      r'''$.data.image''',
                                    ).toString())
                                        .codeUnits
                                        .toList(),
                                    allowMalformed: true,
                                  ),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.25,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) =>
                                      ShimmerWidget(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isCommentFormVisible =
                                            !_isCommentFormVisible;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            'assets/images/Chat.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  6, 0, 16, 0),
                                          child: Text(
                                            '${blogsCommentCount.toString()} Comments',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      'assets/images/Time_Circle.png',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        6, 0, 16, 0),
                                    child: Text(
                                      '${getJsonField(
                                        columnBlogDetailsResponse.jsonBody,
                                        r'''$.data.readtime''',
                                      ).toString()} Read',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_isCommentFormVisible)
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16, right: 0, left: 0, bottom: 8),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 300),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: blogsCommentList.isEmpty
                                          ? [
                                              Container(
                                                height: 100,
                                                padding: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Color(0x47FBDCEF),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Be the first one to comment",
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors
                                                              .black, // Text color
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : blogsCommentList
                                              .map<Widget>((comment) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                padding: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF7F7F7),
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      getJsonField(comment,
                                                              r'''$.comment''')
                                                          .toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xFF575758),
                                                          ),
                                                    ),
                                                    SizedBox(height: 30),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          getJsonField(comment,
                                                                  r'''$.name''')
                                                              .toString(),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xFF313131),
                                                              ),
                                                        ),
                                                        Text(
                                                          calculateDateDisplay(
                                                            getJsonField(
                                                                    comment,
                                                                    r'''$.createdAt''')
                                                                .toString(),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color(
                                                                    0xFF808080),
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            if (_isCommentFormVisible)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: _model.nameController,
                                      focusNode: _model.nameFieldFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: 'Enter your full name',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF868687),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 6.0, 0.0, 6.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                          ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                      autofillHints: const [
                                        AutofillHints.oneTimeCode
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      controller: _model.emailController,
                                      focusNode: _model.emailFieldFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: 'Enter your email',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF868687),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 6.0, 0.0, 6.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                          ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                      autofillHints: const [
                                        AutofillHints.oneTimeCode
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      controller: _model.commentController,
                                      focusNode: _model.commentFieldFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      minLines: 1, // Minimum number of lines
                                      maxLines:
                                          null, // Allows the text field to grow as needed
                                      decoration: InputDecoration(
                                        labelText: 'Comment',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: 'Enter your comment',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                            ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF868687),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 6.0, 0.0, 6.0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                          ),
                                      keyboardType: TextInputType.multiline,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                      autofillHints: const [
                                        AutofillHints.oneTimeCode
                                      ],
                                      onChanged: (text) {
                                        // Call setState to rebuild the widget and adjust its height
                                        setState(() {});
                                      },
                                      textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(height: 16),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        // Validate fields
                                        if (_model
                                                .nameController.text.isEmpty ||
                                            _model
                                                .emailController.text.isEmpty ||
                                            _model.commentController.text
                                                .isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Please fill in all fields',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          );
                                          return;
                                        }

                                        // Validate name format (only alphabetic characters)
                                        RegExp nameRegExp =
                                            RegExp(r'^[a-zA-Z\s]+$');
                                        if (!nameRegExp.hasMatch(
                                            _model.nameController.text)) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Name should contain only alphabetic characters',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          );
                                          return;
                                        }

                                        // Validate email format
                                        RegExp emailRegExp = RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                        if (!emailRegExp.hasMatch(
                                            _model.emailController.text)) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Invalid email format',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          );
                                          return;
                                        }

                                        final requestBody = {
                                          'blogId': blogId,
                                          'name': _model.nameController.text,
                                          'email': _model.emailController.text,
                                          'comment':
                                              _model.commentController.text,
                                        };

                                        print(
                                            'Request Body: ${jsonEncode(requestBody)}');

                                        _model.apiResultjp10 =
                                            await BlogCommentsCall.call(
                                          hosturl: FFAppConstants.hosturl,
                                          blogId: blogId,
                                          name: _model.nameController.text,
                                          email: _model.emailController.text,
                                          comment:
                                              _model.commentController.text,
                                        );

                                        _isCommentFormVisible = true;

                                        if ((_model.apiResultjp10?.succeeded ??
                                            true)) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                  (_model.apiResultjp10
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.msg''',
                                                ).toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                          );
                                          FFAppState().statusFailed =
                                              getJsonField(
                                            (_model.apiResultjp10?.jsonBody ??
                                                ''),
                                            r'''$.status''',
                                          ).toString();
                                          if (FFAppState().statusFailed ==
                                              'success') {
                                            _model.nameController!.clear();
                                            _model.emailController!.clear();
                                            _model.commentController!.clear();
                                          }
                                        }
                                      },
                                      text: 'Submit',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 48,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24, 0, 24, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 16),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(),
                                  child: HtmlWidget(decodedDescription)
                                  // Html(
                                  //   data: decodedDescription,
                                  //   style: {
                                  //     "html": Style(
                                  //       fontFamily: GoogleFonts.montserrat(
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.w400,
                                  //         color: Color(0xFF212529),
                                  //       ).fontFamily,
                                  //       color: Color(0xFF212529),
                                  //       lineHeight: LineHeight(1.5),

                                  //       textAlign: TextAlign.justify,
                                  //     ),
                                  //     "body": Style(
                                  //       margin: EdgeInsets.zero,
                                  //       padding: EdgeInsets.zero,
                                  //     ),
                                  //     "p": Style(
                                  //       margin: EdgeInsets.zero,
                                  //       //padding: EdgeInsets.zero,
                                  //       padding: EdgeInsets.all(0)
                                  //     ),
                                  //     "div": Style(
                                  //       margin: EdgeInsets.zero,
                                  //       padding: EdgeInsets.zero,
                                  //     ),
                                  //     "a": Style(
                                  //       color: FlutterFlowTheme.of(context).primary,
                                  //       padding: EdgeInsets.zero,
                                  //       margin: EdgeInsets.zero,
                                  //     ),
                                  //     "img": Style(
                                  //       margin: EdgeInsets.zero,
                                  //       padding: EdgeInsets.only(bottom: 0, top: 10, left: 0),
                                  //       height: MediaQuery.of(context).size.height * 0.3,
                                  //       width: MediaQuery.of(context).size.height * 0.41,
                                  //       alignment: Alignment.center,
                                  //       textOverflow: TextOverflow.visible,
                                  //       //border: Border.all(width: 0)
                                  //     ),
                                  //     "h1": Style(
                                  //       margin: EdgeInsets.zero,
                                  //       padding: EdgeInsets.zero,
                                  //     ),
                                  //     "h2": Style(
                                  //       margin: EdgeInsets.only(bottom: 0, top: 12, left: 0), // Adjust bottom margin as needed
                                  //       padding: EdgeInsets.zero,
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //     "h3": Style(
                                  //       margin: EdgeInsets.only(bottom: 4, top: 12, left: 0), // Adjust bottom margin as needed
                                  //       padding: EdgeInsets.zero,
                                  //       textAlign: TextAlign.justify,
                                  //     ),
                                  //     "h4": Style(
                                  //       margin: EdgeInsets.only(bottom: 10, top: 12, left: 0), // Adjust bottom margin as needed
                                  //       padding: EdgeInsets.zero,
                                  //     ),
                                  //     "figure": Style(
                                  //       margin: EdgeInsets.zero, // Remove margins for figure elements
                                  //       padding: EdgeInsets.zero, // Remove padding for figure elements
                                  //     ),
                                  //   },
                                  //   customRenders: {
                                  //     iframeMatcher(): CustomRender.widget(
                                  //       widget: (context, buildChildren) {
                                  //         final attributes = context.tree.element?.attributes;
                                  //         if (attributes != null && attributes['src'] != null) {
                                  //           final videoUrl = attributes['src']!;
                                  //           final videoId = extractYouTubeVideoId(videoUrl);
                                  //           print('Video URL: $videoUrl');
                                  //           print('Extracted Video ID: $videoId');
                                  //           if (videoId != null) {
                                  //             final thumbnailUrl = getYouTubeThumbnailUrl(videoId);
                                  //             return GestureDetector(
                                  //               onTap: () async {
                                  //                 final uri = Uri.parse(videoUrl);
                                  //                 if (await canLaunchUrl(uri)) {
                                  //                   await launchUrl(uri, mode: LaunchMode.externalApplication);
                                  //                 } else {
                                  //                   print('Could not launch $uri');
                                  //                 }
                                  //               },
                                  //               child: Stack(
                                  //                 alignment: Alignment.center,
                                  //                 children: [
                                  //                   Image.network(
                                  //                     thumbnailUrl,
                                  //                     fit: BoxFit.none,
                                  //                     //width: double.infinity,
                                  //                     //height: 250,
                                  //                   ),
                                  //                   Positioned(
                                  //                     child: Image.network(
                                  //                       getYouTubeLogoUrl(),
                                  //                       width: 80,
                                  //                       height: 80,
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             );
                                  //           }
                                  //         }
                                  //         return Container();
                                  //       },
                                  //     ),
                                  //   },
                                  //   onLinkTap: (url, _, __, ___) async {
                                  //     if (url != null) {
                                  //       final uri = Uri.parse(url);

                                  //       if (await canLaunchUrl(uri)) {
                                  //         await launchUrl(uri, mode: LaunchMode.externalApplication);
                                  //       } else {
                                  //         print('Could not launch $uri');
                                  //       }
                                  //     }
                                  //   },
                                  // ),

                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Define iframeMatcher function
  bool Function(dynamic context) iframeMatcher() => (context) {
        final element = context.tree.element;
        return element?.localName == "iframe";
      };

  // Function to extract YouTube video ID from the URL
  String? extractYouTubeVideoId(String url) {
    try {
      final uri = Uri.parse(url);
      if (uri.host.contains('youtube.com')) {
        if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'embed') {
          return uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
        } else {
          final queryParams = uri.queryParameters;
          return queryParams['v'];
        }
      } else if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      }
    } catch (e) {
      print('Error extracting video ID: $e');
    }
    return null;
  }

  // Function to construct YouTube thumbnail URL
  String getYouTubeThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  // Function to construct the URL of the YouTube logo overlay
  String getYouTubeLogoUrl() {
    return 'https://upload.wikimedia.org/wikipedia/commons/4/42/YouTube_icon_%282013-2017%29.png'; // Alternative YouTube logo URL
  }
}
