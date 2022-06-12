import '../../../widgets/widgets.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
                image: AssetImage(
              'assets/images/icon.png',
            )),
            gap64,
            Center(child: CircularProgressIndicator.adaptive())
          ],
        ),
      ),
    );
  }
}
