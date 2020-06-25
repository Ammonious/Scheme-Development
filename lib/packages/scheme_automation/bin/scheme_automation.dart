import 'package:args/command_runner.dart';
import 'package:scheme_automation/scheme_automation.dart';

void main(List<String> arguments) async {
  final runner = CommandRunner('derry', 'A script runner/manager for dart.');

  runner
    ..addCommand(ListCommand())
    ..addCommand(RunCommmand())
    ..addCommand(TestCommand())
    ..addCommand(BuildCommand());

  try {
    await runner.run(arguments);
  } on Error catch (error) {
    errorHandler(error);
  } catch (error) {
    print(error);
  }

}

automationScripts(List<String> arguments){
  decipherScript(arguments);
}
