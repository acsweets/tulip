// import 'package:flutter/material.dart';
//
// class SimpleInput extends StatelessWidget {
//   const SimpleInput({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextField(
//         controller: _controller,
//         maxLines: 1,
//         style: TextStyle(
//             fontSize: _fontSize,
//             color: Colors.lightBlue,
//             backgroundColor: Colors.white),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           hintText: widget.config.hint,
//           hintStyle: TextStyle(color: Colors.black26, fontSize: _fontSize),
//           contentPadding: EdgeInsets.only(left: 14.0, top: -_fontSize),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: const BorderSide(color: Colors.white),
//             borderRadius:
//             BorderRadius.only(topLeft: _radius, bottomLeft: _radius),
//           ),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: const BorderSide(color: Colors.white),
//             borderRadius:
//             BorderRadius.only(topLeft: _radius, bottomLeft: _radius),
//           ),
//         ),
//         onChanged: (str) {
//           widget.onChanged?.call(str);
//         },
//         onTap: widget.onTap,
//       );
//     );
//   }
// }
