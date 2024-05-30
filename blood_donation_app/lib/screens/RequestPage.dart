import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart'; // For generating random IDs
import '../models/request_model.dart';
import '../provider/request_provider.dart';
import 'package:intl/intl.dart';

class RequestPage extends ConsumerStatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends ConsumerState<RequestPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _numberOfUnitsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  DateTime? _selectedDate;

  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/header.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
              Positioned(
                left: 320,
                top: 40,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),
                  ),                  
                ),
              ),
              Positioned(
                left: 20,
                top: 65,
                child: Text(
                  'Request',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 110,
                child: Text(
                  'Your request will be displayed to all the donors',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Blood Group',
                        style: TextStyle(fontSize: 25),
                      ),
                      DropdownButtonFormField<String>(
                        value: _bloodGroups.first,
                        items: _bloodGroups.map((String group) {
                          return DropdownMenuItem<String>(
                            value: group,
                            child: Text(group),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _bloodGroupController.text = value!;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your blood group';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Number of Units',
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller: _numberOfUnitsController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of units';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Date',
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller: _dateController,
                        readOnly: true, // Make the field read-only to prevent manual text input
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null && pickedDate != _selectedDate) {
                                setState(() {
                                  _selectedDate = pickedDate;
                                  _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                });
                              }
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Time (HH:MM)',
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller: _timeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid time';
                          }
                          final RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');
                          if (!timeRegex.hasMatch(value)) {
                            return 'Please enter the time in HH:MM format';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Gender',
                        style: TextStyle(fontSize: 25),
                      ),
                      DropdownButtonFormField<String>(
                        value: _genders.first,
                        items: _genders.map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _genderController.text = value!;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your gender';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Hospital Name',
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller: _hospitalNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the hospital name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Location',
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length != 11) {
                            return 'Phone number must be 11 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 239, 68, 96), 
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          minimumSize: Size(300, 40),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final requestId = Uuid().v4();
        final date = DateTime.parse(_dateController.text);
        final time = TimeOfDay.fromDateTime(DateTime.parse('1970-01-01 ${_timeController.text}'));
        final request = Request(
          userId: currentUser.uid,
          requestId: requestId,
          name: _nameController.text,
          bloodGroup: _bloodGroupController.text,
          numberOfUnits: int.parse(_numberOfUnitsController.text),
          date: date,
          time: time,
          gender: _genderController.text,
          hospitalName: _hospitalNameController.text,
          location: _locationController.text,
          phoneNumber: _phoneNumberController.text,
        );
        ref.read(requestNotifierProvider.notifier).addRequest(request);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data successfully added'),
          ),
        );

        _formKey.currentState?.reset();
        _nameController.clear();
        _bloodGroupController.clear();
        _numberOfUnitsController.clear();
        _dateController.clear();
        _timeController.clear();
        _genderController.clear();
        _hospitalNameController.clear();
        _locationController.clear();
        _phoneNumberController.clear();
      }
    }
  }
}


