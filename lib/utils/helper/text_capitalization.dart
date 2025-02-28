capitalizeFirstCharacter(String? text) {
  return text != null && text.isNotEmpty
      ? "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}"
      : "";
}
