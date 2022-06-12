import 'widgets.dart';

class SearchWidget extends StatelessWidget {
  final int length;
  final bool isSearching;
  final VoidCallback toSearch;
  final VoidCallback onFilter;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchWidget({
    Key? key,
    required this.length,
    required this.isSearching,
    required this.toSearch,
    required this.onFilter,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'All ${length > 0 ? "($length)" : ""}',
                style: context.h5,
              ),
            ),
            CupertinoButton(
              child: isSearching
                  ? const Icon(Majes.close_line)
                  : const Icon(Majes.search_line),
              onPressed: toSearch,
            ),
            CupertinoButton(
              child: const Icon(Majes.filter_line),
              onPressed: onFilter,
            )
          ],
        ),
        if (isSearching) gap16,
        if (isSearching)
          CupertinoSearchTextField(
            onChanged: onChanged,
            controller:controller,
            onSubmitted: onChanged,
          ),
        if (isSearching) gap16,
      ],
    );
  }
}
