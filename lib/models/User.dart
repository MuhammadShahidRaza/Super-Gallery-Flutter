class UserModel{
   String? name;
   String? email;
   String? password;
   String? confirm_password;
   String? mobile;
   String? phone;
   String? address;
   String? postal;
   String? birthday;

   UserModel({this.phone,this.birthday,this.mobile,this.postal,this.address,this.name, this.email, this.password, this.confirm_password});
   Map<String,dynamic> tojson(){
      return {
         'name':name??"",
         'email':email??"",
         'password':password??"",


      };
   }


}