import 'package:bmi_calcultor/calculator_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import '../components/card_content.dart';
import '../constants.dart';
import 'resultPage.dart';
import '../components/bottom_button.dart';
import '../components/round_iconButton.dart';

enum Gender{
  male,
  female
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Gender? selectedGender;
  int height=180;
  int weight=60;
  int age=19;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('BMICalculator'),
     ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
         Expanded(
             child: Row(
               children: [
                 Expanded(
                   child: ReusableCard(
                     onPress: (){
                       setState(() {
                         selectedGender = Gender.male;
                       });
                     },
                     color: selectedGender == Gender.male ? kActiveCardColor : kInactiveCardColor,
                     cardChild: CardContent(
                       icon: Icons.male,
                       text: 'MALE',
                     ) ,
                   ),
                 ),
                 Expanded(
                   child: ReusableCard(
                     onPress: (){
                       setState(() {
                         selectedGender = Gender.female;
                       });
                     },
                     color: selectedGender == Gender.female ? kActiveCardColor : kInactiveCardColor,
                     cardChild: CardContent(
                       icon: Icons.female,
                       text: 'FEMALE',
                     )  ,
                   ),
                 ),
               ],
             ),
         ),
         Expanded(
             child: ReusableCard(
               color: kActiveCardColor,
               cardChild: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     'HEIGHT',
                     style: kTextStyle,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                     textBaseline: TextBaseline.alphabetic,
                     children: [
                       Text(
                         height.toString(),
                         style: kNumberTextStyle,
                       ),
                       Text(
                         'cm',
                         style: kTextStyle,
                       )
                     ],
                   ),
                   SliderTheme(
                     data: SliderTheme.of(context).copyWith(
                       thumbColor: Color(0xffeb1555),
                       activeTrackColor: Colors.white,
                       overlayColor: Color(0x29eb1555),
                       thumbShape:
                         RoundSliderThumbShape(enabledThumbRadius: 12.0)
                     ),
                     child: Slider(
                         value: height.toDouble(),
                         min: 120.0,
                         max: 220.0,
                         inactiveColor: Color(0xff8d8e98),
                         onChanged: (double newValue){
                            setState(() {
                              height=newValue.toInt();
                            });
                         },
                     ),
                   )
                 ],
               ),
             ),
         ),
         Expanded(
             child: Row(
               children: [
                 Expanded(
                     child: ReusableCard(
                       color: kActiveCardColor,
                       cardChild: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             'WEIGHT',
                             style: kTextStyle,
                           ),
                           Text(
                             weight.toString(),
                             style: kNumberTextStyle,
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                  onPress: (){
                                  setState(() {
                                          weight--;
                                       });
                                         },
                                 ),
                               SizedBox(
                                 width: 10.0,
                               ),
                               RoundIconButton(
                                 icon: FontAwesomeIcons.plus,
                                 onPress: (){
                                   setState(() {
                                     weight++;
                                   });
                                 },
                               ),
                             ],
                           )
                         ],
                       ),
                     ),
                 ),
                 Expanded(
                   child: ReusableCard(
                       color: kActiveCardColor,
                     cardChild: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           'AGE',
                           style: kTextStyle,
                         ),
                         Text(
                           age.toString(),
                           style: kNumberTextStyle,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             RoundIconButton(
                               icon: FontAwesomeIcons.minus,
                               onPress: (){
                                 setState(() {
                                   age--;
                                 });
                               },
                             ),
                             SizedBox(
                               width: 10.0,
                             ),
                             RoundIconButton(
                               icon: FontAwesomeIcons.plus,
                               onPress: (){
                                 setState(() {
                                   age++;
                                 });
                               },
                             ),
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
            onTap: (){
            CalculatorBrain clc=CalculatorBrain(weight,height);

            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> ResultPage(
                bmi: clc.calculateBMI(),
                result: clc.getResult(),
                interpretation: clc.getInterpretation(),
              ),
            )
            );
          },
            text: 'CALCULATE',
          ),
        ],
      ),
      );
  }
}
