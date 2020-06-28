library scheme_automation;

import 'dart:io';
import 'package:args/args.dart';
import 'package:process_run/cmd_run.dart';
import 'scheme_module_builders/firebase_auth_builder.dart' as auth_builder;
import 'scheme_module_builders/google_maps_builder.dart' as maps_builder;
import 'scheme_module_builders/android_signing.dart' as android_sign;
import 'scheme_module_builders/firestore_crud_builder.dart' as firestore_builder;
import 'scheme_module_builders/theme_builder.dart' as theme_builder;
import 'scheme_module_builders/scheme_builder.dart' as scheme_builder;
import 'scheme_module_builders/dialog_builder.dart' as dialog_builder;
import 'scheme_module_builders/plugin_builder.dart' as plugin_builder;
import 'scheme_module_builders/user_signed_builder.dart' as user_builder;
import 'scheme_module_builders/admin_signed_builder.dart' as admin_builder;
import 'dart:cli' as cli;
import 'dart:ffi' as ffi;
import 'dart:isolate' show Isolate;
import 'package:ffi/ffi.dart';
import 'package:yaml/yaml.dart';
import 'package:console/console.dart';
import 'package:args/command_runner.dart';
import 'package:equatable/equatable.dart';
import 'package:string_similarity/string_similarity.dart';

part 'script_builder/config.dart';
part 'script_builder/execute.dart';
part 'script_builder/load_info.dart';
part 'script_builder/load_definitions.dart';

part 'script_builder/ffi/ffi.dart';
part 'script_builder/ffi/get_object.dart';

part 'script_builder/error/handler.dart';
part 'script_builder/error/error_type.dart';

part 'script_builder/commands/ls.dart';
part 'script_builder/commands/run.dart';
part 'script_builder/commands/test.dart';
part 'script_builder/commands/build.dart';

part 'script_builder/models/info.dart';
part 'script_builder/models/error.dart';
part 'script_builder/models/definition.dart';

part 'script_builder/helpers/to_list.dart';
part 'script_builder/helpers/make_keys.dart';
part 'script_builder/helpers/subcommand.dart';
part 'script_builder/helpers/deep_search.dart';
part 'script_builder/helpers/read_pubspec.dart';
part 'script_builder/helpers/read_yaml_file.dart';
part 'script_builder/helpers/parse_defnintion.dart';

/// deciphers which scripts to run based on the arguments provided by the user
void decipherScript(List<String> arguments) async {

  final parser = ArgParser(allowTrailingOptions: true);
  parser.addFlag('help', abbr: 'h', negatable: false, help: "Usage help");
  addFlag(parser, 'build-auth');
  addFlag(parser, 'build-firestore');
  addFlag(parser, 'build-maps');
  addFlag(parser, 'build-theme');
  addFlag(parser, 'build-dialog');
  addFlag(parser, 'build-scheme');
  addFlag(parser, 'android-sign');
  addFlag(parser, 'build-admin');
  addFlag(parser, 'build-user');

  final argResults = parser.parse(arguments);

  helpCheck(parser,argResults);

  runMethods(argResults);

}



helpCheck(ArgParser parser, ArgResults argResults){
  if (argResults['help'] || argResults.arguments.length < 1) {
    stdout.write('Automation scripts for flutter');
    stdout.write(parser.usage);

    return;
  }
}
addFlag(ArgParser parser, String flag){
  parser.addFlag(flag, help: 'Scheme Does not need help!', negatable: false);
}

runMethods(ArgResults argResults) async {

  bool runCommands = false;

  plugin_builder.buildPlugins();


  if (argResults['build-auth']) {
    auth_builder.buildModule();
    dialog_builder.buildModule();
    admin_builder.buildModule();
    user_builder.buildModule();
    runCommands = true;
  }

  if(argResults['build-admin']){
    admin_builder.buildModule();
  }

  if(argResults['build-user']){
    user_builder.buildModule();
  }
  if (argResults['build-theme']){
    theme_builder.buildModule();
    runCommands = true;
  }

  if (argResults['build-scheme']){
    scheme_builder.buildModule();
    runCommands = true;
  }

  if (argResults['build-dialog']) {
    dialog_builder.buildModule();
    theme_builder.buildModule();
    runCommands = true;
  }

  if (argResults['build-maps']){
    maps_builder.buildModule();
  }

  if (argResults['android-sign']){
    android_sign.androidSign();
  }

  if (argResults['build-firestore']){
    firestore_builder.buildModule();
  }

  if(runCommands){
    await runCmd(PubCmd(['get']), verbose: true);
    await runCmd(PbrCmd(['build']),verbose: true);
  }
}
