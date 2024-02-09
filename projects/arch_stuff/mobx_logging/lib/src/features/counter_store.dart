// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: unused_field

import 'dart:developer';

import 'package:mobx/mobx.dart';

// Include generated file
part 'counter_store.g.dart';

// This is the class used by rest of your codebase
class Counter = CounterBase with _$Counter;

// The store-class
abstract class CounterBase with Store {
  @observable
  int value = 0;

  late ReactionDisposer _dispose;

  void setupReactions() {
    _dispose = when((_) => value >= 10, () {
      log("Count has reached the limit of 10");
    });
  }

  @action
  void increment() {
    value++;
  }
}
