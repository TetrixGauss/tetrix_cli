import 'package:args/command_runner.dart';
import 'package:tetrix_cli/src/cli/create_command.dart';

void main(List<String> arguments) async {
  // await activate();
  final runner = CommandRunner<int>('tetrix_cli', 'A CLI for creating Flutter projects with custom setup.')..addCommand(CreateCommand());
  runner.run(arguments).catchError((error) {
    print(error);
    return 1;
  });
}
