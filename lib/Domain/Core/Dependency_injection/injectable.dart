import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:yt_dupe/Domain/Core/Dependency_injection/injectable.config.dart';

final getit = GetIt.instance;

@InjectableInit()
Future<void> configureInjectable() async {
  $initGetIt(getit, environment: Environment.prod);
}
