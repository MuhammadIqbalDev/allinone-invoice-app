import 'dart:math';

String longIDGenerator() {
  Random random = Random(DateTime.now().millisecond);

  const String hexDigits = "0123456789abcdef";
  final List<String> uuid = List.generate(100, (index) => '');

  for (int i = 0; i < 100; i++) {
    final int hexPos = random.nextInt(16);
    uuid[i] = (hexDigits.substring(hexPos, hexPos + 1));
  }

  int pos = (int.parse(uuid[19], radix: 16) & 0x3) | 0x8;

  uuid[14] = "4";
  uuid[19] = hexDigits.substring(pos, pos + 1);

  uuid[19] = uuid[39] = uuid[59] = uuid[79] = "-";

  final StringBuffer buffer = StringBuffer();
  buffer.writeAll(uuid);
  return buffer.toString();
}

String shortIDGenerator() {
  Random random = Random(DateTime.now().millisecond);

  const String hexDigits = "0123456789abcdef";
  final List<String> uuid = List.generate(20, (index) => '');

  for (int i = 0; i < 20; i++) {
    final int hexPos = random.nextInt(16);
    uuid[i] = (hexDigits.substring(hexPos, hexPos + 1));
  }

  int pos = (int.parse(uuid[19], radix: 16) & 0x3) | 0x8;

  uuid[8] = "4";
  uuid[19] = hexDigits.substring(pos, pos + 1);

  uuid[4] = uuid[9] = uuid[14] = "-";

  final StringBuffer buffer = StringBuffer();
  buffer.writeAll(uuid);
  return buffer.toString();
}

String tempPassGenerator() {
  Random random = Random(DateTime.now().millisecond);

  const String hexDigits = "0123456789abcdef";
  final List<String> uuid = List.generate(10, (index) => '');

  for (int i = 0; i < 10; i++) {
    final int hexPos = random.nextInt(16);
    uuid[i] = (hexDigits.substring(hexPos, hexPos + 1));
  }

  int pos = (int.parse(uuid[9], radix: 16) & 0x3) | 0x8;

  uuid[4] = "4";
  uuid[9] = hexDigits.substring(pos, pos + 1);

  final StringBuffer buffer = StringBuffer();
  buffer.writeAll(uuid);
  return buffer.toString();
}
