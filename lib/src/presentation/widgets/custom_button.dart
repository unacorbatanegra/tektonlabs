import 'widgets.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? iconData;
  final String label;

  final bool outline;
  final bool alt;
  final bool icon;
  final bool dialog;
  final bool filled;
  const CustomButton({
    Key? key,
    required this.onTap,
    this.iconData,
    required this.label,
  })  : outline = false,
        alt = false,
        icon = false,
        dialog = false,
        filled = false,
        super(key: key);

  const CustomButton.outline({
    Key? key,
    required this.onTap,
    this.iconData,
    required this.label,
  })  : outline = true,
        alt = false,
        icon = false,
        dialog = false,
        filled = false,
        super(key: key);

  const CustomButton.alt({
    Key? key,
    required this.onTap,
    this.iconData,
    required this.label,
  })  : outline = false,
        alt = true,
        icon = false,
        dialog = false,
        filled = false,
        super(key: key);

  const CustomButton.icon({
    Key? key,
    required this.onTap,
    required this.iconData,
    this.label = '',
  })  : outline = false,
        alt = false,
        icon = true,
        dialog = false,
        filled = false,
        super(key: key);

  const CustomButton.dialog({
    Key? key,
    required this.onTap,
    this.iconData,
    this.label = '',
  })  : outline = false,
        alt = false,
        icon = false,
        dialog = true,
        filled = false,
        super(key: key);

  const CustomButton.filled({
    Key? key,
    required this.onTap,
    this.iconData,
    this.label = '',
  })  : outline = false,
        alt = false,
        icon = false,
        dialog = false,
        filled = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon) {
      return CupertinoButton(
        padding: zero,
        child: Container(
          // height: 52,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Palette.culture,
          ),
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            iconData,
            size: 14.0,
            color: Palette.primary,
          ),
        ),
        onPressed: onTap,
      );
    }
    if (dialog) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Palette.primary,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }
    if (alt) {
      return GestureDetector(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Palette.culture,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  size: 16.0,
                  color: Palette.primary,
                ),
              if (iconData != null) gap6,
              Text(
                label,
                style: const TextStyle(
                  color: Palette.primary,
                  fontSize: 16,
                  // fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      );
    }
    if (filled) {
      return GestureDetector(
        // padding: EdgeInsets.zero,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Palette.primary,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  size: 16.0,
                  color: Colors.white,
                ),
              if (iconData != null) gap6,
              Flexible(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      );
    }
    if (outline) {
      return GestureDetector(
        // padding: EdgeInsets.zero,
        child: Container(
          constraints: const BoxConstraints(minWidth: 44.0, minHeight: 48.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(
              width: 1,
              color: Palette.gray2,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  size: 18.0,
                  color: Palette.gray1,
                ),
              if (iconData != null) gap8,
              Flexible(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Palette.gray1,
                    fontSize: 16,
                    // fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      );
    }

    return GestureDetector(
      onTap: onTap,
      // behavior: HitTestBehavior.opaque,
      child: Align(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Container(
          constraints: const BoxConstraints(minWidth: 44.0),
          decoration: const BoxDecoration(
            color: Palette.primary,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),

          padding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 64.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          // onPressed: onTap,
        ),
      ),
    );
  }
}
