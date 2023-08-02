import 'package:flutter/material.dart';
import 'package:ussd_bank_codes/helpers/alerts.dart';
import 'package:ussd_bank_codes/model/bank_codes.dart';
import 'package:ussd_bank_codes/services/network_services.dart';
import 'package:ussd_bank_codes/utils/image_paths.dart/image_path.dart';
import 'package:ussd_bank_codes/widget/spacing.dart';
import 'package:ussd_bank_codes/widget/textts.dart';
import 'package:url_launcher/url_launcher.dart';

class BanksOptionListScreen extends StatefulWidget {
  static const String banksOptionListScreen = "/banksOptionListScreen";
  const BanksOptionListScreen({super.key});

  @override
  State<BanksOptionListScreen> createState() => _BanksOptionListScreenState();
}

class _BanksOptionListScreenState extends State<BanksOptionListScreen> {
  String inputPin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextOf(
          text: "Available banks",
          size: 14,
          color: Colors.white,
          weight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: FutureBuilder(
              future: InvokeJSON.bankCodes(context),
              builder: (context, AsyncSnapshot<List<BankCode>> snapshot) {
                List<Widget> banksCodekData =
                    List.generate(snapshot.data?.length ?? 0, (index) {
                  BankCode data = snapshot.data![index];
                  return Card(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: NetworkImage(data.logoUrl))),
                                ),
                              ),
                              const XMargin(10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextOf(
                                    text: data.name,
                                    size: 12,
                                    weight: FontWeight.w800,
                                  ),
                                  const YMargin(5),
                                  TextOf(
                                    text: data.ussd,
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
                                  InkWell(
                                    // style: ButtonStyle(
                                    //     minimumSize: MaterialStateProperty.all<Size>(
                                    //         const Size(40, 40)),
                                    //     maximumSize: MaterialStateProperty.all<Size>(
                                    //         const Size(40, 40)),
                                    //     shape:
                                    //         MaterialStateProperty.all<RoundedRectangleBorder>(
                                    //             RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(30))),
                                    //     fixedSize: MaterialStateProperty.all<Size>(
                                    //         const Size(0, 20)),
                                    //     elevation:
                                    //         MaterialStateProperty.all<double>(0),
                                    //     backgroundColor:
                                    //         MaterialStateProperty.all<Color>(
                                    //             Colors.green.shade200),
                                    //     padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),

                                    onTap: () {
                                      if (data.ussd.isEmpty ||
                                          data.ussd == "") {
                                        Alerts.showAlert(
                                            alertType: AlertType.failed,
                                            title: "No code found",
                                            subtitle: "USSD not available for ",
                                            anotherWidget: TextOf(
                                              text: data.name,
                                              size: 11,
                                              color: Colors.white,
                                              weight: FontWeight.w700,
                                            ));
                                      } else {
                                        canLaunchUrl(Uri(
                                                scheme: "tel", path: data.ussd))
                                            .then((value) {
                                          if (value == true) {
                                            _launchPhoneCode(code: data.ussd);
                                          }
                                        });
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
                            children: banksCodekData,
                          )
                        ],
                      ),
                    ),
                  );
                }

                // else if (snapshot.hasError) {
                //   return Center(
                //     child: TextOf(
                //         text: "Sorry!\nAn error occured.", size: 15),
                //   );
                // }

                else {
                  return Center(
                    child: TextOf(text: "Loading...", size: 15),
                  );
                }
              }),
        ),
      ),
    );
  }

  Future<void> _launchPhoneCode({required String code}) async {
    final Uri phonrCode = Uri(scheme: "tel", path: code);
    await launchUrl(phonrCode);
  }
}
