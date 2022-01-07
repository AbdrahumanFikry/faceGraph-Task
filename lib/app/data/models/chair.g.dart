// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chair.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChairAdapter extends TypeAdapter<Chair> {
  @override
  final int typeId = 0;

  @override
  Chair read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chair(
      fields[1] as String,
      title: fields[2] as String,
      description: fields[4] as String?,
      picturePath: fields[9] as String,
      dateTime: fields[5] as DateTime,
      status: fields[7] as ChairStatus,
    );
  }

  @override
  void write(BinaryWriter writer, Chair obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.iD)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.picturePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChairAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
