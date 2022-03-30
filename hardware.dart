class Nand {
  List<bool> _inputs = [];
  int _numOfInputs = 2;
  Function(bool)? _outputFunc;

  void input(bool val) {
    _inputs.add(val);
    if (_inputs.length == _numOfInputs) {
      final result = _nandOp();

      if (_outputFunc != null) {
        _outputFunc!(result);
        _inputs = [];
      }
    }
  }

  void output(Function(bool) outputFunc) {
    _outputFunc = outputFunc;
  }

  bool _nandOp() {
    bool result = true;
    for (bool input in _inputs) {
      result = result && input;
    }

    return !result;
  }
}

class Clock {
  List<Input> _inputs = [];
  bool running = false;

  void attach(Input input) {
    _inputs.add(input);
  }

  Future<void> start() async {
    if (running) return;
    running = true;

    while (running) {
      for (var input in _inputs) {
        input.trigger();
      }

      await Future.delayed(Duration(seconds: 1));
    }
  }

  void stop() {
    running = false;
  }
}

abstract class ITriggerable {
  void trigger();
}

class Input implements ITriggerable {
  List<Function(bool)> _outlet = [];
  late bool _val;

  void output(Function(bool) out) {
    _outlet.add(out);
  }

  void val(bool val) {
    _val = val;
  }

  @override
  void trigger() {
    for (var func in _outlet) {
      func(_val);
    }
  }

  void attachClock(Clock c) {
    c.attach(this);
  }
}

// class IC {
// inputs.
// internal network parsed from str.
// output.
// }

void main() async {
  // final str = "4n-3i::i0->1n,i1->0n,i1->0n,i1->2n,i2->2n,0n->3n,2n->3n,0n->1n";
  // example:: creates a 2x1 mux.
  final a = Nand();
  final b = Nand();
  final c = Nand();
  final d = Nand();

  final clock = Clock();

  final i1 = Input()
    ..val(true)
    ..attachClock(clock);
  final sel = Input()
    ..val(false)
    ..attachClock(clock);
  final i2 = Input()
    ..val(false)
    ..attachClock(clock);

  i1.output(b.input);
  sel.output(a.input);
  sel.output(a.input);
  sel.output(c.input);
  i2.output(c.input);

  a.output(b.input);
  b.output(d.input);
  c.output(d.input);
  d.output(print);

  clock.start();
  await Future.delayed(Duration(seconds: 3), clock.stop);
}
