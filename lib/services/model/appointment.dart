class Appointment{
  String? doctorname;
  String? patientname;
  String? date;
  String? time;
 
  Appointment({
    required this.doctorname,
    required this.patientname,
    required this.date,
    required this.time
  });

  Appointment.fromJson(Map<String,dynamic> json){
    doctorname=json['doctorname'];
    patientname=json['patientname'];
    date=json['date'];
    time=json['time'];
  }
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorname']=doctorname;
    data['patientname']=patientname;
    data['date']=date;
    data['time']=time;

    return data;
  }
}