part of scheme_automation;

Definition parseDefinition(dynamic input) {
  if (input is YamlMap) {
    return Definition(
      execution: input.value['(execution)'],
      scripts: toList(input.value['(scripts)']),
    );
  } else {
    return Definition(
      execution: 'multiple',
      scripts: toList(input),
    );
  }
}
