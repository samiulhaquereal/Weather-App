import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:abahaoya/controller/global_controller.dart';
import 'package:abahaoya/utils/custom_colors.dart';
import 'package:abahaoya/widgets/header_widget.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
                          child: Obx(()=>Image.asset("assets/weather/${globalController.getIcon()}.png",
                              height: 80,
                              width: 10,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: CustomColors.dividerLine,
                        ),
                        SizedBox(width: 50,),
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
                    Padding(
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width -280),
                        child: Text('${globalController.getMain()}',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.right,)),
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
                                "${globalController.getHumidity().toString()}%",
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
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              color: CustomColors.cardColor,
                            ),
                            margin: EdgeInsets.only(left: 20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SUNRISE'),
                                  SizedBox(height: 5,),
                                  Text('${globalController.getSunriseTime()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 10,),
                                  Text('SUNSET'),
                                  SizedBox(height: 5,),
                                  Text('${globalController.getSunsetTime()}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30,),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 130,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColors.cardColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('VISIBILITY'),
                                  SizedBox(height: 5,),
                                  Text('${globalController.getVisibility()} km',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          margin:
                          const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
                          child: const Text(
                            "Comfort Level",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 180,
                          child: Column(
                            children: [
                              Center(
                                child: SleekCircularSlider(
                                    min: 0,
                                    max: 100,
                                    initialValue: globalController.getHumidity(),
                                    appearance: CircularSliderAppearance(
                                        customWidths: CustomSliderWidths(
                                            handlerSize: 0, trackWidth: 12, progressBarWidth: 12),
                                        infoProperties: InfoProperties(
                                            bottomLabelText: "Humidity",
                                            bottomLabelStyle: const TextStyle(
                                                letterSpacing: 0.1, fontSize: 14, height: 1.5)),
                                        animationEnabled: true,
                                        size: 140,
                                        customColors: CustomSliderColors(
                                            hideShadow: true,
                                            trackColor:
                                            CustomColors.firstGradientColor.withAlpha(100),
                                            progressBarColors: [
                                              CustomColors.firstGradientColor,
                                              CustomColors.secondGradientColor
                                            ])),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(children: [
                                      const TextSpan(
                                          text: "Feels Like: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              height: 0.8,
                                              color: CustomColors.textColorBlack,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: "${globalController.getFeelsLike()}°",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              height: 0.8,
                                              color: CustomColors.textColorBlack,
                                              fontWeight: FontWeight.w400))
                                    ]),
                                  ),
                                  Container(
                                    height: 25,
                                    margin: const EdgeInsets.only(left: 40, right: 40),
                                    width: 1,
                                    color: CustomColors.dividerLine,
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      const TextSpan(
                                          text: "Pressure: ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              height: 0.8,
                                              color: CustomColors.textColorBlack,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: "${globalController.getPressure()} hPa",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              height: 0.8,
                                              color: CustomColors.textColorBlack,
                                              fontWeight: FontWeight.w400))
                                    ]),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
            ],
          )
                  ],
                ),
              )),
      ),
    );
  }
}
