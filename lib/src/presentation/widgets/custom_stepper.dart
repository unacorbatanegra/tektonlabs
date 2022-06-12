import 'widgets.dart';

class CustomStepper extends StatelessWidget {
  final int length;
  final int current;
  final ValueChanged<int> onTap;
  const CustomStepper({
    Key? key,
    required this.length,
    required this.current,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(
          length,
          (index) => _Step(
            index: index + 1,
            onTap: () {
              if (index + 1 < current) onTap(index + 1);
            },
            current: current,
          ),
        ),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  final int current;
  final int index;
  final VoidCallback onTap;
  const _Step({
    Key? key,
    required this.current,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    if (current > index) {
      // color = const Color(0xffedbc2c);
      color = Palette.primary;
    } else if (current == index) {
      // color = const Color(0xfff0f0f0);
      // color = Palette.primary;
      color = const Color(0xffedbc2c);
    } else {
      color = Palette.gray3;
    }
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 500,
        ),
        curve: Curves.easeIn,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
          ),
        ),
      ),
    );
  }
}
