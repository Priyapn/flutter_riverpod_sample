import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/providers.dart';

class SampleScreen extends ConsumerWidget {
  final rand = Random(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(helloProvider).toString();
    print("building whole");
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Center(child: Text(text)),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("---------------------"),
              ),
            ),
            Consumer(
              builder: (context, ref2, child) {
                print("build only consumer");
                final count = ref2.watch(counterProvider);
                final bulbIsOn = ref2.watch(
                  bulbProvider.select((bulb) => bulb.isOn),
                );
                return Center(child: Text("count $count isBulbOn $bulbIsOn"));
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).state = rand.nextInt(1000);
                },
                child: Text("Change count"),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("---------------------"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      print("build only on/off");
                      final isOn = ref.watch(
                        bulbProvider.select((bulb) => bulb.isOn),
                      );
                      return Switch(
                        value: isOn,
                        onChanged: (value) {
                          final bulb = ref.read(bulbProvider.notifier);
                          bulb.state = bulb.state.copyWith(isOn: value);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      print("build only brightness change");
                      final brightness = ref.watch(
                        bulbProvider.select(
                              (bulb) => bulb.brightnessPercentage,
                        ),
                      );
                      return Slider(
                        value: brightness / 100,
                        onChanged: (value) {
                          final bulb = ref.read(bulbProvider.notifier);
                          bulb.state = bulb.state.copyWith(
                            brightnessPercentage: value * 100,
                          );
                        },
                      );
                    },
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    print("build on bulb property change");
                    final bulb = ref.watch(bulbProvider);
                    return Center(
                      child: Text(
                        "Bulb is ${bulb.isOn ? "on and the brightness is ${bulb.brightnessPercentage}%" : "off"}.",
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
