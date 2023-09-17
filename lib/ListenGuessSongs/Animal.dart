import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kids/utils/model.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'Alphabet.dart';



class AnimalsSong extends StatefulWidget{

  @override
  State<AnimalsSong> createState() => _AnimalsSongState();
}
List<Numbermodel> animallist = ANIMAL1();

class _AnimalsSongState extends State<AnimalsSong> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPressed = false;
  Color istrue = Colors.green;
  Color isWrong = Colors.red;
  Color btnColor = Colors.blue;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    PageController _controller = new PageController(initialPage: 0);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Color(0xFFFEF7F0),
            title: Center(child: Text('Animal',style: TextStyle( color: Colors.black,fontFamily: "arlrdbd"),
            ),
            )
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (page){
                    isPressed = false;
                  },
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: alphasongs2.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: Center(
                        //     child: Text("Question ${index + 1}/${questions.length}",
                        //       style: TextStyle(
                        //           color: Colors.redAccent,
                        //           fontWeight: FontWeight.w300,
                        //           fontSize: 28.0,
                        //           fontFamily: "arlrdbd"),
                        //     ),
                        //   ),
                        // ),
                        // Divider(
                        //   color: Colors.redAccent,
                        //   height: 8.0,
                        //   thickness: 1.0,
                        // ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Image.asset("assets/images/volume.png"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(animallist[index].Text,style: TextStyle(color: Colors.black,fontSize: 23.0,fontFamily: "arlrdbd"),),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Expanded(
                          child: GridView.count(
                            padding: EdgeInsets.all(50),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 15,
                            crossAxisCount: 2,
                            physics: NeverScrollableScrollPhysics(),
                            primary: false,
                            children: [
                              for(int i = 0;i<animalsongs2 [index].answer.length;i++)
                                MaterialButton(
                                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  elevation: 5.0,
                                  height: 10,
                                  minWidth: double.infinity,
                                  color: isPressed ? animalsongs2[index].answer.entries.toList()[i].value?istrue:isWrong:Colors.white,
                                  padding: EdgeInsets.symmetric(vertical:10.0),
                                  onPressed: isPressed?(){}
                                      :(){
                                    if(animalsongs2[index].answer.entries.toList()[i].value){
                                      setState(() {
                                        isPressed = true;
                                      }
                                      );
                                      score +=  1;
                                      print(score);
                                      MotionToast.success(
                                          borderRadius: 5,
                                          animationDuration: Duration(seconds: 3),
                                          title: Text("Your Answer is Right",style: TextStyle(fontSize: 20),),
                                          iconType: IconType.cupertino, description: Text("null"),
                                      ).show(context);
                                    }else{
                                      setState(() {
                                        isPressed = true;
                                      }
                                      );
                                      MotionToast.error(
                                          borderRadius: 5,
                                          animationDuration: Duration(seconds: 3),
                                          title: Text("Your Answer is Wrong",style: TextStyle(fontSize: 20),),
                                          iconType: IconType.cupertino, description: Text("null"),
                                      ).show(context);
                                    }
                                  },
                                  child: Image(
                                    image: AssetImage(animalsongs2[index].answer.keys.toList()[i]),height: 100,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: ()=>flutterTts.speak(animallist[index].Text),
                                  child: Image.asset('assets/images/11MaskGroup3.png',alignment: Alignment.topCenter,)),
                              Center(
                                  child: ListTile(
                                    trailing: InkWell(
                                      onTap:  isPressed ? index + 1== animalquestion.length
                                          ?(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultSrceen(score)));
                                      }
                                          :(){
                                        _controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.linear);
                                        flutterTts.speak(animallist[index  +1].Text);

                                      }:null,
                                      child: Image(
                                        image: AssetImage('assets/images/11MaskGroup5.png'),
                                      ),
                                    ),
                                    leading: InkWell(
                                      onTap: isPressed ? index - 1== questions.length
                                          ?(){}
                                          :(){
                                        _controller.previousPage(duration: Duration(microseconds: 500), curve: Curves.linear);
                                        flutterTts.speak(animallist[index-1].Text);
                                      }:null,
                                      child: Image(
                                        image: AssetImage('assets/images/11MaskGroup4.png'),
                                      ),
                                    ),

                                  )
                              )
                            ]
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
