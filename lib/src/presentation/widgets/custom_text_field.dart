import 'widgets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.label,
    this.validator,
    this.readOnly = false,
    this.onChanged,
    this.keyboardType,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.icon,
    this.obscureText = false,
    this.prefixText,
    this.autofocus = false,
    this.enableSugestions = true,
    this.suffixText,
    this.textInputAction,
    this.autofillHints,
    this.onFieldSubmitted,
    this.suffix,
    this.hint,
  }) : super(key: key);
  final String? hint;
  final Widget? suffix;
  final bool autofocus;
  final bool enableSugestions;
  final TextInputAction? textInputAction;

  final String? prefixText;
  final String? suffixText;
  final TextEditingController controller;

  final String? label;
  final int maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? keyboardType;

  final Iterable<String>? autofillHints;
  final String? Function(String? value)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final Widget? icon;

  static final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.0),
    borderSide: BorderSide.none,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
                color: Palette.gray2, fontWeight: FontWeight.w600
                // fontFamily: 'Lato',
                ),
          ),
        if (label != null) gap2,
        TextFormField(
          onTap: onTap,
          maxLength: maxLength,
          controller: controller,
          validator: validator,
          autofocus: autofocus,
          enableSuggestions: enableSugestions,
          textInputAction: textInputAction,
          readOnly: readOnly,
          maxLines: maxLines,
          onChanged: onChanged,
          // cursorHeight: 23,
          autofillHints: autofillHints,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          onFieldSubmitted: onFieldSubmitted,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          // scrollPadding: zero,
          decoration: InputDecoration(
            // contentPadding: zero,
            counter: const SizedBox.shrink(),
            enabledBorder: _border,
            errorBorder: _border,
            disabledBorder: _border,
            focusedErrorBorder: _border,
            border: _border,
            prefixText: prefixText,
            alignLabelWithHint: true,
            focusedBorder: _border,
            // contentPadding: const EdgeInsets.symmetric(
            //   horizontal: 16.0,
            //   vertical: 24.0,
            // ),
            suffixIcon: suffix,
            hintText: hint,
            // suffix: suffix,
            suffixText: suffixText, isCollapsed: false,
            hintStyle: const TextStyle(
              color: Palette.gray3,
              // fontFamily: 'Lato',
            ),
          ),
        ),
      ],
    );
  }
}
