import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_reviewer_application/screens/gamingEventsScreens/services/storage_service.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../collections/gamingEventsCollection.dart';
import '../../custom_form_field_gaming_events.dart';

class AddGameEventForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode gameNameFocusNode;
  final FocusNode tournamentModeFocusNode;
  final FocusNode rewardsFocusNode;
  final FocusNode organizedByFocusNode;
  final FocusNode dateFocusNode;
  final FocusNode timeFocusNode;

  const AddGameEventForm({
    required this.nameFocusNode,
    required this.gameNameFocusNode,
    required this.tournamentModeFocusNode,
    required this.rewardsFocusNode,
    required this.organizedByFocusNode,
    required this.dateFocusNode,
    required this.timeFocusNode,
  });

  @override
  _AddGameEventFormState createState() => _AddGameEventFormState();
}

class _AddGameEventFormState extends State<AddGameEventForm> {
  final _addGameEventFormKey = GlobalKey<FormState>();

  final List<String> tournamentModes = ['Non-Rated','Rated'];
  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("hh:mm a");

  bool _isProcessing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameNameController = TextEditingController();
  final TextEditingController _rewardsController = TextEditingController();
  final TextEditingController _organizedByController = TextEditingController();

  String getName = "";
  String getGameName="";
  String getTournamentMode = "";
  String getRewards = "";
  String getOrganizedBy = "";
  String getDate = "";
  String getTime = "";
  String getEventPosterUrl = "";

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return SingleChildScrollView(
      child: Form(
        key: _addGameEventFormKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 24.0,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height:24.0),
                    const Text(
                      'Create E-Game Event',
                      style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height:24.0),
                    const Text(                                     //Event Name Label
                      'Event Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height:8.0),
                    CustomFormField(                                    //Event Name input field
                      isEnabled: true,
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _nameController,
                      focusNode: widget.nameFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if(value.isEmpty){
                          return 'Name cannot be empty.';
                        }
                        getName = value;
                      },
                      label: 'Event Name',
                      hint: 'Write your Event Name',
                    ),
                    const SizedBox(height:24.0),
                    const Text(                                     //Game Name Label
                      'Game Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height:8.0),
                    CustomFormField(                                    //Game Name input field
                      isEnabled: true,
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _gameNameController,
                      focusNode: widget.gameNameFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if(value.isEmpty){
                          return 'Name cannot be empty.';
                        }
                        getGameName = value;
                      },
                      label: 'Game Name',
                      hint: 'Write your Game Name',
                    ),
                    const SizedBox(height:24.0),
                    const Text(                                     //Tournament Mode Label
                      'Tournament Mode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height:8.0),
                    DropdownButtonFormField(                                       //Tournament Mode dropdown
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      dropdownColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Select a Tournament Mode',
                        fillColor: Colors.black,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.yellowAccent),
                        hintStyle: const TextStyle(
                            color: Colors.grey
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                              width: 2,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                            )
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
                              width: 2,
                            )
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() => getTournamentMode = value.toString());
                      },
                      validator: (value) {
                        if(value == null || value.toString().isEmpty){
                          return 'This source can not be empty.';
                        }
                        getTournamentMode = value.toString();
                      },
                      items: tournamentModes.map((tournamentMode) {
                        return DropdownMenuItem(
                          child: Text(tournamentMode),
                          value: tournamentMode,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height:24.0),
                    const Text(                                     //Rewards Label
                      'Rewards',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height:8.0),
                    CustomFormField(                                    //Rewards input field
                      isEnabled: true,
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _rewardsController,
                      focusNode: widget.rewardsFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        // if(value.isEmpty){
                        //   return 'rewards cannot be empty.';
                        // }
                        getRewards = value;
                      },
                      label: 'Rewards',
                      hint: 'Add Rewards',
                    ),
                    const SizedBox(height:24.0),
                    const Text(                                     //Event Name Label
                      'Organized By',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height:8.0),
                    CustomFormField(                                    //Event Name input field
                      isEnabled: true,
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _organizedByController,
                      focusNode: widget.organizedByFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if(value.isEmpty){
                          return 'Organizer name cannot be empty.';
                        }
                        getOrganizedBy = value;
                      },
                      label: 'OrganizedBy',
                      hint: 'Write Organizers Name or company Name',
                    ),
                    const SizedBox(height:24.0),
                    const Text(                                     //Booking date and time Label
                      'Event Date and Time',
                      style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height:24.0),

                    SizedBox(
                      height: 90.0,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child:
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(                                     //date Label
                                    'Date',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 1,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height:8.0),
                                  Expanded(
                                    child:
                                    DateTimeField(                    //date form
                                      format: dateFormat,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      // dropdownColor: Colors.black,
                                      decoration: InputDecoration(
                                        fillColor: Colors.black,
                                        filled: true,
                                        labelStyle: const TextStyle(color: Colors.yellowAccent),
                                        suffixIcon: const Icon(Icons.calendar_today),
                                        isDense: true,
                                        hintText: "yyyy-MM-dd",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey
                                        ),
                                        errorStyle: const TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.amber,
                                              width: 2,
                                            )
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.amber,
                                            )
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                              color: Colors.redAccent,
                                              width: 2,
                                            )
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Colors.redAccent,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      onShowPicker: (context, currentValue) {
                                        if(currentValue != null){
                                          var format1 = "${currentValue.day}-${currentValue.month}-${currentValue.year}";
                                          // print(format1);
                                        }
                                        return showDatePicker(
                                            context: context,
                                            firstDate: DateTime(1900),
                                            initialDate: currentValue ?? DateTime.now(),
                                            lastDate: DateTime(2100));
                                      },
                                      onChanged: (currentValue) {
                                        if(currentValue != null) {
                                          setState(() =>
                                          getDate =
                                          "${currentValue.day}-${currentValue
                                              .month}-${currentValue.year}");
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child:
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(                                     //time Label
                                    'Time',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 1,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height:8.0),
                                  Expanded(
                                    child:
                                    DateTimeField(
                                      format: timeFormat,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      // dropdownColor: Colors.black,
                                      decoration: InputDecoration(
                                        fillColor: Colors.black,
                                        filled: true,
                                        labelStyle: const TextStyle(color: Colors.yellowAccent),
                                        suffixIcon: const Icon(Icons.calendar_today),
                                        isDense: true,
                                        hintText: "hh:mm",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey
                                        ),
                                        errorStyle: const TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.amber,
                                              width: 2,
                                            )
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                            borderSide: const BorderSide(
                                              color: Colors.amber,
                                            )
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                              color: Colors.redAccent,
                                              width: 2,
                                            )
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6.0),
                                          borderSide: const BorderSide(
                                            color: Colors.redAccent,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      onShowPicker: (context, currentValue) async {
                                        final TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                        );
                                        return time == null ? null : DateTimeField.convert(time);
                                      },
                                      onChanged: (currentValue) {
                                        if(currentValue != null) {
                                          setState(() =>
                                          getTime =
                                          "${currentValue.hour}:${currentValue.minute} ");
                                        }
                                        // setState(() => getTime = currentValue.toString());
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text(
                          'Upload image'
                        ),
                        onPressed: () async {
                          final results = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );
                          if(results == null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No file selected'))
                            );
                            return null;
                          }

                          final path = results.files.single.path!;
                          final filename = results.files.single.name;

                          getEventPosterUrl = filename;
                          storage.uploadImage(path, filename)
                              .then((value) => print('Done'));
                        },
                      ),
                    ),
                    // FutureBuilder(
                    //     future: storage.downloadUrl('1602763099429.jpg'),
                    //     initialData: getEventPosterUrl = storage.downloadUrl('1602763099429.jpg') as String,
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<String> snapshot){
                    //       if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                    //         return Container(
                    //           width: 300,
                    //           height: 250,
                    //           child: Image.network(
                    //             snapshot.data!,
                    //             fit: BoxFit.cover,
                    //           ),
                    //         );
                    //       }
                    //       // if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
                    //       //   return const CircularProgressIndicator();
                    //       // }
                    //       return Container();
                    //     }
                    // ),
                  ],
                )
            ),
            _isProcessing
                ? const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ) : Container(
              margin: const EdgeInsets.only(left: 10),
              // width: double.maxFinite,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),
                  onPressed: () async{
                    widget.nameFocusNode.unfocus();
                    widget.gameNameFocusNode.unfocus();
                    widget.tournamentModeFocusNode.unfocus();
                    widget.rewardsFocusNode.unfocus();
                    widget.organizedByFocusNode.unfocus();
                    widget.dateFocusNode.unfocus();
                    widget.timeFocusNode.unfocus();

                    if(_addGameEventFormKey.currentState!.validate()){
                      setState(() {
                        _isProcessing = true;
                      });

                      await GamingEventsDatabase.addGameEvent(name: getName, gameName: getGameName, tournamentMode: getTournamentMode, rewards: getRewards, organizedBy: getOrganizedBy, date: getDate, time: getTime, eventPosterUrl: getEventPosterUrl );

                      setState(() {
                        _isProcessing = false;
                      });

                      Fluttertoast.showToast(       //Toast Message
                        msg: "E-Game Event Details Added Successfully",
                        fontSize:16,
                        backgroundColor: Colors.lightGreenAccent,
                        textColor: Colors.black,
                      );

                      Navigator.of(context).pop();
                    }

                  },
                  child: const Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text(
                          'Add E-Game Event',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 2,
                          )
                      )
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
