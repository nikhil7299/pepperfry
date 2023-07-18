import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as devtools show log;

extension Log on Object? {
  void log() => devtools.log(toString());
}

/// Useful to log state change in our application
/// Read the logs and you'll better understand what's going on under the hood
class StateLogger extends ProviderObserver {
  const StateLogger();
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    ('''
* provider: ${provider.runtimeType},
  oldValue: $previousValue ,
  newValue: $newValue
''')
        .log();
  }
}
