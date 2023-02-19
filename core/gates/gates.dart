import '../ic.dart';
import '../../utils/utils.dart';

class NOT extends IC {
  NOT({String? name}) : super(inNum: 1, outNum: 1, name: name);

  @override
  void trigger() {
    final outputVal = !inputs.first.val;
    outputs.first.write(outputVal);
  }
}

class AND extends IC {
  AND({String? name}) : super(inNum: 2, outNum: 1, name: name);

  @override
  void trigger() {
    final outputVal = inputs.first.val && inputs.last.val;
    outputs.first.write(outputVal);
  }
}

class OR extends IC {
  OR({String? name}) : super(inNum: 2, outNum: 1, name: name);

  @override
  void trigger() {
    final outputVal = inputs.first.val || inputs.last.val;
    outputs.first.write(outputVal);
  }
}

class XOR extends IC {
  final not1 = NOT();
  final not2 = NOT();
  final and1 = AND();
  final and2 = AND();
  final or = OR();

  XOR({String? name}) : super(inNum: 2, outNum: 1, name: name) {
    not1.outputs.first.pipe(and1.inputs.last);
    not2.outputs.first.pipe(and2.inputs.first);

    pipeOutputToInput([and1, and2], [or]);
    outputs.first = or.outputs.first;
  }

  @override
  void trigger() {
    final signalA = inputs.first.val;
    final signalB = inputs.last.val;

    // singal A lines
    and1.inputs.first.write(signalA);
    not2.inputs.first.write(signalA);

    // singla B lines
    not1.inputs.first.write(signalB);
    and2.inputs.first.write(signalB);
  }
}
