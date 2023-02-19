abstract class IC {
  late List<Input> _inputs;
  late List<Output> _outputs;

  int _registerCount = 0;

  List<Input> get inputs => _inputs;
  List<Output> get outputs => _outputs;

  final String? name;

  IC({required int inNum, required int outNum, required this.name}) {
    assert(inNum > 0, 'inputs must be positive');
    assert(outNum > 0, 'outputs must be positive');

    _inputs = List.generate(inNum, (i) => i).map((e) => Input(this)).toList();
    _outputs = List.generate(outNum, (i) => i).map((e) => Output()).toList();
  }

  void trigger() {
    throw UnimplementedError();
  }

  void register() {
    if (++_registerCount == inputs.length) {
      trigger();
      _registerCount = 0;
    }
  }
}

class Input {
  final IC ic;
  bool? _val;

  bool get val => _val ?? false;

  Input(this.ic);

  write(bool val) {
    _val = val;
    ic.register();
  }
}

class Output {
  final List<Input> inputs = [];

  pipe(Input input) {
    inputs.add(input);
  }

  write(bool val) {
    for (final input in inputs) {
      input.write(val);
    }
  }
}
