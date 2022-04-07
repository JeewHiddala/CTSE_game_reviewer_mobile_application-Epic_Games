import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_reviewer_application/screens/gamingEventsScreens/services/storage_service.dart';
import '../../collections/gamingEventsCollection.dart';
import '../../custom_form_field_gaming_events.dart';
import '../../validators/gameEventValidator.dart';

class EditGameEventForm extends StatefulWidget {
  final String documentId;
  final String currentName;
  final String currentGameName;
  final String currentTournamentMode;
  final String currentRewards;
  final String currentOrganizedBy;
  final String currentDate;
  final String currentTime;
  final String currentEventPosterUrl;

  final FocusNode nameFocusNode;
  final FocusNode gameNameFocusNode;
  final FocusNode tournamentModeFocusNode;
  final FocusNode rewardsFocusNode;
  final FocusNode organizedByFocusNode;
  final FocusNode dateFocusNode;
  final FocusNode timeFocusNode;

  const EditGameEventForm({
    required this.documentId,
    required this.currentName,
    required this.currentGameName,
    required this.currentTournamentMode,
    required this.currentRewards,
    required this.currentOrganizedBy,
    required this.currentDate,
    required this.currentTime,
    required this.currentEventPosterUrl,
    required this.nameFocusNode,
    required this.gameNameFocusNode,
    required this.tournamentModeFocusNode,
    required this.rewardsFocusNode,
    required this.organizedByFocusNode,
    required this.dateFocusNode,
    required this.timeFocusNode,
  });

  @override
  _EditGameEventFormState createState() => _EditGameEventFormState();
}

class _EditGameEventFormState extends State<EditGameEventForm> {
  final _editGameEventFormKey = GlobalKey<FormState>();

