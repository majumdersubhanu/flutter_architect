// lib/commands/add_repo_command.dart
import 'dart:io';

import 'package:recase/recase.dart';

class AddRepoCommand {
  Future<void> run(String name) async {
    final snake = ReCase(name).snakeCase;
    final pascal = ReCase(name).pascalCase;

    File('lib/data/repositories/${snake}_repository.dart')
      ..createSync(recursive: true)
      ..writeAsStringSync('''
abstract class I${pascal}Repository {
  // TODO: Define abstract methods
}

class ${pascal}Repository implements I${pascal}Repository {
  // TODO: Implement repository methods
}''');

    print('Repository "$name" created.');
  }
}
