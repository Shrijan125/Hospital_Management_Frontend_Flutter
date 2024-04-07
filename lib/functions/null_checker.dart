bool nullEmptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return true;
  } else {
    return false;
  }
}
