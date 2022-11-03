class DoctorInfo{
  
  String? doctorname;
  String? address;
  String? degree;
  String? specialisation;
  String? email;
  String? certificate;
  

  DoctorInfo({
    this.doctorname,
  this.address,
  this.degree,
  this.specialisation,
  this.email,
  this.certificate
  
  });
  DoctorInfo.fromJson(Map<String,dynamic> json){
      doctorname=json['doctorname'];
      address=json['address'];
      degree=json['degree'];
      specialisation=json['specialisation'];
      email=json['email'];
      certificate=json['certificate'];
      
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorname']=doctorname;
    data['email']=email;
    data['address']=address;
    data['specialisation']=specialisation;
    data['degree']=degree;
    data['certificate']=certificate;
    

    return data;

  }
  
}