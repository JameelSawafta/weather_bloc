import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/cubit/weather_cubit.dart';

class Home extends StatelessWidget {
  Home({super.key});

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WeatherApp"),),
      body: BlocBuilder<WeatherCubit,WeatherState>(builder: (BuildContext context, state) {
        if (state is WeatherInitial){
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enter City Name",
                    style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide( width: 2.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    BlocProvider.of<WeatherCubit>(context).getWeather(cityName: textEditingController.text);
                  },
                      child: Text("Enter",
                        style: TextStyle(fontSize: 18),),
                    style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(200, 50))),
                  ),
                ],
              ),
            ),
          );
        }
        else if (state is WeatherLoading){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(state is WeatherDone){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network("https:${state.weather["current"]["condition"]["icon"].toString()}"),
                SizedBox(height: 10,),
                Flexible(
                  child: Text(
                      "${state.weather["location"]["name"].toString()} / ${state.weather["location"]["country"].toString()}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Text(
                    "${state.weather["current"]["temp_c"].toString()} °C",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10,),
                FilledButton(onPressed: (){
                  BlocProvider.of<WeatherCubit>(context).gotoInitState();
                  textEditingController.text = "";
                },
                    child: Text("Home",
                      style: TextStyle(fontSize: 18),),
                  style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(200, 50))),
                )
              ],
            )),
          );
        }
        else if(state is WeatherError){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${state.error.toString()}",
                      style: TextStyle(fontSize: 20),),
                    SizedBox(height: 10,),
                    FilledButton(onPressed: (){
                      BlocProvider.of<WeatherCubit>(context).gotoInitState();
                      textEditingController.text = "";
                    },
                        child: Text("Home",
                          style: TextStyle(fontSize: 18),),
                      style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(200, 50))),
                    )
                  ],
                ),

            ),
          );
        }
        else{
          return Text("error");
        }

      },

      ),
    );

  }
}
