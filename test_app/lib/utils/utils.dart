bool isEmail(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  return (regExp.hasMatch(email)) ? true : false;
}

bool isPass(String pass) {
  //Pattern pattern = '/\s/';
  //RegExp regExp = new RegExp(pattern);
  return ((pass.length > 6) && (!pass.contains(' '))) ? true : false;
}
