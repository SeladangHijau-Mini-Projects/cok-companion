// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status-impairment.box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatusImpairmentAdapter extends TypeAdapter<StatusImpairment> {
  @override
  final int typeId = 9;

  @override
  StatusImpairment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatusImpairment(
      id: fields[0] as String,
      code: fields[1] as int,
      name: fields[2] as String,
      imagePath: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StatusImpairment obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusImpairmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
