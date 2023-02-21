import '../core/ic.dart';

pipeOutputToInput(List<IC> outComponents, List<IC> inputComponents) {
  final allOutputs =
      outComponents.map((e) => e.outputs).expand((e) => e).toList();
  final allInputs =
      inputComponents.map((e) => e.inputs).expand((e) => e).toList();

  if (allInputs.length != allOutputs.length) {
    throw new Exception(
        'input output mismatch inputs:: ${allOutputs.length} outputs:: ${allInputs.length}');
  }

  for (int i in List.generate(allOutputs.length, (i) => i)) {
    allOutputs[i].pipe(allInputs[i]);
  }
}

class Printer extends IC {
  Printer({String? name, int? depth})
      : super(
          inNum: 1,
          outNum: 1,
          name: 'printer',
          depth: depth ?? 0,
        );

  @override
  void trigger() {
    print('$name:: triggered with value ${inputs.first.val}');
  }
}
