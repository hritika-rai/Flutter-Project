import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donor_model.dart';
import '../provider/donor_provider.dart';
import 'DonorCard.dart'; 

class FindDonor extends ConsumerStatefulWidget {
  @override
  _FindDonorPageState createState() => _FindDonorPageState();
}

class _FindDonorPageState extends ConsumerState<FindDonor> {
  String? _bloodGroup;
  String? _location;
  List<Donor>? _donors;
  bool _isLoading = false;

  final List<String> _bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  final List<String> _locations = [
    'Karachi', 'Lahore', 'Islamabad', 'Rawalpindi', 'Peshawar', 
    'Quetta', 'Multan', 'Faisalabad', 'Sialkot', 'Hyderabad'
  ];

  final _formKey = GlobalKey<FormState>();

  void _findDonors() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final donors = await ref
            .read(donateNotifierProvider.notifier)
            .loadDonorsByBloodGroupAndLocation('currentUserId', _bloodGroup!, _location!);
        setState(() {
          _donors = donors;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Donor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _bloodGroup,
                decoration: InputDecoration(
                  labelText: 'Select Blood Group',
                  border: OutlineInputBorder(),
                ),
                items: _bloodGroups.map((String bloodGroup) {
                  return DropdownMenuItem<String>(
                    value: bloodGroup,
                    child: Text(bloodGroup),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _bloodGroup = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a blood group';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _location,
                decoration: InputDecoration(
                  labelText: 'Select Location',
                  border: OutlineInputBorder(),
                ),
                items: _locations.map((String location) {
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _findDonors,
                      child: Text('Search Donors'),
                    ),
              SizedBox(height: 16.0),
              _donors == null
                  ? Text('No donors found')
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _donors!.length,
                        itemBuilder: (context, index) {
                          final donor = _donors![index];
                          return DonorCard(donor: donor);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
