import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class map extends StatefulWidget {
  // double lat,lang;
  // map(this.lat,this.lang);
  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {

  Set<Marker> mymarkers={};
  double lat,lang;
  void initState (){
    getcurrentlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: GestureDetector(
        child: Container(
          color: Color(0xff36a9e0),
          height:MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10.0),
          child: FlatButton(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Text(
                'Continue'.tr,
                style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
        ),
        onTap: () =>  Navigator.pop(context),
      ),
        appBar: AppBar(
          backgroundColor: Color(0xff36a9e0),
        ),
        body: (lat==-1)?  Builder(builder: (BuildContext context) {
          return Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Color(0xff36a9e0),
              child: Text(
                'Try Again an Error happen'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal),
              ),
              onPressed: () {
                getcurrentlocation();
              },
            ),
          );
        }):(lat!=null)? GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(

              target: LatLng(lat, lang),zoom: 20),
          onMapCreated: (controller) {
            setState(() {
              mymarkers.add(Marker(markerId: MarkerId('1'),position: LatLng(lat, lang)));
            });
          },
          markers: mymarkers,
        ): Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
    );
  }
  Future<Geolocator> getcurrentlocation() async{
    setState(() {
      lat=null;
      lang=null;
    });

      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
        setState(() {

            lat=value.latitude;
            lang=value.longitude;
            print(lat);
            print(lang);
          //  detected=true;
        });

      }).onError((error, stackTrace) {
        setState(() {
          lat=-1;
          lang=-1;
        });

      });

}}
