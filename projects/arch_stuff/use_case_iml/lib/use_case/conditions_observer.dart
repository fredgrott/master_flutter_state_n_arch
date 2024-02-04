// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:use_case_iml/use_case/conditions_result.dart';

/// A mixin that allows to check preconditions and postconditions
/// of a use case.
mixin ConditionsObserver<Input, Output> {
  
  /// Check conditions required for the case to apply
  ///
  /// By default, it returns true.
  FutureOr<ConditionsResult> checkPreconditions(Input? params) => ConditionsResult(isValid: true);


  /// Check consequences of successful system application
  /// of the use case
  ///
  /// By default, it returns true.
  FutureOr<ConditionsResult> checkPostconditions(Output? result) => ConditionsResult(isValid: true);
}
