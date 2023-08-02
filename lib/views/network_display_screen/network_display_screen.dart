// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ussd_bank_codes/model/network_model.dart';
import 'package:ussd_bank_codes/services/network_services.dart';
import 'package:ussd_bank_codes/utils/image_paths.dart/image_path.dart';
import 'package:ussd_bank_codes/widget/bottom_sheet.dart';
import 'package:ussd_bank_codes/widget/spacing.dart';
import 'package:ussd_bank_codes/widget/textts.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  Future<void> _launchPhoneCode({required String code}) async {
    final Uri phonrCode = Uri(scheme: "tel", path: code);
    await launchUrl(phonrCode);
  }

  bool _canMakePhoneCall = false;

  String inputPin = "";

  List<Positioned> stackItems = [
    Positioned(
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(image: AssetImage(ImageName.glo))),
      ),
    ),
    Positioned(
      left: 20,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(image: AssetImage(ImageName.etisalat))),
      ),
    ),
    Positioned(
      left: 40,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(image: AssetImage(ImageName.airtel))),
      ),
    ),
    Positioned(
      left: 60,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(image: AssetImage(ImageName.mtn))),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextOf(
          text: "USSD Codes",
          size: 14,
          color: Colors.white,
          weight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                TextOf(
                  text: "Select network",
                  size: 13,
                  weight: FontWeight.w700,
                ),
              ]),
              Expanded(
                child: FutureBuilder(
                    future: InvokeJSON.networkCodes(context),
                    builder:
                        (context, AsyncSnapshot<List<NetworkModel>> snapshot) {
                      List<Widget> networkData =
                          //null here
                          List.generate(snapshot.data?.length ?? 0, (index) {
                        stackItems.reversed;
                        NetworkModel data = snapshot.data![index];

                        return Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 90,
                                      child: Stack(children: stackItems),
                                    ),
                                    const XMargin(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextOf(
                                          text: data.description,
                                          size: 12,
                                          weight: FontWeight.w800,
                                        ),
                                        const YMargin(5),
                                        TextOf(
                                          text: data.code,
                                          size: 10,
                                          color: Colors.grey.shade500,
                                          weight: FontWeight.w700,
                                        )
                                      ],
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              minimumSize:
                                                  MaterialStateProperty.all<Size>(
                                                      const Size(40, 40)),
                                              maximumSize:
                                                  MaterialStateProperty.all<Size>(
                                                      const Size(40, 40)),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
                                              fixedSize: MaterialStateProperty.all<Size>(const Size(0, 20)),
                                              elevation: MaterialStateProperty.all<double>(0),
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade200),
                                              padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),
                                          onPressed: () {
                                            canLaunchUrl(Uri(
                                                    scheme: "tel",
                                                    path: data.code))
                                                .then((value) {
                                              if (value == true) {
                                                setState(() {
                                                  _canMakePhoneCall = value;
                                                });
                                              }
                                            });
                                            if (data.code.contains("pin")) {
                                              Custom.sheet(context,
                                                  code: data.code,
                                                  canMakePhoneCall:
                                                      _canMakePhoneCall);
                                            } else {
                                              _launchPhoneCode(code: data.code);
                                            }
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Colors.green.withOpacity(0.1),
                                            radius: 20,
                                            child: ImageIcon(
                                              AssetImage(ImageName.call),
                                              color: Colors.green,
                                            ),
                                          ),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Column(
                                  children: networkData,
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      // else if (snapshot.hasError) {
                      //   return Center(
                      //     child: TextOf(text: "Sorry!\nAn error occured.", size: 20),
                      //   );
                      // }
                      else {
                        return Center(
                          child: TextOf(text: "Loading...", size: 15),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
