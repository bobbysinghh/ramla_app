// import 'dart:convert';

// import 'package:asset_app/Common/custom_text_field.dart';
// import 'package:asset_app/api/Networking/network.dart';
// import 'package:asset_app/api/modal/area_by_emirates.dart';
// import 'package:asset_app/api/modal/emirates_modal.dart';
// import 'package:asset_app/api/utility/app_url.dart';
// import 'package:flutter/material.dart';

// class SuggestLocation extends StatefulWidget {
//   const SuggestLocation({Key key}) : super(key: key);

//   @override
//   _SuggestLocationState createState() => _SuggestLocationState();
// }

// class _SuggestLocationState extends State<SuggestLocation> {
//   Future<dynamic> dataString;
//   Future<dynamic> areaDataString;
//   @override
//   void initState() {
//     super.initState();
//     dataString = Network(AppUrl.getEmirates).fetchData();
//   }

//   areaByEmirates(String emiratesId) {
//     areaDataString = Network(AppUrl.getAreaByEmirates + emiratesID).fetchData();
//   }

//   var selectedCountryValue;
//   String _name, _community, _zipCode;
//   List list1;
//   Map<dynamic, Datum> dropDownItemsMap1;
//   List list2;
//   Map<dynamic, Area> dropDownItemsMap2;
//   String emiratesID = "";
//   final _scrollbar1 = ScrollController();
//   final _scrollbar2 = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(255, 251, 247, 1),
//       body: SingleChildScrollView(
//           child: Container(
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text("Suggest Location"),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           child: Form(
//                             // key: formKey,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 50,
//                                 ),
//                                 Container(
//                                     child: Text(
//                                       "Apartment/Villa Name",
//                                       style: TextStyle(fontSize: 15),
//                                     ),
//                                     padding: EdgeInsets.only(
//                                       left: 30,
//                                       bottom: 10,
//                                     )),
//                                 signUpTextFieldCommon(
//                                   hintText: "Some villa name here",
//                                   validate: (value) => value.isEmpty
//                                       ? "Some villa name here"
//                                       : null,
//                                   top: 0,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _name = value;
//                                     });
//                                   },
//                                   onSaved: (value) => _name = value,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                             child: Text(
//                                               "Community",
//                                               style: TextStyle(fontSize: 15),
//                                             ),
//                                             padding: EdgeInsets.only(
//                                               left: 30,
//                                               top: 20,
//                                               bottom: 10,
//                                             )),
//                                         signUpTextFieldCommon(
//                                           hintText: "Community",
//                                           width: (MediaQuery.of(context)
//                                                       .size
//                                                       .width -
//                                                   75) *
//                                               0.5,
//                                           right: 0,
//                                           top: 0,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _community = value;
//                                             });
//                                           },
//                                           onSaved: (value) =>
//                                               _community = value,
//                                           textInputType:
//                                               TextInputType.emailAddress,
//                                         ),
//                                       ],
//                                     ),
//                                     // Column(
//                                     //   crossAxisAlignment:
//                                     //       CrossAxisAlignment.start,
//                                     //   children: [
//                                     //     Container(
//                                     //         child: Text(
//                                     //           "Area",
//                                     //           style: TextStyle(fontSize: 15),
//                                     //         ),
//                                     //         padding: EdgeInsets.only(
//                                     //           left: 15,
//                                     //           top: 20,
//                                     //           bottom: 10,
//                                     //         )),
//                                     //     Container(
//                                     //       height: 45,
//                                     //       width: (MediaQuery.of(context)
//                                     //                   .size
//                                     //                   .width -
//                                     //               75) *
//                                     //           0.5,
//                                     //       child: Scrollbar(
//                                     //         controller: _scrollbar2,
//                                     //         child: Container(
//                                     //           decoration: BoxDecoration(
//                                     //               border: Border.all(
//                                     //                   width: 1,
//                                     //                   color: Colors.grey),
//                                     //               borderRadius:
//                                     //                   BorderRadius.circular(
//                                     //                       10)),
//                                     //           child: Row(
//                                     //             mainAxisAlignment:
//                                     //                 MainAxisAlignment
//                                     //                     .spaceBetween,
//                                     //             children: <Widget>[
//                                     //               Expanded(
//                                     //                 child:
//                                     //                     DropdownButtonHideUnderline(
//                                     //                   child: FutureBuilder(
//                                     //                       future:
//                                     //                           areaDataString,
//                                     //                       builder: (context,
//                                     //                           snapshot) {
//                                     //                         if (snapshot
//                                     //                             .hasError) {
//                                     //                           return new Container(
//                                     //                             child: Text(
//                                     //                                 "First select country"),
//                                     //                           );
//                                     //                         } else if (snapshot
//                                     //                             .hasData) {
//                                     //                           var decodeData =
//                                     //                               json.decode(
//                                     //                                   snapshot
//                                     //                                       .data);
//                                     //                           if (decodeData[
//                                     //                                   "statuscode"] ==
//                                     //                               1) {
//                                     //                             AreaByEmirateslModel
//                                     //                                 areaByEmiratesDetails =
//                                     //                                 areaByEmirateslModelFromJson(
//                                     //                                     snapshot
//                                     //                                         .data);
//                                     //                             list2.clear();
//                                     //                             dropDownItemsMap2 =
//                                     //                                 new Map();
//                                     //                             areaByEmiratesDetails
//                                     //                                 .data
//                                     //                                 .forEach(
//                                     //                                     (branchItem) {
//                                     //                               int index =
//                                     //                                   areaByEmiratesDetails
//                                     //                                       .data
//                                     //                                       .indexOf(
//                                     //                                           branchItem);
//                                     //                               dropDownItemsMap2[
//                                     //                                       index] =
//                                     //                                   branchItem;
//                                     //                               list1.add(new DropdownMenuItem(
//                                     //                                   child: Container(
//                                     //                                       margin: EdgeInsets.only(
//                                     //                                           left:
//                                     //                                               10),
//                                     //                                       child: Text(branchItem
//                                     //                                           .name)),
//                                     //                                   value:
//                                     //                                       index));
//                                     //                             });
//                                     //                             return ButtonTheme(
//                                     //                               alignedDropdown:
//                                     //                                   true,
//                                     //                               child:
//                                     //                                   DropdownButton(
//                                     //                                 items:
//                                     //                                     list2,
//                                     //                                 isDense:
//                                     //                                     true,
//                                     //                                 hint: new Text(
//                                     //                                     "Area"),
//                                     //                                 onChanged: (int
//                                     //                                     _selected) {
//                                     //                                   int _selectedItem =
//                                     //                                       list2[_selected]
//                                     //                                           .value;
//                                     //                                   setState(
//                                     //                                       () {
//                                     //                                     selectedCountryValue =
//                                     //                                         dropDownItemsMap2[_selectedItem];
//                                     //                                     emiratesID =
//                                     //                                         dropDownItemsMap2[_selectedItem].id;
//                                     //                                   });
//                                     //                                 },
//                                     //                               ),
//                                     //                             );
//                                     //                           } else {
//                                     //                             return Container(
//                                     //                                 child:
//                                     //                                     Center(
//                                     //                               child: Text(
//                                     //                                   "First select country"),
//                                     //                             ));
//                                     //                           }
//                                     //                         } else {
//                                     //                           return CircularProgressIndicator();
//                                     //                         }
//                                     //                       }),
//                                     //                 ),
//                                     //               ),
//                                     //             ],
//                                     //           ),
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //   ],
//                                     // ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                             child: Text(
//                                               "Zip Code",
//                                               style: TextStyle(fontSize: 15),
//                                             ),
//                                             padding: EdgeInsets.only(
//                                               left: 30,
//                                               top: 20,
//                                               bottom: 10,
//                                             )),
//                                         signUpTextFieldCommon(
//                                           validate: (value) => value.isEmpty
//                                               ? "Please enter Zip Code"
//                                               : null,
//                                           top: 0,
//                                           right: 0,
//                                           width: (MediaQuery.of(context)
//                                                       .size
//                                                       .width -
//                                                   75) *
//                                               0.5,
//                                           onChanged: (value) {
//                                             setState(() {
//                                               _zipCode = value;
//                                             });
//                                           },
//                                           onSaved: (value) => _zipCode = value,
//                                           suffixIcon: false,
//                                         )
//                                       ],
//                                     ),
// Column(
//   crossAxisAlignment:
//       CrossAxisAlignment.start,
//   children: [
//     Container(
//         child: Text(
//           "Country",
//           style: TextStyle(fontSize: 15),
//         ),
//         padding: EdgeInsets.only(
//           left: 15,
//           top: 20,
//           bottom: 10,
//         )),
//     Container(
//       height: 45,
//       width: (MediaQuery.of(context)
//                   .size
//                   .width -
//               75) *
//           0.5,
//       child: Scrollbar(
//         controller: _scrollbar1,
//         child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(
//                   width: 1,
//                   color: Colors.grey),
//               borderRadius:
//                   BorderRadius.circular(
//                       10)),
//           child: Row(
//             mainAxisAlignment:
//                 MainAxisAlignment
//                     .spaceBetween,
//             children: <Widget>[
//               Expanded(
//                 child:
//                     DropdownButtonHideUnderline(
//                   child: FutureBuilder(
//                       future: dataString,
//                       builder: (context,
//                           snapshot) {
//                         if (snapshot
//                             .hasError) {
//                           return new Container(
//                             child: Text(
//                                 "Some error occured, Try Again!"),
//                           );
//                         } else if (snapshot
//                             .hasData) {
//                           var decodeData =
//                               json.decode(
//                                   snapshot
//                                       .data);
//                           if (decodeData[
//                                   "statuscode"] ==
//                               1) {
//                             EmirateslModel
//                                 emiratesDetails =
//                                 emirateslModelFromJson(
//                                     snapshot
//                                         .data);
//                             list1.clear();
//                             dropDownItemsMap1 =
//                                 new Map();
//                             emiratesDetails
//                                 .data
//                                 .forEach(
//                                     (branchItem) {
//                               int index =
//                                   emiratesDetails
//                                       .data
//                                       .indexOf(
//                                           branchItem);
//                               dropDownItemsMap1[
//                                       index] =
//                                   branchItem;
//                               list1.add(new DropdownMenuItem(
//                                   child: Container(
//                                       margin: EdgeInsets.only(
//                                           left:
//                                               10),
//                                       child: Text(branchItem
//                                           .name)),
//                                   value:
//                                       index));
//                             });
//                             return ButtonTheme(
//                               alignedDropdown:
//                                   true,
//                               child:
//                                   DropdownButton(
//                                 items:
//                                     list1,
//                                 isDense:
//                                     true,
//                                 hint: new Text(
//                                     "Country"),
//                                 onChanged: (int
//                                     _selected) {
//                                   int _selectedItem =
//                                       list1[_selected]
//                                           .value;
//                                   setState(
//                                       () {
//                                     selectedCountryValue =
//                                         dropDownItemsMap1[_selectedItem];
//                                     emiratesID =
//                                         dropDownItemsMap1[_selectedItem].id;
//                                   });
//                                   areaByEmirates(
//                                       emiratesID);
//                                 },
//                               ),
//                             );
//                           } else {
//                             return Container(
//                                 child:
//                                     Center(
//                               child: Text(
//                                   decodeData[
//                                       "message"]),
//                             ));
//                           }
//                         } else {
//                           return CircularProgressIndicator();
//                         }
//                       }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     // Spacer(),
//                     customButton(name: "Suggest My Address", callback: () {}),
//                   ]))),
//     );
//   }
// }

import 'dart:convert';

import 'package:asset_app/Common/custom_text_field.dart';
import 'package:asset_app/api/Networking/network.dart';
import 'package:asset_app/api/modal/area_by_emirates.dart';
import 'package:asset_app/api/modal/emirates_modal.dart';
import 'package:asset_app/api/providers/auth_provider.dart';
import 'package:asset_app/api/providers/suggest_location_provider.dart';
import 'package:asset_app/api/utility/app_url.dart';
import 'package:asset_app/api/utility/validator.dart';
import 'package:asset_app/components/drawer.dart';
import 'package:asset_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

class SuggestLocation extends StatefulWidget {
  const SuggestLocation({Key key}) : super(key: key);

  @override
  _SuggestLocationState createState() => _SuggestLocationState();
}

class _SuggestLocationState extends State<SuggestLocation> {
  Future<dynamic> emiratesDataString;
  Future<dynamic> areaDataString;
  @override
  void initState() {
    super.initState();
    emiratesDataString = NetworkWithHeaders(AppUrl.getEmirates).fetchData();
  }

  List<DropdownMenuItem> createCountryDropdown(EmirateslModel dropdownList) {
    List<DropdownMenuItem> countryList = [];
    for (int i = 0; i < dropdownList.data.length; ++i) {
      countryList.add(DropdownMenuItem(
        child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(dropdownList.data[i].name),
              ],
            )),
        value: dropdownList.data[i].name,
        onTap: () {
          setState(() {
            _emiratesID = dropdownList.data[i].id;
            selectedCountryMap = dropdownList.data[i];
          });
          areaByEmirates(dropdownList.data[i].id);
          setState(() {
            countrySelected = true;
          });
        },
      ));
    }
    return countryList;
  }

  List<DropdownMenuItem> createAreaDropdown(AreaByEmirateslModel dropdownList) {
    List<DropdownMenuItem> areaList = [];
    for (int i = 0; i < dropdownList.data.length; ++i) {
      areaList.add(DropdownMenuItem(
        child: Container(
            height: 45,
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Container(height: 45, child: Text(dropdownList.data[i].name)),
              ],
            )),
        value: dropdownList.data[i].name,
        onTap: () {
          setState(() {
            _areaID = dropdownList.data[i].id;
            selectedAreaMap = dropdownList.data[i];
          });
        },
      ));
    }
    return areaList;
  }

  Datum selectedCountryMap;
  String selectedCountryName;
  Area selectedAreaMap;
  String selectedAreaName;
  areaByEmirates(String emiratesId) {
    areaDataString =
        NetworkWithHeaders(AppUrl.getAreaByEmirates + _emiratesID).fetchData();
  }

  bool countrySelected = false;
  String _name, _community, _zipCode;
  String _emiratesID = "";
  String _areaID = "";
  bool adding = false;
  final _scrollbar1 = ScrollController();
  final _scrollbar2 = ScrollController();
  TextEditingController _searchController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  Duration get registerTime =>
      Duration(milliseconds: timeDilation.ceil() * 2250);
  @override
  Widget build(BuildContext context) {
    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );
    SuggestLocationProvider location =
        Provider.of<SuggestLocationProvider>(context);
    Future suggestLocation() async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        if (_emiratesID != "") {
          if (_areaID != "") {
            Response response = await location.addLocation(
                _name, _community, _areaID, _emiratesID);
            var data = jsonDecode(response.body);
            if (data['statuscode'] == 1) {
              Future.delayed(registerTime).then((_) {
                Fluttertoast.showToast(
                  msg: data['message'],
                  timeInSecForIosWeb: 5,
                );
                setState(() {
                  adding = false;
                });
                location.notify();
              });
            } else {
              Fluttertoast.showToast(
                msg: data['message'],
                timeInSecForIosWeb: 5,
              );
            }
          } else {
            Fluttertoast.showToast(
              msg: "Please Select Area",
              timeInSecForIosWeb: 5,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: "Please Select Country",
            timeInSecForIosWeb: 5,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Please complete the form properly",
          timeInSecForIosWeb: 5,
          // message: ,
        );
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 247, 1),
      drawer: Drawer(
        child: pBody(),
      ),
      appBar: searchAppBar(
          backgroundColor: kPrimaryColor, controller: _searchController),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Suggest Location",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: Form(
                          key: formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                    child: Text(
                                      "Apartment/Villa Name",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    padding: EdgeInsets.only(
                                      left: 30,
                                      bottom: 10,
                                    )),
                                signUpTextFieldCommon(
                                  hintText: "Some villa name here",
                                  validate: (value) => value.isEmpty
                                      ? "Please enter your name"
                                      : null,
                                  top: 0,
                                  onChanged: (value) {
                                    setState(() {
                                      _name = value;
                                    });
                                  },
                                  onSaved: (value) => _name = value,
                                  textInputType: TextInputType.streetAddress,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: Text(
                                              "Community",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            padding: EdgeInsets.only(
                                              left: 30,
                                              top: 20,
                                              bottom: 10,
                                            )),
                                        signUpTextFieldCommon(
                                          hintText: "Community",
                                          validate: (value) => value.isEmpty
                                              ? "Please enter Community"
                                              : null,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  75) *
                                              0.5,
                                          right: 0,
                                          top: 0,
                                          onChanged: (value) {
                                            setState(() {
                                              _community = value;
                                            });
                                          },
                                          onSaved: (value) =>
                                              _community = value,
                                          textInputType:
                                              TextInputType.streetAddress,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: Text(
                                              "Area",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 20,
                                              bottom: 10,
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Container(
                                            height: 45,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    75) *
                                                0.5,
                                            child: countrySelected
                                                ? Scrollbar(
                                                    controller: _scrollbar2,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child:
                                                                FutureBuilder(
                                                                    future:
                                                                        areaDataString,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasError) {
                                                                        return new Container(
                                                                          child:
                                                                              Text("Some error occured, Try Again!"),
                                                                        );
                                                                      } else if (snapshot
                                                                          .hasData) {
                                                                        var decodeData =
                                                                            json.decode(snapshot.data);
                                                                        if (decodeData["statuscode"].toString() ==
                                                                            "1") {
                                                                          AreaByEmirateslModel
                                                                              areaByEmiratesDetails =
                                                                              areaByEmirateslModelFromJson(snapshot.data);
                                                                          return ButtonTheme(
                                                                            alignedDropdown:
                                                                                true,
                                                                            child:
                                                                                DropdownButton(
                                                                              isExpanded: true,
                                                                              items: createAreaDropdown(areaByEmiratesDetails),
                                                                              value: selectedAreaName,
                                                                              isDense: true,
                                                                              hint: new Text("Area"),
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  selectedAreaName = value;
                                                                                });
                                                                              },
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          return Container(
                                                                              child: Center(
                                                                            child:
                                                                                Text(decodeData["message"]),
                                                                          ));
                                                                        }
                                                                      } else {
                                                                        return Container(
                                                                            child:
                                                                                Center(child: CircularProgressIndicator()));
                                                                      }
                                                                    }),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            "Select Country First"),
                                                        Icon(Icons
                                                            .arrow_drop_down)
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: Text(
                                              "Zip Code",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            padding: EdgeInsets.only(
                                              left: 30,
                                              top: 20,
                                              bottom: 10,
                                            )),
                                        signUpTextFieldCommon(
                                          textInputType: TextInputType.number,
                                          hintText: "Zip Code",
                                          validate: (value) => value.isEmpty
                                              ? "Please enter Zip Code"
                                              : null,
                                          top: 0,
                                          right: 0,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  75) *
                                              0.5,
                                          onChanged: (value) {
                                            setState(() {
                                              _zipCode = value;
                                            });
                                          },
                                          onSaved: (value) => _zipCode = value,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: Text(
                                              "Country",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            padding: EdgeInsets.only(
                                              left: 15,
                                              top: 20,
                                              bottom: 10,
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Container(
                                            // color: Colors.red,
                                            height: 45,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    75) *
                                                0.5,
                                            child: Scrollbar(
                                              controller: _scrollbar1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: FutureBuilder(
                                                          future:
                                                              emiratesDataString,
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasError) {
                                                              return new Container(
                                                                child: Text(
                                                                    "Some error occured, Try Again!"),
                                                              );
                                                            } else if (snapshot
                                                                .hasData) {
                                                              var decodeData =
                                                                  json.decode(
                                                                      snapshot
                                                                          .data);
                                                              if (decodeData[
                                                                          "statuscode"]
                                                                      .toString() ==
                                                                  "1") {
                                                                EmirateslModel
                                                                    emiratesDetails =
                                                                    emirateslModelFromJson(
                                                                        snapshot
                                                                            .data);
                                                                return ButtonTheme(
                                                                  alignedDropdown:
                                                                      true,
                                                                  child:
                                                                      DropdownButton(
                                                                    isExpanded:
                                                                        true,
                                                                    items: createCountryDropdown(
                                                                        emiratesDetails),
                                                                    value:
                                                                        selectedCountryName,
                                                                    isDense:
                                                                        true,
                                                                    hint: new Text(
                                                                        "Country"),
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        print(value
                                                                            .toString());
                                                                        selectedCountryName =
                                                                            value;
                                                                      });
                                                                    },
                                                                  ),
                                                                );
                                                              } else {
                                                                return Container(
                                                                    child:
                                                                        Center(
                                                                  child: Text(
                                                                      decodeData[
                                                                          "message"]),
                                                                ));
                                                              }
                                                            } else {
                                                              return Container(
                                                                  child: Center(
                                                                      child:
                                                                          CircularProgressIndicator()));
                                                            }
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // location.suggestLocationStatus == SuggestLocationStatus.Adding
                adding
                    ? loading
                    : customButton(
                        name: 'Suggest My Address',
                        callback: () {
                          setState(() {
                            adding = true;
                          });
                          suggestLocation();
                        }),
              ]))),
    );
  }
}
