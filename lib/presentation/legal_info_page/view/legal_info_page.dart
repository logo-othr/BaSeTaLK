import 'package:basetalk/presentation/drawer.dart';
import 'package:flutter/material.dart';

class LegalInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: new AppBar(
          title: new Text("Impressum"),
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
                      Text(
                          "Informationen gemäß § 5 Telemediengesetz und § 55 Rundfunkstaatsvertrag"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: Text(
                          "Herausgeber",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Column(
                              children: [
                                Text("Katholische Hochschule Mainz (KH)"),
                                Text("Saarstr. 3"),
                                Text("55122 Mainz"),
                                Text("https://www.kh-mz.de"),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  "Ostbayerische Technische Hochschule Regensburg (OTH)"),
                              Text("Seybothstr. 2"),
                              Text("93053 Regensburg"),
                              Text("https://www.oth-regensburg.de"),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: Text(
                          "Kontakt",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Text("BaSeTaLK-Team: info@basetalk.de"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: Text(
                          "Rechtsform",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Text(
                          "Das Verbundprojekt wird vom Bundesministerium für Bildung und Forschung (BMBF) im Rahmen der Förderrichtlinie „Lebensqualität durch soziale Innovationen (FH-Sozial)“ im Programm „Forschung an Fachhochschulen“, Themenfeld „Soziale Innovationen zur digitalen Inklusion“ gefördert."),
                      Text("Förderkennzeichen:"),
                      Text("13FH515SA7 – KH Mainz"),
                      Text("13FH515SB7 – OTH Regensburg"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: Text(
                          "Vertretungsberechtigte Personen",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Column(
                              children: [
                                Text("Frau Prof.in Dr. Sabine Corsten",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("Tel.: 06131 – 289 44 540"),
                                Text("Fax: 06131 – 289 44 8 540"),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child:
                                      Text("E-Mail: sabine.corsten@kh-mz.de"),
                                ),
                                Text("Katholische Hochschule Mainz (KH)"),
                                Text("Saarstr. 3"),
                                Text("55122 Mainz")
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Frau Prof.in Dr. Norina Lauer",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Tel.: +49 941 943-1087"),
                              Text("Fax: +49 941 943-1468"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Text(
                                    "E-Mail: norina.lauer@oth-regensburg.de"),
                              ),
                              Text(
                                  "Ostbayerische Technische Hochschule Regensburg (OTH)"),
                              Text("Seybothstr. 2"),
                              Text("93053 Regensburg")
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
