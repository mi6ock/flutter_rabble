import 'dart:io';
import 'dart:typed_data';

void joinFilesWithEmpty(
    {int milliseconds = 3000, List<File> files, File output}) {
  final _outputList = <int>[];

  // headerのオフセット
  var dataOffset = 44;

  // 11 = 11.025 3 * 11025 ~= 3000 * 11
  final empty = List<int>.generate(milliseconds * 11, (index) => 0);

  for (final file in files) {
    final bytes = file.readAsBytesSync();
    _outputList.addAll(empty);
    _outputList.addAll(bytes.buffer.asInt8List(dataOffset));
  }

  final header = _wavFileHeader(_outputList);
  output.writeAsBytesSync(header);
  output.writeAsBytesSync(_outputList, mode: FileMode.append);
}

Int8List _wavFileHeader(List<int> data) {
  // 基本これらの値で固定なので
  final samplingRate = 11025;
  final byteRate = 22050;

  final header = Int8List(44);
  header[0] = 82; // 'RIFF'
  header[1] = 73;
  header[2] = 70;
  header[3] = 70;
  header[4] = Int8List.fromList([((data.length + 36) & 0xff)])[0];
  header[5] = Int8List.fromList([((data.length + 36) >> 8 & 0xff)])[0];
  header[6] = Int8List.fromList([((data.length + 36) >> 16 & 0xff)])[0];
  header[7] = Int8List.fromList([((data.length + 36) >> 24 & 0xff)])[0];
  header[8] = 87; // 'WAVE'
  header[9] = 65;
  header[10] = 86;
  header[11] = 69;
  header[12] = 102; // 'fmt '
  header[13] = 109;
  header[14] = 116;
  header[15] = 32;
  header[16] = 16;
  header[17] = 0;
  header[18] = 0;
  header[19] = 0;
  header[20] = 1;
  header[21] = 0;
  header[22] = 1; // channel
  header[23] = 0;
  header[24] = Int8List.fromList([(samplingRate & 0xff)])[0];
  header[25] = Int8List.fromList([(samplingRate >> 8 & 0xff)])[0];
  header[26] = Int8List.fromList([(samplingRate >> 16 & 0xff)])[0];
  header[27] = Int8List.fromList([(samplingRate >> 24 & 0xff)])[0];
  header[28] = Int8List.fromList([(byteRate & 0xff)])[0];
  header[29] = Int8List.fromList([(byteRate >> 8 & 0xff)])[0];
  header[30] = Int8List.fromList([(byteRate >> 16 & 0xff)])[0];
  header[31] = Int8List.fromList([(byteRate >> 24 & 0xff)])[0];
  header[32] = 2; // 16bit stereo 4 16bit mono 2 18bit mono 1
  header[33] = 0;
  header[34] = 16;
  header[35] = 0;
  header[36] = 100; // 'data' 100 97 116 97 or FLLR 70 76 76 82
  header[37] = 97;
  header[38] = 116;
  header[39] = 97;
  header[40] = Int8List.fromList([((data.length) & 0xff)])[0];
  header[41] = Int8List.fromList([(((data.length) >> 8) & 0xff)])[0];
  header[42] = Int8List.fromList([((data.length) >> 16 & 0xff)])[0];
  header[43] = Int8List.fromList([((data.length) >> 24 & 0xff)])[0];
  return header;
}
