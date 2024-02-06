// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_basics/src/features/counter_store.dart';
import 'package:mobx_basics/src/my_app.dart';
import 'package:provider/provider.dart';

void main() {
  mainContext.config = mainContext.config.clone(
    isSpyEnabled: true,
  );

  mainContext.spy(print);

  runApp(MultiProvider(
    providers: [
      Provider<Counter>(create: (_) => Counter()),
    ],
    child: const MyApp(),
  ));
}
