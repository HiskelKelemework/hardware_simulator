import '../ic.dart';
import '../../utils/utils.dart';

class NOT extends IC {
  NOT({String? name, int? depth})
      : super(
          inNum: 1,
          outNum: 1,
          name: name ?? 'NOT',
          depth: depth ?? 0,
        );

  @override
  void trigger() {
    super.trigger();
    final outputVal = !inputs.first.val;
    outputs.first.write(outputVal);
  }
}

class AND extends IC {
  AND({String? name, int? depth})
      : super(
          inNum: 2,
          outNum: 1,
          name: name ?? 'AND',
          depth: depth ?? 0,
        );

  @override
  void trigger() {
    super.trigger();
    final outputVal = inputs.first.val && inputs.last.val;
    outputs.first.write(outputVal);
  }
}

class OR extends IC {
  OR({String? name, int? depth})
      : super(
          inNum: 2,
          outNum: 1,
          name: name ?? 'OR',
          depth: depth ?? 0,
        );

  @override
  void trigger() {
    super.trigger();
    final outputVal = inputs.first.val || inputs.last.val;
    outputs.first.write(outputVal);
  }
}

class NAND extends IC {
  NAND({String? name, int? depth})
      : super(
          inNum: 2,
          outNum: 1,
          name: name ?? 'NAND',
          depth: depth ?? 0,
        ) {
    and = AND(name: 'AND:${super.name}', depth: super.depth + 1);
    not = NOT(name: 'NOT:${super.name}', depth: super.depth + 2);

    and.outputs.first.pipe(not.inputs.first);
    outputs.first = not.outputs.first;
  }

  late final AND and;
  late final NOT not;

  @override
  void trigger() {
    super.trigger();
    and.inputs.first.write(inputs.first.val);
    and.inputs.last.write(inputs.last.val);
  }
}

class XOR extends IC {
  XOR({String? name, int? depth})
      : super(
          inNum: 2,
          outNum: 1,
          name: name ?? 'XOR',
          depth: depth ?? 0,
        ) {
    not1.outputs.first.pipe(and1.inputs.last);
    not2.outputs.first.pipe(and2.inputs.first);

    pipeOutputToInput([and1, and2], [or]);
    outputs.first = or.outputs.first;
  }

  final not1 = NOT();
  final not2 = NOT();
  final and1 = AND();
  final and2 = AND();
  final or = OR();

  @override
  void trigger() {
    super.trigger();
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
