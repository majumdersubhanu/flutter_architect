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

    File('.env').writeAsStringSync('API_URL=https://example.com\nENV=dev');

    final pubspecPath = File('pubspec.yaml');
    if (pubspecPath.existsSync()) {
      final pubspec = pubspecPath.readAsStringSync();
      if (!pubspec.contains('provider')) {
        print("\n🔧 You must manually add these dependencies to pubspec.yaml:");
        print("dependencies:");
        print("  provider:");
        print("  get_it:");
        print("  injectable:");
        print("  auto_route:");
        print("  flutter_dotenv:");
        print("  freezed_annotation:");
        print("dev_dependencies:");
        print("  build_runner:");
        print("  freezed:");
        print("  json_serializable:");
      }
    }

    print('\n✅ Base project structure created. Now run:');
    print(
      'flutter pub get && dart run build_runner build --delete-conflicting-outputs',
    );
  }
}
