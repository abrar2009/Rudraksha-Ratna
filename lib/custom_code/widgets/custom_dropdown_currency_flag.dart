import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class CustomDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  CustomDropdown({required this.items, this.initialValue, required this.onChanged});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedValue;
  String? _selectedImageUrl;
  List<Map<String, dynamic>> _filteredItems = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    _selectedImageUrl = widget.items
        .firstWhere((item) => item['currency_type'] == _selectedValue, orElse: () => {})['image'];
    _filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      _filteredItems = widget.items
          .where((item) => item['currency_type']
          .toLowerCase()
          .contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDropdownMenu(context),
      child: Container(
        width: 120,
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImageUrl != null)
              SizedBox(
                width: 24, // Adjust the width of the image
                height: 24, // Adjust the height of the image
                child: SvgPicture.network(
                  _selectedImageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            if (_selectedValue != null)
              Expanded(
                child: Text(
                  _selectedValue!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center, // Center the text
                ),
              )
            else
              Expanded(
                child: Text(
                  'Select',
                  textAlign: TextAlign.center,
                ),
              ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _openDropdownMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setModalState) {
            // Reset search controller and filtered items when closing the dropdown
            void _resetSearch() {
              _searchController.clear();
              setModalState(() {
                _filteredItems = widget.items;
              });
            }

            return GestureDetector(
              onTap: () => _resetSearch(), // Reset search when tapping outside
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search, color: FlutterFlowTheme.of(context).primary,),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      cursorColor: FlutterFlowTheme.of(context).primary,
                      onChanged: (value) {
                        setModalState(() {
                          _filterItems();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return ListTile(
                          leading: SizedBox(
                            width: 24, // Adjust the width of the image
                            height: 24, // Adjust the height of the image
                            child: SvgPicture.network(
                              item['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(item['currency_type']),
                          onTap: () {
                            setState(() {
                              _selectedValue = item['currency_type'];
                              _selectedImageUrl = item['image'];
                            });
                            widget.onChanged(_selectedValue!);
                            _resetSearch(); // Reset search when an item is selected
                            Navigator.pop(context); // Close dropdown
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
