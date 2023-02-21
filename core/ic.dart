abstract class IC {
  late List<Input> _inputs;
  late List<Output> _outputs;

  List<Input> get inputs => _inputs;
  List<Output> get outputs => _outputs;

  final String name;
  final int depth;

  IC({
    required int inNum,
    required int outNum,
    required this.name,
    required this.depth,
  }) {
    assert(inNum > 0, 'inputs must be positive');
    assert(outNum > 0, 'outputs must be positive');

    _inputs = List.generate(inNum, (i) => i).map((e) => Input(this)).toList();
    _outputs = List.generate(outNum, (i) => i).map((e) => Output()).toList();
  }

  void trigger() {
    // final padding = '   ' * depth;
    // final inputs = _inputs.map((e) => e.val).toList();
    // print('$padding $name :: inputs $inputs');
  }
}

class Input {
  final IC ic;
  bool? _val;

  bool get val => _val ?? false;

  Input(this.ic);

  write(bool signal) {
    if (signal == _val) return;
    _val = signal;
    ic.trigger();
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
