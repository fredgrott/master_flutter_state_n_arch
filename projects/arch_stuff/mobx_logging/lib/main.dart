// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_logging/src/app_logging.dart';
import 'package:mobx_logging/src/features/counter_store.dart';
import 'package:mobx_logging/src/my_app.dart';

import 'package:provider/provider.dart';

void main() {
  // initialize logging
  AppLogging();
  mainContext.config = mainContext.config.clone(
    isSpyEnabled: true,
  );

  mainContext.spy((event) {
    
    appLogger.info("event name: ${event.name}");
    appLogger.info("event type:${event.type}");
  });

  runApp(MultiProvider(
    providers: [
      Provider<Counter>(create: (_) => Counter()),
    ],
    child: const MyApp(),
  ));
}
