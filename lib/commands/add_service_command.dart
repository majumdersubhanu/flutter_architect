// lib/commands/add_service_command.dart
import 'dart:io';

import 'package:recase/recase.dart';

class AddServiceCommand {
  Future<void> run(String name) async {
    final snake = ReCase(name).snakeCase;
    final pascal = ReCase(name).pascalCase;

    File('lib/data/services/${snake}_service.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync('''
class ${pascal}Service {
  // TODO: Implement $pascal service methods
}''');

    print('Service "$name" created.');
  }
}
