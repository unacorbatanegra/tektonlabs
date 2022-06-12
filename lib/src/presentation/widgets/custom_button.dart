import 'widgets.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool outline;
  final double minSize;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.minSize = 48,
  })  : outline = false,
        super(key: key);

  const CustomButton.outline({
    Key? key,
    required this.onTap,
    required this.label,
    this.minSize = 52,
  })  : outline = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (outline) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          height: minSize,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(
              width: 1,
              color: Palette.gray2,
            ),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Palette.gray2,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onPressed: onTap,
      );
    }
    return CupertinoButton.filled(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      minSize: minSize,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onPressed: onTap,
    );
  }
}
