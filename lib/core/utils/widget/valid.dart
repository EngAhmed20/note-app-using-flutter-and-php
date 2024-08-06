validInput(String val,int min,int max)
{
  if (val.isNotEmpty && val.length>max){
    return "this filed can't be more than $max";
  }
  if (val.isNotEmpty&& val.length<min){
    return "this filed can't be less than $min";
  }
  if (val.isEmpty){
    return "this field can't be empty";
  }
  return null;

}