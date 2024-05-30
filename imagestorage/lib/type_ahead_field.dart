import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadFieldBuilder {
  final List<String> locations;

  TypeAheadFieldBuilder({required this.locations});

  Widget buildTypeAheadFormField({
    required TextEditingController controller,
    required String hintText,
    required Color iconColor,
  }) {
    return TypeAheadFormField<String>(
      textFieldConfiguration: _buildTextFieldConfiguration(controller, hintText, iconColor),
      suggestionsCallback: (pattern) {
        return _buildSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return _buildItemBuilder(context, suggestion);
      },
      onSuggestionSelected: (String? suggestion) {
        if (suggestion != null) {
          controller.text = suggestion;
        }
      },
    );
  }

  TextFieldConfiguration _buildTextFieldConfiguration(TextEditingController controller, String hintText, Color iconColor) {
    return TextFieldConfiguration(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffixIcon: Icon(
          Icons.place,
          color: iconColor,
        ),
      ),
    );
  }

  Iterable<String> _buildSuggestions(String pattern) {
    return locations.where((location) =>
        location.toLowerCase().startsWith(pattern.toLowerCase()));
  }

  Widget _buildItemBuilder(BuildContext context, String suggestion) {
    return ListTile(
      title: Text(suggestion),
    );
  }
}
