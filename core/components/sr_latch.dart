import '../gates/gates.dart';
import '../ic.dart';

class SRLATCH extends IC {
  SRLATCH({String? name, int? depth})
      : super(
          inNum: 2,
          outNum: 2,
          name: name ?? 'SRLATCH',
          depth: depth ?? 0,
        ) {
    nand1 = NAND(name: 'nand_1', depth: super.depth + 1);
    nand2 = NAND(name: 'nand_2', depth: super.depth + 1);

    nand1.outputs.first.pipe(nand2.inputs.first);
    nand2.outputs.first.pipe(nand1.inputs.last);

    outputs.first = nand1.outputs.first;
    outputs.last = nand2.outputs.first;
  }

  late final NAND nand1;
  late final NAND nand2;

  @override
  void trigger() {
    super.trigger();
    nand1.inputs.first.write(inputs.first.val);
    nand2.inputs.last.write(inputs.last.val);
  }
}
