/// Returns [true] if [s] is either null or empty.
bool isEmpty(String? s) => s == null || s == 'null' || s.trim().isEmpty;

/// Returns [true] if [s] is a not null or empty string.
bool isNotEmpty(String? s) => s != null && s != 'null' && s.trim().isNotEmpty;
