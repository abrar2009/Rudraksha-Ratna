import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../components/shimmer_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'article_screen_model.dart';

class ArticlesScreenWidget extends StatefulWidget {
  const ArticlesScreenWidget({super.key});

  @override
  State<ArticlesScreenWidget> createState() => _ArticlesScreenWidgetState();
}

class _ArticlesScreenWidgetState extends State<ArticlesScreenWidget> {
  late ArticlesScreenModel _model;
  final ArticlesScreenWidgetscaffoldKey = GlobalKey<ScaffoldState>();

  int _currentPage = 1;
  int _totalPages = 1; // Default to 1, will be updated based on API response
  late Future<ApiCallResponse> _future;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArticlesScreenModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.textController?.addListener(_onSearchChanged); // Add listener for search bar

    _fetchData();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
    _scrollController.dispose();
  }

  void _onSearchChanged() {
    _currentPage = 1; // Reset to first page on new search
    _fetchData();
  }

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
    _fetchData(); // Fetch new data for the new page

    // Scroll to top
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(0); // Scroll to the top of the view
    });
  }

  void _fetchData() {
    setState(() {
      _future = BlogListCall.call(
        sanityurl: FFAppConstants.sanityurl,
        categoryId: '',
        searchblog: _model.textController.text, // Use search query
        p: _currentPage, // Update the page number
      ).then((response) {
        // Update total pages after fetching data
        final responseJson = response.jsonBody;
        final totalCount = getJsonField(responseJson, r'''$.count''') ?? 0;
        setState(() {
          _totalPages = (totalCount / 10).ceil();
        });
        return response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: ArticlesScreenWidgetscaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: 1,
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
                icon: const Icon(
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
                  color: FlutterFlowTheme.of(context).primaryText,
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
          child: Container(
            height: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 80),
                  child: FutureBuilder<ApiCallResponse>(
                    future: _future,
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
                      final columnBlogListResponse = snapshot.data!;
                      final responseJson = columnBlogListResponse.jsonBody;

                      // Check if the data is a list or map
                      final blogList = getJsonField(responseJson, r'''$.data''');
                      final blogListItems = blogList is List ? blogList : [];

                      if (blogListItems.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'No results found',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(blogListItems.length, (index) {
                                  final blogListItem = blogListItems[index];

                                  // Decode the JSON data if necessary
                                  final decodedDescription = utf8.decode(
                                      getJsonField(blogListItem, r'''$.small_description''').toString().codeUnits
                                  );

                                  final decodedTitle = utf8.decode(
                                      getJsonField(blogListItem, r'''$.blog_title''').toString().codeUnits
                                  );

                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: /*CachedNetworkImage(
                                              fadeInDuration: Duration(milliseconds: 100),
                                              fadeOutDuration: Duration(milliseconds: 100),
                                              imageUrl: getJsonField(blogListItem, r'''$.image''').toString(),
                                              width: double.infinity,
                                              height: MediaQuery.sizeOf(context).height * 0.25,
                                              fit: BoxFit.fill,
                                            ),*/
                                            CachedNetworkImage(
                                              fadeInDuration: Duration(milliseconds: 100),
                                              fadeOutDuration: Duration(milliseconds: 100),
                                              imageUrl: utf8.decode(
                                                (getJsonField(blogListItem, r'''$.image''').toString())
                                                    .codeUnits.toList(),
                                                allowMalformed: true,
                                              ),
                                              width: double.infinity,
                                              height: MediaQuery.sizeOf(context).height * 0.25,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) => ShimmerWidget(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                          ),
                                          child: HtmlWidget(
                                            decodedTitle,
                                           
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(),
                                          child: HtmlWidget(
                                             decodedDescription,
                                          
                                            
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              print('Slug value: ${getJsonField(blogListItem, r'''$.slug_url''').toString()}');
                                              context.pushNamed(
                                                'ArticleDetail',
                                                queryParameters: {
                                                  'slugValue': serializeParam(
                                                    getJsonField(blogListItem, r'''$.slug_url''').toString(),
                                                    ParamType.String,
                                                  ),
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
                                            child: Text(
                                              'Read More',
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: FlutterFlowTheme.of(context).primary,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _model.textController,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            obscureText: false,
                            decoration: InputDecoration(
                              //labelText: 'Search here...',
                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:  FlutterFlowTheme.of(context).secondaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              prefixIcon: Icon(
                                Icons.search,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 15,
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            validator: _model.textControllerValidator.asValidator(context),
                            focusNode: _model.textFieldFocusNode,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                        child: Container(
                          //width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(4),
                            shape: BoxShape.rectangle,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Back Arrow
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios, size: 24),
                                    onPressed: _currentPage > 1 ? () => _onPageChanged(_currentPage - 1) : null,
                                  ),
                                  // Pagination Buttons
                                  ...List.generate(_totalPages, (index) {
                                    final pageIndex = index + 1;
                                    return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                      child: ElevatedButton(
                                        onPressed: () => _onPageChanged(pageIndex),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: _currentPage == pageIndex
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context).primaryText,
                                          backgroundColor: _currentPage == pageIndex
                                              ? FlutterFlowTheme.of(context).primary
                                              : FlutterFlowTheme.of(context).secondaryBackground,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4), // Square corners
                                          ),
                                          padding: EdgeInsets.all(10),
                                          minimumSize: Size(40, 40), // Ensures square shape
                                        ),
                                        child: Text(
                                          '$pageIndex',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  // Next Arrow
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios, size: 24),
                                    onPressed: _currentPage < _totalPages ? () => _onPageChanged(_currentPage + 1) : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
