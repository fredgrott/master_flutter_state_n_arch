// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

class Failure implements Exception {
  Failure(this.message);

  final String message;

  @override
  String toString() => message;
}
