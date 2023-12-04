import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abahaoya/controller/global_controller.dart';
import 'package:abahaoya/utils/custom_colors.dart';
import 'package:abahaoya/widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call
  final GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/clouds.png",
                    height: 200,
                    width: 200,
                  ),
                  const CircularProgressIndicator()
                ],
              ))
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),
                    // for our current temp ('current')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Image.asset("assets/weather/${globalController.getIcon()}.png",
                            height: 80,
                            width: 10,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: CustomColors.dividerLine,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "${globalController.getTemp()}°",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 68,
                                  color: CustomColors.textColorBlack,
                                ),
                              ),
                              TextSpan(
                                text: "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: CustomColors.cardColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.asset("assets/icons/windspeed.png"),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: CustomColors.cardColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.asset("assets/icons/clouds.png"),
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: CustomColors.cardColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.asset("assets/icons/humidity.png"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 60,
                              child: Text(
                                "${globalController.getWind()} km/h , ${globalController.getwindDirection()}",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              width: 60,
                              child: Text(
                                "${globalController.getClouds()}%",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              width: 60,
                              child: Text(
                                "${globalController.getHumidity()}%",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
      ),
    );
  }
}