  final List<String> tournamentMode = ['Non-Rated', 'Rated'];

  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameNameController = TextEditingController();
  final TextEditingController _rewardsController = TextEditingController();
  final TextEditingController _organizedByController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  String updateName = "";
  String updateGameName = "";
  String updateTournamentMode = "";
  String updateRewards = "";
  String updateOrganizedBy = "";
  String updateDate = "";
  String updateTime = "";
  String updateEventPosterUrl = "";

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return SingleChildScrollView(
      child: Form(
        key: _editGameEventFormKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24.0),
                    const Text(
                      'Edit E-Game Event',
                      style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Event Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    CustomFormField(
                      isEnabled: true,
                      initialValue: widget.currentName,
                      isLabelEnabled: false,
                      controller: _nameController,
                      focusNode: widget.nameFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Event Name cannot be empty.';
                        }
                        updateName = value;
                      },
                      label: 'Event Name',
                      hint: 'Write your event name',
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Game Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    CustomFormField(
                      isEnabled: false,
                      initialValue: widget.currentGameName,
                      isLabelEnabled: false,
                      controller: _gameNameController,
                      focusNode: widget.gameNameFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        Validator.validateField(value: value);
                        updateGameName = value;
                      },
                      label: 'Game Name',
                      hint: 'Write your game name',
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Tournament Mode',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    DropdownButtonFormField(
                      //Tournament mode dropdown
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      dropdownColor: Colors.black,
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        filled: true,
                        labelStyle: const TextStyle(color: Colors.yellowAccent),
                        hintStyle: const TextStyle(color: Colors.white),
                        errorStyle: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                              width: 2,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.amber,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
                              width: 2,
                            )),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() => updateTournamentMode = value.toString());
                      },
                      value: widget.currentTournamentMode,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return 'This source can not be empty.';
                        }
                        updateTournamentMode = value.toString();
                      },
                      items: tournamentMode.map((tournamentMode) {
                        return DropdownMenuItem(
                          child: Text('For $tournamentMode Persons'),
                          value: tournamentMode,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Rewards',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    CustomFormField(
                      isEnabled: true,
                      initialValue: widget.currentRewards,
                      isLabelEnabled: false,
                      controller: _rewardsController,
                      focusNode: widget.rewardsFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        Validator.validateField(value: value);
                        updateRewards = value;
                      },
                      label: 'Rewards',
                      hint: 'Write your event rewards',
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Organized By',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    CustomFormField(
                      isEnabled: true,
                      initialValue: widget.currentOrganizedBy,
                      isLabelEnabled: false,
                      controller: _organizedByController,
                      focusNode: widget.organizedByFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        Validator.validateField(value: value);
                        updateOrganizedBy = value;
                      },
                      label: 'Organized By',
                      hint: 'Write your event organizer name',
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Game Event Date and Time',
                      style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      height: 90.0,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Date',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 1,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Expanded(
                                    child: CustomFormField(
                                      isEnabled: false,
                                      initialValue: widget.currentDate,
                                      isLabelEnabled: false,
                                      controller: _dateController,
                                      focusNode: widget.dateFocusNode,
                                      keyboardType: TextInputType.text,
                                      inputAction: TextInputAction.next,
                                      validator: (value) {
                                        Validator.validateField(value: value);
                                        updateDate = value;
                                      },
                                      label: 'Date',
                                      hint: 'Write your date',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Time',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      letterSpacing: 1,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Expanded(
                                    child: CustomFormField(
                                      isEnabled: false,
                                      initialValue: widget.currentTime,
                                      isLabelEnabled: false,
                                      controller: _timeController,
                                      focusNode: widget.timeFocusNode,
                                      keyboardType: TextInputType.text,
                                      inputAction: TextInputAction.next,
                                      validator: (value) {
                                        Validator.validateField(value: value);
                                        updateTime = value;
                                      },
                                      label: 'Time',
                                      hint: 'Write your time',
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
                        child: const Text('Update image'),
                        onPressed: () async {
                          final results = await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );
                          if (results == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('No file selected')));
                            return null;
                          }

                          final path = results.files.single.path!;
                          final filename = results.files.single.name;

                          updateEventPosterUrl = filename;
                          storage
                              .uploadImage(path, filename)
                              .then((value) => print('Done'));
                          setState(() {});
                        },
                      ),
                    ),
                    FutureBuilder(
                        future: storage.downloadUrl(updateEventPosterUrl != "" ? updateEventPosterUrl : widget.currentEventPosterUrl),
                        // initialData: storage.downloadUrl('1602763099429.jpg'),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Container(
                              width: 300,
                              height: 250,
                              child: Image.network(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          return Container();
                        }),
                  ],
                )),
            _isProcessing
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(left: 10),
                    // width: double.maxFinite,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                        onPressed: () async {
                          widget.nameFocusNode.unfocus();
                          widget.gameNameFocusNode.unfocus();
                          widget.tournamentModeFocusNode.unfocus();
                          widget.rewardsFocusNode.unfocus();
                          widget.organizedByFocusNode.unfocus();
                          widget.dateFocusNode.unfocus();
                          widget.timeFocusNode.unfocus();

                          if (_editGameEventFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });

                            await GamingEventsDatabase.updateGameEvent(
                                docId: widget.documentId,
                                name: updateName,
                                gameName: updateGameName,
                                tournamentMode: updateTournamentMode,
                                rewards: updateRewards,
                                organizedBy: updateOrganizedBy,
                                date: updateDate,
                                time: updateTime,
                                eventPosterUrl: updateEventPosterUrl);

                            setState(() {
                              _isProcessing = false;
                            });

                            Fluttertoast.showToast(
                              //Toast Message
                              msg: "Game Event Details Updated Successfully",
                              fontSize: 16,
                              backgroundColor: Colors.lightGreenAccent,
                              textColor: Colors.black,
                            );

                            Navigator.of(context).pop();
                          }
                        },
                        child: const Padding(
                            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                            child: Text('Update',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 2,
                                ))),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}