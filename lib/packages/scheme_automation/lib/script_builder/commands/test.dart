part of scheme_automation;

class TestCommand extends RunCommmand {
  @override
  bool get alias => true;

  @override
  String get name => 'test';

  @override
  String get description => 'alias to scheme_automation run test.';
}
