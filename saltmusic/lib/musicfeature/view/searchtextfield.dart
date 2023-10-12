import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class POTextField extends StatefulWidget {
  final String title;
  final String? errorText;
  final int? limitTextInput;
  final TextStyle? subTitleStyle;
  final String hintText;
  final VoidCallback? onTap;
  final bool? enabled;
  final bool? hasValidation;
  final bool? readOnly;
  final Color? fillColor;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String) onSaved;
  final Function(String)? onChanged;
  final Function(String)? validator;
  final Function()? onTapIcon;
  final String? icon;

  const POTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.onSaved,
    this.validator,
    this.keyboardType,
    this.hasValidation = true,
    this.icon,
    this.onChanged,
    this.controller,
    this.limitTextInput = 10,
    this.errorText,
    this.enabled = true,
    this.onTap,
    this.subTitleStyle,
    this.readOnly = false,
    this.fillColor,
    this.onTapIcon,
  });

  @override
  State<POTextField> createState() => _POTextFieldState();
}

class _POTextFieldState extends State<POTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          readOnly: widget.readOnly!,
          onTap: widget.onTap,
          enabled: widget.enabled,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.limitTextInput ?? 10),
          ],
          keyboardType: widget.keyboardType ?? TextInputType.number,
          controller: widget.controller,
          onSaved: (v) => widget.onSaved.call(v ?? ''),
          onChanged: (v) {
            widget.onChanged!(v);
          },
          validator: widget.hasValidation!
              ? (v) => v!.fieldvalidation(field: widget.title)
              : (v) => null,
          textAlign: TextAlign.start,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            suffixIcon: widget.icon != null
                ? InkWell(
                    onTap: widget.onTapIcon,
                    child:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  )
                : null,
            contentPadding: const EdgeInsets.only(top: 16, bottom: 16),
            prefix: const Padding(padding: EdgeInsets.only(left: 16.0)),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 0.7,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: .7,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: .7,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: .7,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: .7,
              ),
            ),
            fillColor: widget.fillColor,
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}

extension GetInitials on String {
  String? fieldvalidation({String? field}) {
    if (toString().length < 1) {
      return '$field field is required';
    } else {
      return null;
    }
  }
}
