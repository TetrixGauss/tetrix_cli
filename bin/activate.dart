import 'dart:io';

import 'package:path/path.dart' as path;

void main() async {
  final pubCacheDir = _getPubCacheDir();
  final projectDir = Directory.current.path;
  final platform = Platform.operatingSystem;

  // Ensure pub-cache/bin exists
  final binDir = Directory(path.join(pubCacheDir, 'bin'));
  if (!binDir.existsSync()) {
    binDir.createSync(recursive: true);
  }

  // Generate snapshot of tetrix_cli.dart
  final snapshotPath = path.join(pubCacheDir, 'global_packages', 'tetrix_cli', 'bin', 'tetrix_cli.dart.snapshot');
  final snapshotDir = Directory(path.dirname(snapshotPath));
  if (!snapshotDir.existsSync()) {
    snapshotDir.createSync(recursive: true);
  }
  final snapshotProcess = await Process.run(
    'dart',
    ['compile', 'jit-snapshot', '-o', snapshotPath, path.join(projectDir, 'bin', 'tetrix_cli.dart')],
    workingDirectory: projectDir,
  );
  if (snapshotProcess.exitCode != 0) {
    print('Failed to generate snapshot: ${snapshotProcess.stderr}');
    exit(1);
  }
  print('Generated snapshot at $snapshotPath');

  // Copy lib/templates/ to pub-cache
  final sourceTemplatesDir = Directory(path.join(projectDir, 'lib', 'templates'));
  final destTemplatesDir = Directory(path.join(pubCacheDir, 'global_packages', 'tetrix_cli', 'lib', 'templates'));
  if (!sourceTemplatesDir.existsSync()) {
    print('Error: lib/templates not found in $projectDir');
    exit(1);
  }
  if (destTemplatesDir.existsSync()) {
    destTemplatesDir.deleteSync(recursive: true);
  }
  await _copyDirectory(sourceTemplatesDir, destTemplatesDir);
  print('Copied lib/templates to ${destTemplatesDir.path}');

  if (platform == 'windows') {
    // Copy tetrix_cli.bat for Windows
    final sourceBat = File(path.join(projectDir, 'bin', 'tetrix_cli.bat'));
    final destBat = File(path.join(pubCacheDir, 'bin', 'tetrix_cli.bat'));
    if (!sourceBat.existsSync()) {
      print('Error: bin/tetrix_cli.bat not found in $projectDir');
      exit(1);
    }
    await sourceBat.copy(destBat.path);
    print('Copied tetrix_cli.bat to ${destBat.path}');
  } else {
    // Copy tetrix_cli for macOS/Linux
    final sourceSh = File(path.join(projectDir, 'bin', 'tetrix_cli'));
    final destSh = File(path.join(pubCacheDir, 'bin', 'tetrix_cli'));
    if (!sourceSh.existsSync()) {
      print('Error: bin/tetrix_cli not found in $projectDir');
      exit(1);
    }
    await sourceSh.copy(destSh.path);
    // Set executable permissions for macOS/Linux
    await Process.run('chmod', ['+x', destSh.path]);
    print('Copied tetrix_cli to ${destSh.path} and set executable permissions');
  }
}

Future<void> _copyDirectory(Directory source, Directory destination) async {
  await destination.create(recursive: true);
  await for (final entity in source.list(recursive: false)) {
    final newPath = path.join(destination.path, path.basename(entity.path));
    if (entity is File) {
      await entity.copy(newPath);
    } else if (entity is Directory) {
      await _copyDirectory(entity, Directory(newPath));
    }
  }
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
