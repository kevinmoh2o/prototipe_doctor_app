import 'package:flutter/material.dart';

class SearchableDropdownField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final List<String> items;
  final String? Function(String?)? validator;

  const SearchableDropdownField({
    Key? key,
    required this.label,
    required this.controller,
    required this.items,
    this.validator,
  }) : super(key: key);

  @override
  State<SearchableDropdownField> createState() => _SearchableDropdownFieldState();
}

class _SearchableDropdownFieldState extends State<SearchableDropdownField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      validator: widget.validator,
      onTap: _openSearchDialog,
    );
  }

  Future<void> _openSearchDialog() async {
    final selectedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        List<String> filteredItems = List.from(widget.items);
        final searchController = TextEditingController();

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Text('Seleccionar ${widget.label}'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: 'Buscar...',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setStateDialog(() {
                          filteredItems = widget.items.where((item) => item.toLowerCase().contains(value.toLowerCase())).toList();
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              Navigator.pop(context, item);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (selectedValue != null) {
      setState(() {
        widget.controller.text = selectedValue;
      });
    }
  }
}
