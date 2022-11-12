// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/services/doctor.dart';
import 'package:medfarm/services/model/doctorinfo.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorDetails extends StatefulWidget {
  final String email;
  const DoctorDetails({Key? key, required this.email}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState(email: email);
}

class _DoctorDetailsState extends State<DoctorDetails> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late String _selectedTime;
  final String email;
  final DoctorService _doctorService = DoctorService();
  String _appointmentDate = "";
  bool showappbutton = true;
  bool mont1 = true;
  bool mont2 = false;
  bool mont3 = false;
  bool mont4 = false;
  bool evet1 = false;
  bool evet2 = false;
  bool evet3 = false;
  bool evet4 = false;
  void checkTime() {
    if (mont1) {
      setState(() {
        _selectedTime = "8:30 AM";
      });
    } else if (mont2) {
      setState(() {
        _selectedTime = "9:00 AM";
      });
    } else if (mont3) {
      setState(() {
        _selectedTime = "9:30 AM";
      });
    } else if (mont4) {
      setState(() {
        _selectedTime = "10:00 AM";
      });
    } else if (evet1) {
      setState(() {
        _selectedTime = "8:30 PM";
      });
    } else if (evet2) {
      setState(() {
        _selectedTime = "9:00 PM";
      });
    } else if (evet3) {
      setState(() {
        _selectedTime = "9:30 PM";
      });
    } else {
      setState(() {
        _selectedTime = "10:00 PM";
      });
    }
  }

  _DoctorDetailsState({required this.email});

  Future<DoctorInfo?> takeDoctorValue() async {
    try {
      var res = await _doctorService.showDoctorProfile(email);
      print(res.toString());
      return res;
    } catch (e) {
      print("error occured");
      return null;
    }
  }

  late Future<DoctorInfo?> doctorInfo;

  @override
  void initState() {
    super.initState();
    doctorInfo = takeDoctorValue();
    checkTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: FutureBuilder<DoctorInfo?>(
            future: doctorInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 30),
                              child: Row(children: [
                                Container(
                                  height: 200,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage("lib/images/doctors.png"),
                                    fit: BoxFit.cover,
                                  )),
                                  margin: const EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: Text(
                                              "Dr ${snapshot.data!.doctorname!}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: Text(
                                              snapshot.data!.specialisation!,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w300))),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: Text(
                                              "Degree : ${snapshot.data!.degree!}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w300))),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: Text(
                                              "Address : ${snapshot.data!.address!}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w300))),
                                    ],
                                  ),
                                )
                              ]))),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          print(_selectedDay.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: TableCalendar(
                            firstDay: DateTime.now(),
                            lastDay: DateTime(2023),
                            focusedDay: _focusedDay,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            calendarStyle: const CalendarStyle(
                                selectedDecoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle)),
                            onDaySelected: (selectedDay, focusedDay) {
                              if (!isSameDay(_selectedDay, selectedDay)) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                  _appointmentDate =
                                      "${_selectedDay!.day.toString()}-${_selectedDay!.month.toString()}-${_selectedDay!.year.toString()}";
                                });
                              }
                            },
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                            headerStyle:
                                const HeaderStyle(formatButtonVisible: false),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 240),
                        child: const Text(
                          "Morning",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 2.7,
                          children: [
                            doctorTimingsData("08:30 AM", mont1, "mon", 1),
                            doctorTimingsData("9:00 AM", mont2, "mon", 2),
                            doctorTimingsData("09:30 AM", mont3, "mon", 3),
                            doctorTimingsData("10:30 AM", mont4, "mon", 4),
                          ],
                        ),
                      ),
                      
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 240),
                        child: const Text(
                          "Evening",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          childAspectRatio: 2.7,
                          children: [
                            doctorTimingsData("08:30 PM", evet1, "eve", 1),
                            doctorTimingsData("9:00 PM", evet2, "eve", 2),
                            doctorTimingsData("09:30 PM", evet3, "eve", 3),
                            doctorTimingsData("10:30 PM", evet4, "eve", 4),
                          ],
                        ),
                      ),
                      showappbutton
                          ? InkWell(
                              onTap: () async {
                                if (_selectedDay != null) {
                                  setState(() {
                                    showappbutton = false;
                                  });
                                  try {
                                    await _doctorService
                                        .bookAppointment(
                                            snapshot.data!.doctorname!,
                                            _appointmentDate,
                                            _selectedTime)
                                        .then((value) =>
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Appointment Has been made with the doctor")),
                                            ));
                                    setState(() {
                                      showappbutton = true;
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Error Occured")),
                                    );
                                    setState(() {
                                      showappbutton = true;
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Select date for appointment.")),
                                  );
                                }
                                print(_selectedTime + _appointmentDate);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 54,
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade400,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x17000000),
                                      offset: Offset(0, 15),
                                      blurRadius: 15,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'Make An Appointment',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Some error occure'));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Widget doctorTimingsData(
      String time, bool isSelected, String shift, int timezone) {
    return isSelected
        ? InkWell(
            onTap: (() {
              if (shift == "mon") {
                if (timezone == 1) {
                  setState(() {
                    mont1 = true;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                  });
                } else if (timezone == 2) {
                  setState(() {
                    mont1 = false;
                    mont2 = true;
                    mont3 = false;
                    mont4 = false;
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                  });
                } else if (timezone == 3) {
                  setState(() {
                    mont1 = false;
                    mont2 = false;
                    mont3 = true;
                    mont4 = false;
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                  });
                } else {
                  setState(() {
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = true;
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                  });
                }
              } else {
                if (timezone == 1) {
                  setState(() {
                    evet1 = true;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                  });
                } else if (timezone == 2) {
                  setState(() {
                    evet1 = false;
                    evet2 = true;
                    evet3 = false;
                    evet4 = false;
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                  });
                } else if (timezone == 3) {
                  setState(() {
                    evet1 = false;
                    evet2 = false;
                    evet3 = true;
                    evet4 = false;
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                  });
                } else {
                  setState(() {
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = true;
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                  });
                }
              }
              checkTime();
            }),
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 2),
                    child: const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    child: Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: (() {
              if (shift == "mon") {
                if (timezone == 1) {
                  setState(() {
                    mont1 = true;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                  });
                } else if (timezone == 2) {
                  setState(() {
                    mont1 = false;
                    mont2 = true;
                    mont3 = false;
                    mont4 = false;
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                  });
                } else if (timezone == 3) {
                  setState(() {
                    mont1 = false;
                    mont2 = false;
                    mont3 = true;
                    mont4 = false;
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                  });
                } else {
                  setState(() {
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = true;
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                  });
                }
              } else {
                if (timezone == 1) {
                  setState(() {
                    evet1 = true;
                    evet2 = false;
                    evet3 = false;
                    evet4 = false;
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                  });
                } else if (timezone == 2) {
                  setState(() {
                    evet1 = false;
                    evet2 = true;
                    evet3 = false;
                    evet4 = false;
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                  });
                } else if (timezone == 3) {
                  setState(() {
                    evet1 = false;
                    evet2 = false;
                    evet3 = true;
                    evet4 = false;
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                  });
                } else {
                  setState(() {
                    evet1 = false;
                    evet2 = false;
                    evet3 = false;
                    evet4 = true;
                    mont1 = false;
                    mont2 = false;
                    mont3 = false;
                    mont4 = false;
                  });
                }
              }
              checkTime();
            }),
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              decoration: BoxDecoration(
                color: const Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 2),
                    child: const Icon(
                      Icons.access_time,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 2),
                    child: Text(
                      time,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
