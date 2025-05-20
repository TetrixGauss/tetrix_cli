import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import 'package:tetrix_cli/src/cli/create_command.dart';

void main(List<String> arguments) async {
  // await activate();
  final runner = CommandRunner<int>('tetrix_cli', 'A CLI for creating Flutter projects with custom setup.')..addCommand(CreateCommand());
  runner.run(arguments).catchError((error) {
    print(error);
    return 1;
  });
}

Future<void> activate() async {
  final pubCacheDir = _getPubCacheDir();
  final projectDir = Directory.current.path;
  final platform = Platform.operatingSystem;

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
    print('Copying tetrix_cli for macOS/Linux...');
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
