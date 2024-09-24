// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';
//
// import '../Networking/Dio.dart';
//
// class home extends StatelessWidget {
//   const home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('home'),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () {
//             networkdata.getData('/v2/top-headlines', {
//               'country': 'eg',
//               'apiKey': '2a538ada78074a39942442ac4c7be731'
//             }).then((value) {
//               print(value?.data.toString());
//             });
//           },
//         ),
//         body: BuildListView(context));
//   }
// }
//
// Widget BuildListView(context) {
//   return ListView.builder(
//     itemBuilder: (BuildContext context, int index) {
//       build_articals(context, index);
//     },
//     itemCount: 10,
//   );
// }
//
// Widget build_articals(context, index) {
//   var dara = networkdata.getData('/v2/top-headlines',
//       {'country': 'eg', 'apiKey': '2a538ada78074a39942442ac4c7be731'});
//   return Row(
//     children: [
//       Container(
//           width: 120,
//           height: 140,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             image: DecorationImage(
//                 fit: BoxFit.fill,
//                 image: NetworkImage(
//                   '$dara[urlToImage][$index]',
//                 )),
//           )),
//       SizedBox(
//         width: 20,
//       ),
//       Expanded(
//         child: Container(
//           height: 100,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 maxLines: 3,
//                 '$dara[" title"][$index]',
//                 style: TextStyle(overflow: TextOverflow.ellipsis),
//               ),
//               Text(
//                 '$dara["description"][$index]',
//                 style: TextStyle(color: Colors.grey),
//               )
//             ],
//           ),
//         ),
//       )
//     ],
//   );
// }
