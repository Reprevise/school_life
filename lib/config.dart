import 'package:injectable/injectable.dart';
import 'package:school_life/config.iconfig.dart';
import 'package:school_life/main.dart';

@injectableInit
void configure() => $initGetIt(sl);
