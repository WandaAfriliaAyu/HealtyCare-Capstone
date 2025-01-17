import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthy_care/util/bottom_button.dart';
import 'package:healthy_care/util/calculate_brain.dart';
import 'package:healthy_care/constants.dart';
import 'package:healthy_care/util/icon_content.dart';
import 'package:healthy_care/util/reusable_card.dart';
import 'package:healthy_care/util/round_icon_button.dart';
import 'result.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 60;
  int age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BMI CALCULATOR'),
        elevation: 8.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: BoxContainer(
                            onPress: () {
                              setState(() {
                                selectedGender = Gender.male;
                              });
                            },
                            color: selectedGender == Gender.male
                                ? kActiveCardColour
                                : kInactiveCardColour,
                            cardChild: IconContents(
                              icon: FontAwesomeIcons.mars,
                              character: 'MALE',
                            ),
                          ),
                        ),
                        Expanded(
                          child: BoxContainer(
                            onPress: () {
                              setState(() {
                                selectedGender = Gender.female;
                              });
                            },
                            color: selectedGender == Gender.female
                                ? kActiveCardColour
                                : kInactiveCardColour,
                            cardChild: IconContents(
                              icon: FontAwesomeIcons.venus,
                              character: 'FEMALE',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: BoxContainer(
                      color: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'HEIGHT',
                            style: kLabelTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                height.toString(),
                                style: kNumberTextStyle,
                              ),
                              Text(
                                'cm',
                                style: kLabelTextStyle,
                              )
                            ],
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              inactiveTrackColor: Color(0xFF8D8E98),
                              activeTrackColor: Colors.white,
                              thumbColor: Color(0xFFEB1555),
                              overlayColor: Color(0x29EB1555),
                              thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                              overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0),
                            ),
                            child: Slider(
                              value: height.toDouble(),
                              min: 120.0,
                              max: 220.0,
                              onChanged: (double newValue) {
                                setState(() {
                                  height = newValue.round();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: BoxContainer(
                            color: kActiveCardColour,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'WEIGHT',
                                  style: kLabelTextStyle,
                                ),
                                Text(
                                  weight.toString(),
                                  style: kNumberTextStyle,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RoundIconButton(
                                        icon: FontAwesomeIcons.minus,
                                        onPressed: () {
                                          setState(() {
                                            weight--;
                                          });
                                        }),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    RoundIconButton(
                                      icon: FontAwesomeIcons.plus,
                                      onPressed: () {
                                        setState(() {
                                          weight++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: BoxContainer(
                            color: kActiveCardColour,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'AGE',
                                  style: kLabelTextStyle,
                                ),
                                Text(
                                  age.toString(),
                                  style: kNumberTextStyle,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RoundIconButton(
                                      icon: FontAwesomeIcons.minus,
                                      onPressed: () {
                                        setState(
                                              () {
                                            age--;
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    RoundIconButton(
                                        icon: FontAwesomeIcons.plus,
                                        onPressed: () {
                                          setState(() {
                                            age++;
                                          });
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomButton(
                    buttonTitle: 'CALCULATE',
                    onTap: () {
                      CalculatorBrain calc =
                      CalculatorBrain(height: height, weight: weight);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsPage(
                            bmiResult: calc.calculateBMI(),
                            resultText: calc.getResult(),
                            interpretation: calc.getInterpretation(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
