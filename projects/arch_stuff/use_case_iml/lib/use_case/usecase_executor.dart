// Copyright 2024 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:use_case_iml/use_case/conditions_observer.dart';
import 'package:use_case_iml/use_case/conditions_result.dart';
import 'package:use_case_iml/use_case/usecase_exception.dart';

mixin UsecaseExecutor<Input, Output> on ConditionsObserver<Input, Output> {
  
  /// Execute the use case with the given params and check preconditions and
  /// postconditions.
  Future<Output> executeWithConditions(
    Input? params, {
    required FutureOr<Output> Function() executor,
    required FutureOr<Output> Function(Object e) onException,
  }) async {
    ConditionsResult condition;

    try {
      condition = await checkPreconditions(params);
    } catch (e) {
      return onException(e);
    }

    try {
      if (condition.isValid) {
        final result = await executor();

        try {
          condition = await checkPostconditions(result);
        } catch (e) {
          return onException(e);
        }

        if (condition.isValid) {
          return result;
        } else {
          return onException(
            InvalidPostconditionsException(
              'Invalid postconditions: ${condition.message}',
            ),
          );
        }
      } else {
        return onException(
          InvalidPreconditionsException(
            'Invalid preconditions: ${condition.message}',
          ),
        );
      }
    } catch (e) {
      return onException(e);
    }
  }
}

mixin UsecaseStreamExecutor<Input, Output> on ConditionsObserver<Input, Output> {
  /// {@macro execute_with_conditions}
  Stream<Output> executeWithConditions(
    Input? params, {
    required Stream<Output> Function() executor,
    required FutureOr<Output> Function(Object e) onException,
  }) async* {
    ConditionsResult condition;

    try {
      condition = await checkPreconditions(params);
    } catch (e) {
      yield* Stream.fromFuture(
        Future.sync(() => onException(e)),
      );
      return;
    }

    if (condition.isValid) {
      // ignore: avoid_types_on_closure_parameters
      final stream = executor().handleError((Object e) {
        onException(e);
      });

      // Check postconditions
      await for (final result in stream) {
        try {
          condition = await checkPostconditions(result);
        } catch (e) {
          yield* Stream.fromFuture(
            Future.sync(() => onException(e)),
          );
          return;
        }

        if (!condition.isValid) {
          yield* Stream.fromFuture(
            Future.sync(
              () => onException(
                InvalidPostconditionsException(
                  'Invalid postconditions: ${condition.message}',
                ),
              ),
            ),
          );
          return;
        }

        yield result;
      }
    } else {
      yield* Stream.fromFuture(
        Future.sync(
          () => onException(
            InvalidPreconditionsException(
              'Invalid preconditions: ${condition.message}',
            ),
          ),
        ),
      );
      return;
    }
  }
}
