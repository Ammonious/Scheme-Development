part of scheme_automation;

/// the `scheme_automation run` command
class RunCommmand extends Command {
  bool get alias => false;

  @override
  String get name => 'run';

  @override
  String get description =>
      'Find the script definition from pubspec.yaml and execute it.';

  RunCommmand() {
    super.argParser.addFlag(
          'silent',
          abbr: 's',
          help: 'Determine whether to show outputs or not.',
          defaultsTo: false,
          negatable: false,
        );
  }

  Map<String, dynamic> parseExtras(List<String> args) {
    final flag = args.contains('--');

    if (flag) {
      final start = args.indexOf('--');
      return <String, List>{
        'args': args.sublist(0, start).toList(),
        'extra': args.sublist(start + 1).toList(),
      };
    } else {
      return <String, List>{
        'args': args,
        'extra': [],
      };
    }
  }

  @override
  Future<void> run() async {
    final parsed = parseExtras(super.argResults.arguments);
    final args = super.argParser.parse(parsed['args']).rest;
    final extra = parsed['extra'].join(' ');
    final silent = super.argResults['silent'];

    if (args.isEmpty && !alias) {
      print(super.usage);
    } else {
      final arg =
          alias ? '$name ${args.join(' ')}'.trim() : args.join(' ').trim();

      final info = await loadInfo();
      final definitions = await loadDefinitions();
      final infoLine = '> ${info.name}@${info.version} $arg ${info.pwd}';

      execute(
        definitions,
        arg,
        extra: extra,
        silent: silent,
        infoLine: infoLine,
      );
    }
  }
}
