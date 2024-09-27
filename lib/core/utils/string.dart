String capitalizeFirstLetter(String name) {
  if (name.isEmpty) return ''; // Return an empty string if the input is empty
  return name[0].toUpperCase() + name.substring(1).toLowerCase();
}
