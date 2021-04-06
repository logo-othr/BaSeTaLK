import 'package:basetalk/presentation/drawer.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: new AppBar(
        title: new Text("Datenschutz"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            child: Center(
              child: SizedBox(
                width: 1000,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                      child: Text(
                        "Datenschutzerklärung",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Text(
                        "Die Nutzung der BaSeTaLK-App ist ohne die Angabe von persönlichen Daten möglich. In der App werden keine Tracking-Dienste eingesetzt. Beim Download von Themen werden die Daten eines Themas von einem Server heruntergeladen. Bei diesem Vorgang wird protokollbedingt die IP-Adresse an den Server übertragen und kann dort in Logfiles gespeichert werden. ")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
