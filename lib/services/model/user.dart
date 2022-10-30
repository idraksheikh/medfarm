class UserData{
  
  String? access;
  String? address;
  String? bloodgroup;
  String? dob;
  String? email;
  String? gender;
  int? mobile;
  String? username;

  UserData({
    this.access,
    this.username,
    this.address,
    this.bloodgroup,
    this.dob,
    this.email,
    this.gender,
    this.mobile
  });
  UserData.fromJson(Map<String,dynamic> json){
      access=json['access'];
      username=json['username'];
      address=json['address'];
      bloodgroup=json['bloodgroup'];
      dob=json['dob'];
      email=json['email'];
      gender=json['gender'];
      mobile=json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access']=access;
    data['username']=username;
    data['address']=address;
    data['bloodgroup']=bloodgroup;
    data['dob']=dob;
    data['email']=email;
    data['gender']=gender;
    data['mobile']=mobile;

    return data;

  }
  
}