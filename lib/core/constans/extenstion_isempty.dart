String cleanAddress(String? address) {
  final cleaned = (address ?? '')
      .replaceAll(RegExp(r'\bnull\b', caseSensitive: false), '')
      .trim()
      .replaceAll(RegExp(r'\s{2,}'), ' '); // إزالة الفراغات الزائدة
  return cleaned.isEmpty ? 'لا يوجد عنوان' : cleaned;
}