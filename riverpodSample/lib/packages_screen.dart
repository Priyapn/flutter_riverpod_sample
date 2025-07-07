import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/providers.dart';

class PackagesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: ()=> ref.refresh(packageProvider.future),
          child: Center(
            child: Consumer(
              builder: (context, ref, child) {
                final futureProvider = ref.watch(packageProvider);
               return futureProvider.when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(title: Text(data[index]));
                      },
                    );
                  },
                  error:
                      (error, stacktrace) =>
                          TextButton(onPressed: () {}, child: Text(error.toString())),
                  loading: () => CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
