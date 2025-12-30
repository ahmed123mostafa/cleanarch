// import 'package:cleanarch/core/bloc/widget/label.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// extension ContextExtensions on BuildContext {
//   double get screenHeight => MediaQuery.of(this).size.height;

//   double get screenWidth => MediaQuery.of(this).size.width;

//   ThemeData get theme => Theme.of(this);

//   TextTheme get textTheme => Theme.of(this).textTheme;

//   bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom != 0;

//   double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;
//   ColorScheme get colorScheme => Theme.of(this).colorScheme;
//   Orientation get orientation => MediaQuery.of(this).orientation;
//   bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';

//   TextDirection get textDirection =>
//       isArabic ? TextDirection.rtl : TextDirection.ltr;
//   TextDirection get oppositeTextDirection =>
//       !isArabic ? TextDirection.rtl : TextDirection.ltr;

//   FocusScopeNode get foucsScopeNode => FocusScope.of(this);

//   void showErrorMessage(String message) {
//     scaffoldMessengerKey.currentState?.clearSnackBars();
//     scaffoldMessengerKey.currentState?.showSnackBar(
//       SnackBar(
//         showCloseIcon: false,

//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         content: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Text(
//                 message,
//                 style: Theme.of(this).textTheme.displaySmall!.copyWith(
//                   color: Colors.red,
//                   fontSize: 20.sp,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const SizedBox(width: 10),
//             const Icon(Icons.error, color: Colors.red),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         behavior: SnackBarBehavior.floating,
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         margin: EdgeInsets.only(bottom: 25, left: 25, right: 25),
//       ),
//     );
//   }

//   void showSuccessMessage(
//     String message, {
//     Color color = Colors.green,
//     IconData icon = Icons.check_circle,
//   }) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       scaffoldMessengerKey.currentState?.showSnackBar(
//         SnackBar(
//           showCloseIcon: false,
//           duration: const Duration(seconds: 2),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           content: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Text(
//                   message,
//                   style: Theme.of(this).textTheme.titleLarge!.copyWith(
//                     color: color,
//                     fontSize: 20.sp,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Icon(icon, color: color),
//             ],
//           ),
//           backgroundColor: Colors.white,
//           behavior: SnackBarBehavior.floating,
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           margin: EdgeInsets.only(
//             bottom: screenHeight * .4,
//             left: 25,
//             right: 25,
//           ),
//         ),
//       );
//     });
//   }

//   void showSuccessDialog(String text) {
//     showDialog(
//       context: this,
//       builder:
//           (_) => AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//             content: Text(
//               text,
//               style: Theme.of(
//                 this,
//               ).textTheme.titleLarge!.copyWith(color: Colors.green),
//               textAlign: TextAlign.center,
//             ),
//             contentPadding: const EdgeInsets.all(20).copyWith(bottom: 40),
//           ),
//     );
//   }

//   void showTopSnackBar({
//     required Widget child,
//     required Color backgroundColor,
//     IconData icon = Icons.error,
//     Duration duration = const Duration(seconds: 2),
//   }) {
//     final overlayEntry = OverlayEntry(
//       builder:
//           (context) => Positioned(
//             left: 16,
//             right: 16,
//             top: MediaQuery.of(context).padding.top + 10,
//             child: Material(
//               color: Colors.transparent,
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: backgroundColor,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(icon, color: Colors.white),
//                     const SizedBox(width: 8),
//                     Expanded(child: child),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//     );

//     Overlay.of(this).insert(overlayEntry);

//     Future.delayed(duration, () {
//       overlayEntry.remove();
//     });
//   }

//   void showLoadingDialog({
//     String? message,
//     bool canPop = false,
//     bool barrierDismissible = false,
//   }) {
//     showDialog(
//       context: this,
//       barrierDismissible: barrierDismissible,
//       builder:
//           (_) => PopScope(
//             canPop: canPop,
//             child: AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const CircularProgressIndicator.adaptive(),
//                   const SizedBox(height: 10),
//                   LocalizedLabel(
//                     text: message ?? "تحميل البيانات",
//                     style: theme.textTheme.titleLarge!,
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//               contentPadding: const EdgeInsets.all(20).copyWith(bottom: 40),
//             ),
//           ),
//     );
//   }
// }