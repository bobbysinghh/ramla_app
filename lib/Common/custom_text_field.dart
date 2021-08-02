import 'package:flutter/material.dart';

Container textFieldCommon(
    {TextEditingController controller,
    Function onSaved,
    Function onChanged,
    FocusNode currentFocus,
    FocusNode nextFocus,
    bool prefixIcon,
    String hintText,
    TextInputType textInputType,
    bool autoFocus,
    double top,
    double bottom,
    double left,
    double right,
    bool suffixIcon,
    double opacity,
    bool obscureText,
    Function validator,
    Function obSecureTap}) {
  return Container(
    height: 45,
    // width: MediaQuery.of(context).size.width / 1.2,
    padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
    margin: EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
    child: TextFormField(
      onChanged: onChanged ?? null,
      onSaved: onSaved ?? null,
      validator: validator ?? null,
      obscureText: obscureText ?? false,
      textInputAction: TextInputAction.next,
      keyboardType: textInputType ?? TextInputType.text,
      autofocus: autoFocus ?? false,
      maxLines: 1,
      // onFieldSubmitted: (term) {
      //   currentFocus.unfocus();
      //   FocusScope.of(context).requestFocus(nextFocus);
      // },
      controller: controller ?? null,
      decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(Icons.search) : null,
          isDense: true,
          hintText: hintText,
          counterText: "",
          border: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Color.fromRGBO(360, 360, 360, opacity),
                  ),
                  onPressed: () {
                    obSecureTap();
                  })
              : null),
    ),
  );
}

Container signUpTextFieldCommon(
    {TextEditingController controller,
    Function onSaved,
    Function onChanged,
    FocusNode currentFocus,
    FocusNode nextFocus,
    String hintText,
    TextInputType textInputType,
    bool autoFocus,
    double top,
    double bottom,
    double left,
    double right,
    bool suffixIcon,
    double opacity,
    bool isObscure,
    Function obSecureTap,
    int maxLine,
    Function validate,
    double height,
    double width}) {
  return Container(
    height: height ?? 45,
    width: width ?? null,
    margin:
        EdgeInsets.fromLTRB(left ?? 30, top ?? 30, right ?? 30, bottom ?? 0),
    child: TextFormField(
      onChanged: onChanged ?? null,
      onSaved: onSaved ?? null,
      validator: validate ?? null,
      obscureText: isObscure ?? false,
      autofocus: autoFocus ?? false,
      keyboardType: textInputType ?? TextInputType.text,
      maxLines: maxLine ?? 1,
      decoration: InputDecoration(
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Color.fromRGBO(360, 360, 360, opacity),
                  ),
                  onPressed: () {
                    obSecureTap();
                  })
              : null,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey[200])),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.grey[300])),
          filled: true,
          fillColor: Colors.grey[100],
          labelText: hintText),
      controller: controller ?? null,
    ),
  );
}

Container customButton({String name, Function callback}) {
  return Container(
    height: 45,
    margin: EdgeInsets.only(left: 30, right: 30),
    decoration: BoxDecoration(
        color: Color.fromRGBO(245, 131, 33, 1),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    child: InkWell(
      child: Center(
        child: Text(
          name.toUpperCase(),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      onTap: callback,
    ),
  );
}

Widget searchAppBar({TextEditingController controller, Color backgroundColor}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: textFieldCommon(
          controller: controller, hintText: "Search product", prefixIcon: true),
      backgroundColor: backgroundColor,
    ),
  );
}
