import 'core/gates/gates.dart';
import 'utils/utils.dart';

void main(List<String> args) {
  final xor = XOR();
  final printer = Printer();

  // pass the output of xor as input to the printer IC.
  xor.outputs.first.pipe(printer.inputs.first);

  // this should produce true
  xor.inputs.first.write(true);
  xor.inputs.last.write(false);

  // this should produce false
  xor.inputs.first.write(false);
  xor.inputs.last.write(false);
}
