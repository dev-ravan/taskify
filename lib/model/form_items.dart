class FormItems {
  final String hintText;
  final String errorMsg;
  final String regExp;
  final String fieldName;
  final RegExp? formatter;

  FormItems(
      {this.hintText = "",
      this.errorMsg = "",
      this.fieldName = "",
      this.regExp = "",
      this.formatter});
}
