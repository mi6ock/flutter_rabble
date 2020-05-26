library multiselect_formfield;

import 'package:flutter/material.dart';
import 'package:samples_rabble/multidrop_down_menu/multiselect_dialog.dart';

class MultiSelectFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function change;
  final Function open;
  final Function close;
  final Widget leading;
  final Widget trailing;
  final String okButtonLabel;
  final String cancelButtonLabel;

  MultiSelectFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      int initialValue,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = '選択してください',
      this.required = false,
      this.errorText = '',
      this.value,
      this.leading,
      this.dataSource,
      this.textField,
      this.valueField,
      this.change,
      this.open,
      this.close,
      this.okButtonLabel = 'OK',
      this.cancelButtonLabel = 'CANCEL',
      this.trailing})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<dynamic> state) {
            Widget _buildSelectedOptions(dynamic values, state) {
              List<String> words = [];
              if (values != null) {
                values.forEach((item) {
                  var existingItem = dataSource.singleWhere(
                      (itm) => itm[valueField] == item,
                      orElse: () => null);
                  words.add(existingItem[textField]);
                });
              }
              return Flexible(
                child: Text(
                  '${words.join(',')}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            }

            return InkWell(
              onTap: () async {
                List initialSelected = value;
                if (initialSelected == null) {
                  initialSelected = List();
                }

                final items = List<MultiSelectDialogItem<dynamic>>();
                dataSource.forEach((item) {
                  items.add(
                      MultiSelectDialogItem(item[valueField], item[textField]));
                });

                List selectedValues = await showDialog<List>(
                  context: state.context,
                  builder: (BuildContext context) {
                    return MultiSelectDialog(
                      title: titleText,
                      okButtonLabel: okButtonLabel,
                      cancelButtonLabel: cancelButtonLabel,
                      items: items,
                      initialSelectedValues: initialSelected,
                    );
                  },
                );

                if (selectedValues != null) {
                  state.didChange(selectedValues);
                  state.save();
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  errorText: state.hasError ? state.errorText : null,
                  errorMaxLines: 4,
                ),
                isEmpty: state.value == null || state.value == '',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    value != null && value.length > 0
                        ? _buildSelectedOptions(value, state)
                        : Container(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              hintText,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey.shade500,
                            size: 25.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
}
