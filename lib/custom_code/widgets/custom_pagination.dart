/*
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class CustomPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const CustomPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  // Helper to determine the page range for the pagination buttons
  List<int> _getPageRange() {
    int startPage = (currentPage - 1) ~/ 4 * 4 + 1;
    int endPage = (startPage + 3).clamp(1, totalPages);

    if (endPage - startPage < 3) {
      startPage = (endPage - 3).clamp(1, totalPages - 3);
      endPage = (startPage + 3).clamp(1, totalPages);
    }

    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  Widget _buildPageButton(int page, BuildContext context) {
    bool isActive = page == currentPage;
    return GestureDetector(
      onTap: () => onPageChanged(page),
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isActive ? FlutterFlowTheme.of(context).primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primary,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Text(
            page.toString(),
            style: TextStyle(
              color: isActive ? Colors.white : FlutterFlowTheme.of(context).primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> pageRange = _getPageRange();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (currentPage > 1) {
              onPageChanged(currentPage - 1);
            }
          },
          child: Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
                width: 2.0,
              ),
            ),
            child: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
        if (pageRange.first > 1) ...[
          //_buildPageButton(1),
          if (pageRange.first > 2) ...[
            //Text('...'),
          ],
        ],
        for (int page in pageRange) _buildPageButton(page, context),
        if (pageRange.last < totalPages) ...[
          if (pageRange.last < totalPages - 1) ...[
           // Text('...'),
          ],
          //_buildPageButton(totalPages),
        ],
        GestureDetector(
          onTap: () {
            if (currentPage < totalPages) {
              onPageChanged(currentPage + 1);
            }
          },
          child: Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
                width: 2.0,
              ),
            ),
            child: Icon(
              Icons.chevron_right,
              color: FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
      ],
    );
  }
}
*/

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class CustomPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;

  const CustomPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  // Helper to determine the page range for the pagination buttons
  List<int> _getPageRange() {
    int startPage = (currentPage - 1) ~/ 4 * 4 + 1;
    int endPage = (startPage + 3).clamp(1, totalPages);

    if (endPage - startPage < 3) {
      startPage = (endPage - 3).clamp(1, totalPages - 3);
      endPage = (startPage + 3).clamp(1, totalPages);
    }

    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  Widget _buildPageButton(int page, BuildContext context) {
    bool isActive = page == currentPage;
    return GestureDetector(
      onTap: () => onPageChanged(page),
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isActive ? FlutterFlowTheme.of(context).primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primary,
            width: 2.0,
          ),
        ),
        child: Center(
          child: Text(
            page.toString(),
            style: TextStyle(
              color: isActive ? Colors.white : FlutterFlowTheme.of(context).primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> pageRange = _getPageRange();
    bool isFirstPageActive = currentPage == 1;
    bool isLastPageActive = currentPage == totalPages;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (!isFirstPageActive) {
              onPageChanged(currentPage - 1);
            }
          },
          child: Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              //color: isFirstPageActive ? Color(0xFFBCBCBC) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: isFirstPageActive ? Color(0xFFBCBCBC) : FlutterFlowTheme.of(context).primary,
                width: 2.0,
              ),
            ),
            child: Icon(
              Icons.chevron_left,
              color: isFirstPageActive ? Color(0xFFBCBCBC) : FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
        if (pageRange.first > 1) ...[
          //_buildPageButton(1),
          if (pageRange.first > 2) ...[
            //Text('...'),
          ],
        ],
        for (int page in pageRange) _buildPageButton(page, context),
        if (pageRange.last < totalPages) ...[
          if (pageRange.last < totalPages - 1) ...[
            // Text('...'),
          ],
          //_buildPageButton(totalPages),
        ],
        GestureDetector(
          onTap: () {
            if (!isLastPageActive) {
              onPageChanged(currentPage + 1);
            }
          },
          child: Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              //color: isLastPageActive ? Color(0xFFBCBCBC) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: isLastPageActive ? Color(0xFFBCBCBC) : FlutterFlowTheme.of(context).primary,
                width: 2.0,
              ),
            ),
            child: Icon(
              Icons.chevron_right,
              color: isLastPageActive ? Color(0xFFBCBCBC) : FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
      ],
    );
  }
}
