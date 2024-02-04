// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:async';

Future<void> display<T>(FutureOr<T> Function() f) async {
  try {
    print(await f.call());
  } catch (e) {
    print(e);
  }
}
