import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/providers.dart';

class FavScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FavScreenState();
}

class FavScreenState extends ConsumerState<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                ref.read(favouriteStateProvider.notifier).searchItem(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search Item",
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final favouriteState = ref.watch(favouriteStateProvider);
                  return favouriteState.filteredItemList.isEmpty
                      ? Center(child: Text("No Items Found"))
                      : ListView.builder(
                        itemCount: favouriteState.filteredItemList.length,
                        itemBuilder: (context, index) {
                          final item = favouriteState.filteredItemList[index];
                          return ListTile(
                            title: Text(item.name),
                            trailing: IconButton(
                              onPressed: () {
                                ref.read(favouriteStateProvider.notifier).toggleFavItem(item.id,!item.isFavourite);
                              },
                              icon:
                                  item.isFavourite
                                      ? Icon(Icons.favorite)
                                      : Icon(Icons.favorite_border_outlined),
                            ),
                          );
                        },
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
