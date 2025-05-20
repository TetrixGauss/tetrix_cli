# Tetrix CLI

A Dart command-line interface (CLI) tool for creating Flutter projects with a predefined structure, custom files, and a curated set of dependencies. Inspired by `dart_frog_cli`, `tetrix_cli` streamlines Flutter project setup.

## Features

- **Custom Flutter Project Creation**: Generates a Flutter project with specified platforms (e.g., Android, iOS, web).
- **Predefined Dependencies**: Includes packages for state management, networking, Firebase, UI components, and more.
- **Custom File Templates**: Creates `main.dart` in the project root and `lib/utils/config.dart` using Mason.
- **Cross-Platform Support**: Works on macOS, Linux, and Windows, handling paths with spaces.
- **Flexible Output Path**: Creates projects in the current working directory or a specified path.
- **Extensible**: Mason-based templating for easy customization.

## Prerequisites

- **Dart SDK**: Version 2.19.0 or higher (`dart --version`).
- **Flutter SDK**: Latest stable version (`flutter --version`).
- Both must be in your system's PATH.

### macOS/Linux
- Ensure `dart` and `flutter` are accessible in your shell (e.g., Bash, Zsh).
- Use quotes for paths with spaces (e.g., `cd "/Users/username/My Projects"`).

### Windows
- Ensure `dart` and `flutter` work in Command Prompt or PowerShell.
- Use quotes for paths with spaces (e.g., `cd "C:\Users\username\My Projects"`).

## Installation

Activate `tetrix_cli` globally using Dart's package manager. The CLI uses `bin/activate.dart` to copy `bin/tetrix_cli` (macOS/Linux) or `bin/tetrix_cli.bat` (Windows), generate a snapshot, and copy `lib/templates/` to `pub-cache`. The entry point (`bin/tetrix_cli.dart`) remains in the project directory.

1. **Clone or Download**:
   Place `tetrix_cli` in a directory, e.g., `/Users/username/My Projects/tetrix_cli`.

2. **Activate Globally**:
    - **macOS/Linux**:
      ```bash
      cd "/path/to/tetrix_cli"
      dart pub get
      dart pub global activate --source path .
      dart bin/activate.dart
      ```
      Copies `bin/tetrix_cli` and `lib/templates/` to `pub-cache` and generates a snapshot.
    - **Windows (Command Prompt)**:
      ```cmd
      cd "C:\path\to\tetrix_cli"
      dart pub get
      dart pub global activate --source path .
      dart bin\activate.dart
      ```
      Copies `bin\tetrix_cli.bat` and `lib\templates\` to `pub-cache`.
    - **Windows (PowerShell)**:
      ```powershell
      cd "C:\path\to\tetrix_cli"
      dart pub get
      dart pub global activate --source path .
      dart bin\activate.dart
      ```

3. **Verify Installation**:
   ```bash
   tetrix_cli --help
   ```
   Shows available commands.

**Note**: Do not edit `~/.pub-cache/bin/tetrix_cli` or `%USERPROFILE%\.pub-cache\bin\tetrix_cli.bat`, as they’re overwritten on reactivation.

### Deactivating and Reactivating

1. **Deactivate**:
   ```bash
   dart pub global deactivate tetrix_cli
   ```

2. **Reactivate**:
   ```bash
   cd "/path/to/tetrix_cli"
   dart pub get
   dart pub global activate --source path .
   dart bin/activate.dart
   ```

3. **Verify**:
   ```bash
   tetrix_cli --help
   ```

## Usage

The `tetrix_cli` provides a `create` command to generate a Flutter project.

### Command Syntax

```bash
tetrix_cli create --name <project_name> [--platforms <platform1,platform2,...>] [--path <output_directory>]
```

- `--name, -n`: (Required) Project name (e.g., `my_test_app`).
- `--platforms, -p`: (Optional) Platforms (e.g., `android,ios,web`). Defaults to `android,ios`.
- `--path`: (Optional) Directory where the project will be created. Defaults to the current working directory.

### Examples

#### Create in Current Directory (macOS/Linux)
```bash
cd "/Users/username/My Projects"
tetrix_cli create --name my_test_app --platforms android,ios
```
Creates `/Users/username/My Projects/my_test_app/`.

#### Create in Current Directory (Windows)
```cmd
cd "C:\Users\username\My Projects"
tetrix_cli create --name my_test_app --platforms android,ios
```
Creates `C:\Users\username\My Projects\my_test_app\`.

#### Create in Specific Directory
```bash
tetrix_cli create --name my_test_app --platforms android,ios --path "/Users/username/Desktop"
```
Creates `/Users/username/Desktop/my_test_app/`.

This:
1. Creates a Flutter project named `my_test_app` in the specified or current directory.
2. Configures platforms.
3. Updates `pubspec.yaml` with dependencies.
4. Generates `main.dart` in the project root and `lib/utils/config.dart` using Mason.
5. Runs `flutter pub get`.

### Generated Project Structure

- **Files**:
    - `main.dart` (in `my_test_app/`): Flutter app with `provider`.
    - `lib/utils/config.dart`: Configuration class.
- **Standard Flutter Directories**:
    - `lib/`: Contains `utils/config.dart` and default Flutter files.
    - `android/`, `ios/`, etc.: Platform-specific code.
- **Dependencies** (as of May 20, 2025):
    - `bloc: ^9.0.0`
    - `flutter_bloc: ^9.1.6`
    - `hydrated_bloc: ^10.0.0`
    - `equatable: ^2.0.5`
    - `firebase_core: ^3.13.0`
    - `firebase_crashlytics: ^4.3.5`
    - `firebase_analytics: ^11.4.5`
    - `json_annotation: ^4.9.0`
    - `loader_overlay: ^5.0.0`
    - `easy_logger: ^0.0.2`
    - `shared_preferences: ^2.5.3`
    - `package_info_plus: ^8.3.0`
    - `dio: ^5.8.0+1`
    - `easy_localization: ^3.0.7+1`
    - `path_provider: ^2.1.5`
    - `flutter_svg: ^2.1.0`
    - `carousel_slider: ^5.0.0`
    - `http: ^1.4.0`
    - `flutter_dotenv: ^5.2.1`
    - `provider: ^6.1.5`
    - `url_launcher: ^6.3.1`
    - `flutter_animate: ^4.5.2`
    - `calendar_date_picker2: ^2.0.0`
    - `smooth_page_indicator: ^1.2.1`

### Output

```
Creating Flutter project "my_test_app" for platforms: android,ios at /path/to/directory
Updated pubspec.yaml with dependencies: {...}
Ran "flutter pub get" successfully
Generated files: /path/to/directory/my_test_app/main.dart, /path/to/directory/my_test_app/lib/utils/config.dart
Flutter project "my_test_app" created successfully at /path/to/directory/my_test_app!
```

## Troubleshooting

- **Flutter Not Found**:
    - Run `flutter doctor`.
    - Check PATH in `~/.bashrc`, `~/.zshrc` (macOS/Linux) or System Environment Variables (Windows).
- **Directory Already Exists**:
    - Use a unique project name or delete the existing directory.
- **Path with Spaces**:
    - Use quotes: `cd "/Users/username/My Projects"`.
- **Dependency Errors** (e.g., `Couldn't resolve the package 'args'`):
    1. Verify `pubspec.yaml` includes `args`, `path`, etc.
    2. Run:
       ```bash
       cd "/path/to/tetrix_cli"
       dart pub get
       ```
    3. Remove `~/.pub-cache/bin/tetrix_cli.dart`:
       ```bash
       rm ~/.pub-cache/bin/tetrix_cli.dart
       ```
    4. Reactivate:
       ```bash
       dart pub global deactivate tetrix_cli
       dart pub global activate --source path .
       dart bin/activate.dart
       ```
    5. Test:
       ```bash
       dart "/path/to/tetrix_cli/bin/tetrix_cli.dart" --help
       ```
