// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chair_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChairStatusAdapter extends TypeAdapter<ChairStatus> {
  @override
  final int typeId = 1;

  @override
  ChairStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return ChairStatus.open;
      case 2:
        return ChairStatus.closed;
      default:
        return ChairStatus.open;
    }
  }

  @override
  void write(BinaryWriter writer, ChairStatus obj) {
    switch (obj) {
      case ChairStatus.open:
        writer.writeByte(1);
        break;
      case ChairStatus.closed:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChairStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
