// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReceiptHistoryModelAdapter extends TypeAdapter<ReceiptHistoryModel> {
  @override
  final int typeId = 1;

  @override
  ReceiptHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReceiptHistoryModel(
      newReceipt: fields[0] as String,
      dateTime: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReceiptHistoryModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.newReceipt)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReceiptHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
