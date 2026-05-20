class ValidatorService{

static String? validateEmpty(String value){

if(value.isEmpty){
return "Field required";
}

return null;

}

static String? validateEmail(String value){

if(value.isEmpty){
return "Email required";
}

RegExp emailRegex=
RegExp(r'^[^@]+@[^@]+\.[^@]+');

if(!emailRegex.hasMatch(value)){

return "Invalid Email";

}

return null;

}

static String? validatePassword(String value){

if(value.length<6){

return "Minimum 6 characters";

}

if(!RegExp(r'[A-Z]').hasMatch(value)){

return "Need uppercase";

}

if(!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)){

return "Need special character";

}

return null;

}

}