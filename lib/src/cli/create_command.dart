import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class CreateCommand extends Command<int> {
  CreateCommand() {
    argParser
      ..addOption(
        'name',
        abbr: 'n',
        help: 'The name of the Flutter project.',
        mandatory: true,
      )
      ..addOption(
        'platforms',
        abbr: 'p',
        help: 'Comma-separated list of platforms (e.g., android,ios,web).',
        defaultsTo: 'android,ios',
      )
      ..addOption(
        'path',
        help: 'The directory where the project will be created. Defaults to the current working directory.',
        defaultsTo: _getWorkingDirectory(),
      );
  }

  @override
  String get description => 'Create a new Flutter project with custom setup.';

  @override
  String get name => 'create';

  @override
  Future<int> run() async {
    final name = argResults?['name'] as String;
    final platforms = (argResults?['platforms'] as String).split(',');
    final outputPath = argResults?['path'] as String;

    // Validate project name
    if (name.isEmpty || !RegExp(r'^[a-z_][a-z0-9_]*$').hasMatch(name)) {
      print('Invalid project name: "$name". Must be a valid Dart package name.');
      return 1;
    }

    // Validate platforms
    final validPlatforms = ['android', 'ios', 'web', 'macos', 'windows', 'linux'];
    for (final platform in platforms) {
      if (!validPlatforms.contains(platform)) {
        print('Invalid platform: "$platform". Valid platforms are: $validPlatforms');
        return 1;
      }
    }

    // Create Flutter project
    print('Creating Flutter project "$name" for platforms: ${platforms.join(',')} at $outputPath');
    final projectDir = Directory(path.join(outputPath, name));
    if (projectDir.existsSync()) {
      print('Directory "${projectDir.path}" already exists. Please choose a different name or path.');
      return 1;
    }

    final process = await Process.run(
      'flutter',
      ['create', '--platforms', platforms.join(','), '--project-name', name, name],
      workingDirectory: outputPath,
    );

    if (process.exitCode != 0) {
      print('Failed to create Flutter project: ${process.stderr}');
      return process.exitCode;
    }

    // Update pubspec.yaml
    final pubspecFile = File(path.join(projectDir.path, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) {
      print('pubspec.yaml not found in ${projectDir.path}');
      return 1;
    }

    final pubspecContent = pubspecFile.readAsStringSync();
    final pubspecYaml = loadYaml(pubspecContent);
    final yamlEditor = YamlEditor(pubspecContent);

    final dependencies = <String, String>{
      'bloc': '^9.0.0',
      'flutter_bloc': '^9.1.1',
      'hydrated_bloc': '^10.0.0',
      'equatable': '^2.0.5',
      'firebase_core': '^3.13.0',
      'firebase_crashlytics': '^4.3.5',
      'firebase_analytics': '^11.4.5',
      'json_annotation': '^4.9.0',
      'loader_overlay': '^5.0.0',
      'easy_logger': '^0.0.2',
      'shared_preferences': '^2.5.3',
      'package_info_plus': '^8.3.0',
      'dio': '^5.8.0+1',
      'easy_localization': '^3.0.7+1',
      'path_provider': '^2.1.5',
      'flutter_svg': '^2.1.0',
      'carousel_slider': '^5.0.0',
      'http': '^1.4.0',
      'flutter_dotenv': '^5.2.1',
      'provider': '^6.1.5',
      'url_launcher': '^6.3.1',
      'flutter_animate': '^4.5.2',
      'calendar_date_picker2': '^2.0.0',
      'smooth_page_indicator': '^1.2.1',
    };

    // Update dependencies in pubspec.yaml
    for (final entry in dependencies.entries) {
      yamlEditor.update(['dependencies', entry.key], entry.value);
    }

    pubspecFile.writeAsStringSync(yamlEditor.toString());
    print('Updated pubspec.yaml with dependencies: ${dependencies.keys.join(', ')}');

    // Run flutter pub get
    final pubGetProcess = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: projectDir.path,
    );

    if (pubGetProcess.exitCode != 0) {
      print('Failed to run "flutter pub get": ${pubGetProcess.stderr}');
      return pubGetProcess.exitCode;
    }
    print('Ran "flutter pub get" successfully');

    // Generate custom files using Mason
    final pubCacheDir = _getPubCacheDir();
    // final brickYamlFile = File(path.join(pubCacheDir, 'global_packages', 'tetrix_cli', 'lib', 'templates', 'brick.yaml'));
    // if (!brickYamlFile.existsSync()) {
    //   print('brick.yaml not found at ${brickYamlFile.path}');
    //   return 1;
    // }
    //
    // final generator = await MasonGenerator.fromBrickYaml(brickYamlFile);

    final generator = await MasonGenerator.fromBrick(
      Brick.path(path.join(path.dirname(Platform.script.path), '..', 'lib', 'templates')),
    );
    final target = DirectoryGeneratorTarget(projectDir);
    final files = await generator.generate(target, vars: {'name': name});
    print('Generated files: ${files.map((f) => f.path).join(', ')}');

    print('Flutter project "$name" created successfully at ${projectDir.path}!');
    return 0;
  }

  String _getWorkingDirectory() {
    // Use PWD environment variable if available (common on Unix-like systems)
    final pwd = Platform.environment['PWD'];
    if (pwd != null && pwd.isNotEmpty) {
      return pwd;
    }
    // Fallback to Directory.current.path
    return Directory.current.path;
  }

  String _getPubCacheDir() {
    final envPubCache = Platform.environment['PUB_CACHE'];
    if (envPubCache != null && envPubCache.isNotEmpty) {
      return envPubCache;
    }
    if (Platform.isWindows) {
      return path.join(Platform.environment['USERPROFILE']!, '.pub-cache');
    }
    return path.join(Platform.environment['HOME']!, '.pub-cache');
  }
}
