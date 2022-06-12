import '../../widgets/widgets.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Development'),
      ),
      body: const Center(
        child: Text('Page under development'),
      ),
    );
  }
}
