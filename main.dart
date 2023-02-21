import 'core/components/components.dart';
import 'utils/utils.dart';

void main(List<String> args) {
  final srLatch = SRLATCH();
  final printer = Printer(name: 'Q');

  srLatch.outputs.first.pipe(printer.inputs.first);

  srLatch.inputs.first.write(true);
  srLatch.inputs.last.write(false);
}
