// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../models/notification_model.dart';

// class NotificationCard extends StatelessWidget {
//   final Notifications notification;
//   const NotificationCard({Key? key, required this.notification}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Color.fromARGB(255, 255, 250, 250),
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   height: 90,
//                   width: 75,
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 255, 235, 238),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         notification.bloodGroup,
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 239, 68, 68),
//                         ),
//                       ),
//                       Text(
//                         '${notification.numberOfUnits} Unit',
//                         style: TextStyle(fontSize: 15, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: -5,
//                   left: -60,
//                   right: 0,
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     width: 30,
//                     height: 30,
//                     alignment: Alignment.topCenter,
//                   ),
//                 ),
//                 Positioned(
//                   top: 3,
//                   left: -60,
//                   right: 0,
//                   child: Icon(
//                     Icons.add, 
//                     color: Colors.white, 
//                     size: 15
//                   )
//                 ),
//               ],
//             ),
//             SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${notification.name}, ${notification.gender}',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.people, color: Colors.grey[600], size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             '${notification.age}yr old',
//                             style: TextStyle(color: Colors.grey[600], fontSize: 18),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Icon(Icons.location_on, color: Colors.grey[600], size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             notification.location,
//                             style: TextStyle(color: Colors.grey[600], fontSize: 18),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Icon(Icons.phone, color: Colors.grey[600], size: 20),
//                           SizedBox(width: 5),
//                           Text(
//                             notification.phoneNumber,
//                             style: TextStyle(color: Colors.grey[600],fontSize: 18),
//                           ),
//                         ],
//                       ),                      
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'Time Limit: ${DateFormat('dd/MM/yyyy').format(notification.timestamp)}',
//                     style: TextStyle(color: Colors.green),
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: Icon(
//                 notification.accepted == null || notification.accepted == false ? Icons.cancel : Icons.check_circle,
//                 color: notification.accepted == null || notification.accepted == false ? Colors.red : Colors.green,
//               ),
//               onPressed: () {
//                 // Add functionality here if needed
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
