// import 'package:bauxite_admin_app/customs/custom_text.dart';
// import 'package:bauxite_admin_app/services/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class AutoCompleteWidget<T> extends StatelessWidget {
//   const AutoCompleteWidget({super.key});
//   static AppColors appColors = AppColors();
//   @override
//   Widget build(BuildContext context) {
//     return Autocomplete(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return [];
//         }
//         return getCus.customerAll.where((T option) {
//           return option.name!
//               .toLowerCase()
//               .contains(textEditingValue.text.toLowerCase());
//         });
//       },
//       displayStringForOption: (CustomerModel data) =>
//           '${data.name ?? ''} ${data.phone ?? ''}',
//       fieldViewBuilder:
//           (context, textEditingController, focusNode, onFieldSubmitted) {
//         return CustomFieldText(
//           controller: nameT,
//           appColor: appColor,
//           hintText: 'customer_name',
//           focusNode: focusNode,
//           validator: (v) {
//             if (nameT.text.trim().isEmpty) {
//               return 'please_enter_field'.tr;
//             }
//             return null;
//           },
//           onChange: (v) {
//             textEditingController.text = v;
//           },
//         );
//       },
//       optionsViewBuilder: (context, onSelected, options) {
//         return ListView.builder(
//             itemCount: options.length,
//             itemBuilder: (context, index) {
//               return Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(blurRadius: 2, color: appColors.grey)
//                       ],
//                       color: appColors.white,
//                     ),
//                     child: Material(
//                       child: ListTile(
//                         onTap: () {
//                           onSelected.call(options.toList()[index]);
//                         },
//                         subtitle: CustomText(
//                           text: options.toList()[index].name ?? '',
//                           color: appColors.black,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13,
//                         ),
//                         title: CustomText(
//                           text: options.toList()[index].phone ?? '',
//                           fontWeight: FontWeight.w600,
//                           color: appColors.black,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             });
//       },
//       onSelected: (selection) {
//         debugPrint('You just selected $selection');
//         nameT.text = selection.name ?? '';
//         phoneT.text = selection.phone ?? '';
//         cardInfoT.text = selection.cardInfo ?? '';
//         nationalityT.text = selection.nationality ?? '';
//         gender = selection.gender ?? 'male';
//         setState(() {});
//       },
//     );
//   }
// }
