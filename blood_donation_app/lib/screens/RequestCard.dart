import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/request_model.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  const RequestCard({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 90,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 235, 238),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        request.bloodGroup,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 239, 68, 68),
                        ),
                      ),
                      //SizedBox(height: 5),
                      Text(
                        '${request.numberOfUnits} Unit',
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -5,
                  left: -60,
                  right: 0,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 30,
                    height: 30,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Positioned(
                  top: 3,
                  left: -60,
                  right: 0,
                  child: Icon(
                    Icons.add, 
                    color: Colors.white, 
                    size: 15
                  )
                ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${request.name}, ${request.gender}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, color: Colors.grey, size: 20),
                          SizedBox(width: 5),
                          Text(
                            '${request.age}yr old',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey, size: 20),
                          SizedBox(width: 5),
                          Text(
                            request.location,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Time Limit: ${DateFormat('dd/MM/yyyy').format(request.date)}',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                request.accepted == null || request.accepted == false ? Icons.cancel : Icons.check_circle,
                color: request.accepted == null || request.accepted == false ? Colors.red : Colors.green,
              ),
              onPressed: () {
                // Add functionality here if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}

