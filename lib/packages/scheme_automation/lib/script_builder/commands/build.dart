part of scheme_automation;

class BuildCommand extends RunCommmand {
  @override
  bool get alias => true;

  @override
  String get name => 'build';

  @override
  String get description => 'alias to scheme_automation run build.';
}
