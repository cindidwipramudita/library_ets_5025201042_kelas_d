import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../db/library_database.dart';
import '../model/library_item.dart';
import '../pages/library_form_page.dart';
import '../pages/library_item_detail_page.dart';
import '../widget/library_item_card_widget.dart';

class LibraryListPage extends StatefulWidget {
  const LibraryListPage({Key? key}) : super(key: key);

  @override
  State<LibraryListPage> createState() => _LibraryListPageState();
}

class _LibraryListPageState extends State<LibraryListPage> {
  late List<LibraryItem> libraryItems;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshLibraryItems();
  }

  Future<void> refreshLibraryItems() async {
    setState(() => isLoading = true);
    libraryItems = await LibraryDatabase.instance.readAllItems();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Book List'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddLibraryItemPage(),
            ));
            refreshLibraryItems();
          },
        )
      ],
    ),
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : libraryItems.isEmpty
          ? const Text('No items')
          : buildLibraryItems(),
    ),

  );

  Widget buildLibraryItems() => StaggeredGridView.countBuilder(
    crossAxisCount: 2,
    itemCount: libraryItems.length,
    itemBuilder: (context, index) {
      final item = libraryItems[index];
      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                LibraryItemDetailPage(itemId: item.id!),
          ));
          refreshLibraryItems();
        },
        child: LibraryItemCardWidget(item: item),
      );
    },
    staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
  );

}
