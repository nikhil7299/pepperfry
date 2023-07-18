import 'package:fpdart/fpdart.dart';
import 'package:pepperfry/core/failure.dart';

typedef UserId = String;
typedef Email = String;
typedef Phone = String;
typedef Name = String;

typedef FutureEither<T> = Future<Either<T, Failure>>;