- **Type Mismatch Errors** (e.g., `CommandRunner<dynamic>` vs. `CommandRunner<int>`):
    - Ensure `bin/tetrix_cli.dart` uses `CommandRunner<int>`.
    - Verify `lib/src/cli/create_command.dart` extends `Command<int>`.
    - Reactivate.
- **Template Errors** (e.g., `PathNotFoundException: Cannot open file, path = '.../brick.yaml'`):
    1. Verify `lib/templates/`:
       ```bash
       ls -l "/path/to/tetrix_cli/lib/templates"
       ```
       Should show `brick.yaml` and `__brick__/main.dart`, `__brick__/lib/utils/config.dart`.
    2. Check `pub-cache`:
       ```bash
       ls -l ~/.pub-cache/global_packages/tetrix_cli/lib/templates
       ```
    3. Ensure `bin/activate.dart` copies `lib/templates/`:
       ```bash
       dart bin/activate.dart
       ```
    4. Verify `create_command.dart` uses `pub-cache` path:
       ```dart
       Brick.path(path.join(path.dirname(Platform.script.path), '..', 'lib', 'templates'))
       ```
    5. Reactivate.
- **Invalid brick.yaml Errors** (e.g., `ParsedYamlException: Unrecognized keys: [bricks]`):
    1. Check `brick.yaml`:
       ```bash
       cat "/path/to/tetrix_cli/lib/templates/brick.yaml"
       ```
       Should have `name`, `description`, `version`, `vars`, not `bricks`.
    2. Correct `brick.yaml`:
       ```yaml
       name: tetrix_app
       description: A Flutter project template with provider and custom configuration.
       version: 0.1.0
       vars:
         name:
           type: string
           description: The name of the Flutter project
           prompt: What is the project name?
       ```
    3. Verify `pub-cache`:
       ```bash
       cat ~/.pub-cache/global_packages/tetrix_cli/lib/templates/brick.yaml
       ```
    4. Reactivate.
- **Incorrect Project Location**:
    - If the project is created inside `tetrix_cli/`:
        1. Verify `create_command.dart` uses `_getWorkingDirectory()`:
           ```dart
           defaultsTo: _getWorkingDirectory()
           ```