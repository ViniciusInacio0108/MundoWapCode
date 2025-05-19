enum EFieldTaskType {
  text,
  mask_price,
  mask_date,
}

class TaskField {
  int id;
  String label;
  String value;
  bool required;
  EFieldTaskType fieldType;

  TaskField({
    required this.id,
    required this.label,
    required this.required,
    required this.fieldType,
    required this.value,
  });

  static EFieldTaskType mapFieldTaskEnum(String fieldType) {
    switch (fieldType) {
      case 'mask_price' || 'EFieldTaskType.mask_price':
        return EFieldTaskType.mask_price;
      case 'mask_date' || 'EFieldTaskType.mask_date':
        return EFieldTaskType.mask_date;
      default:
        return EFieldTaskType.text;
    }
  }
}
