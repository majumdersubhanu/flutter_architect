// lib/commands/create_command.dart
import 'dart:io';

class CreateCommand {
  Future<void> run() async {
    const folders = [
      'lib/ui/core/ui',
      'lib/ui/core/themes',
      'lib/domain/models',
      'lib/data/repositories',
      'lib/data/services',
      'lib/data/model',
      'lib/config',
      'lib/utils',
      'lib/routing',
    ];

    for (final path in folders) {
      Directory(path).createSync(recursive: true);
    }

    final mains = ['main.dart', 'main_staging.dart', 'main_development.dart'];

    for (final file in mains) {
      File('lib/$file').createSync();
    }

    print('Project structure created successfully.');
  }
}

// TODO Implement this library.
