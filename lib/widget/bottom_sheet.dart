import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ussd_bank_codes/utils/image_paths.dart/image_path.dart';

class Custom {
  static sheet(
    BuildContext context, {
    required String code,
    bool canMakePhoneCall = false,
  }) {
    String inputCode = '';
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          cursorColor: Colors.green,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            inputCode = code.replaceAll("pin", value);
                            // ignore: avoid_print
                            // print("Input code: $inputCode");
                          },
                          decoration: InputDecoration(
                              hintText: "Enter pin",
                              hintStyle: GoogleFonts.mulish(fontSize: 10),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              prefixIconConstraints: const BoxConstraints(
                                  maxWidth: 50,
                                  maxHeight: 50,
                                  minHeight: 20,
                                  minWidth: 20),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Image.asset(
                                  ImageName.search,
                                  width: 20,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          _launchPhoneCode(code: inputCode);
                          Navigator.pop(context);
                          //   print("SECOND: $inputCode");
                          //   if (canMakePhoneCall == true) {
                          //     _launchPhoneCode(code: inputCode);
                          //   } else {
                          //     showModalBottomSheet(
                          //         backgroundColor: Colors.transparent,
                          //         isScrollControlled: true,
                          //         isDismissible: true,
                          //         context: context,
                          //         builder: (context) {
                          //           return Container(
                          //             height: MediaQuery.of(context).size.height *
                          //                 0.2,
                          //             decoration: const BoxDecoration(
                          //                 color: Colors.white,
                          //                 borderRadius: BorderRadius.only(
                          //                     topRight: Radius.circular(20),
                          //                     topLeft: Radius.circular(20))),
                          //             child: Center(
                          //               child: TextOf(
                          //                   text: "An error occured!", size: 15),
                          //             ),
                          //           );
                          //         });
                          //   }
                          // Custom.sheet(context);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green.withOpacity(0.1),
                          radius: 20,
                          child: ImageIcon(
                            AssetImage(ImageName.call),
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  static Future<void> _launchPhoneCode({required String code}) async {
    final Uri phonrCode = Uri(scheme: "tel", path: code);
    await launchUrl(phonrCode);
  }
}
