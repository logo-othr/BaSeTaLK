

# BaSeTaLK

BaSeTaLK - Biographiearbeit in Senioreneinrichtungen mit Tablet-Unterstützung zur Verbesserung der Lebensqualität und Kommunikation - ist ein vom BMBF gefördertes Verbundprojekt der Katholischen Hochschule (KH) Mainz und der Ostbayerischen Technischen Hochschule (OTH) Regensburg.

Förderkennzeichen: FKZ 13FH515SA7 (KH Mainz) and FKZ 13FH515SB7 (OTH Regensburg)

## Inhaltsverzeichnis

1. [Einleitung](#einleitung)
2. [Voraussetzungen](#voraussetzungen)
3. [Installation](#installation)
4. [Benutzung](#benutzung)
5. [Mitwirken](#mitwirken)
6. [Lizenz](#lizenz)
7. [Kontakt](#kontakt)

## Einleitung

### Beschreibung

BaSeTaLK ist ein Verbundprojekt der Katholischen Hochschule (KH) Mainz und der Ostbayerischen Technischen Hochschule (OTH) Regensburg. Prof.in Dr. Sabine Corsten, Professorin für Logopädie am Fachbereich Gesundheit und Pflege an der Katholischen Hochschule Mainz (KH Mainz), hat die Projektleitung und -koordination inne. Projektleitung an der OTH Regensburg ist Prof.in Dr. Norina Lauer, Professorin für Logopädie an der Fakultät Angewandte Sozial- und Gesundheitswissenschaften und Mitglied des Regensburg Center of Health Sciences and Technology (RCHST).  Ziel des Projekts ist die Entwicklung und Evaluation einer Tablet-gestützten Maßnahme zur Biographiearbeit in Pflege- und Senioreneinrichtungen zur Steigerung der Lebensqualität und Teilhabe älterer Menschen. Menschen im Alter in Pflegeeinrichtungen sollen so die Möglichkeit bekommen, über lebensgeschichtliche Themen sprechen zu können. Unterstützt werden sie hierbei von ehrenamtlich engagierten Personen, die unter dem Einsatz einer für BaSeTaLK entwickelten App Gespräche im Gruppen- sowie Einzelsetting anleiten. Das Verbundprojekt wird vom Bundesministerium für Bildung und Forschung (BMBF) im Rahmen der Förderrichtline „Lebensqualität durch soziale Innovationen (FH-Sozial)“ im Programm „Forschung an Fachhochschulen“, Themenfeld „Soziale Innovationen zur digitalen Inklusion“ gefördert. Es erstreckte sich über insgesamt dreidreiviertel Jahre (2019-2023).

### Ziele des Projekts

BaSeTaLK verfolgt die vier folgenden wesentlichen Ziele:

- Aktivierung von Erinnerungsprozessen, Förderung von gelingender Identitätsarbeit durch ein Erzählen über sich selbst im Austausch mit anderen

- Steigerung der Kommunikation und Lebensqualität und des psychologischen Wohlbefinden von Menschen im Alter

- Entwicklung und Evaluation einer an die Bedarfe älterer Menschen angepassten Software (App) zur
  Stimulation biographischer Gespräche

- Erkenntnisgewinn zum Umgang von Menschen im Alter mit neuen Medien, insbesondere dem Tablet und
  den Möglichkeiten digitaler Inklusion

### Kurzbeschreibung der Funktionalität

Die BaSeTaLK-App dient als Materialsammlung und Leitfaden, die in Settings zur Biographiearbeit
Einsatz finden kann. Die Hauptbedienung erfolgt dabei durch moderierende Personen, die über die App
multimodale Impulse abrufen können. Diese Impulse liefern Aufhänger und Anregungen, um einen
Einstieg in ein Gespräch über das eigene Leben im Austausch mit anderen zu finden, sowie das
Gespräch in Gang zu halten und zu strukturieren.

Die App ist dabei so aufbereitet, dass mit ihr eine virtuelle Reise zu Orten in der Natur und
kulturellen Orten (z. B. Wald, Berge, Kino, Café) gemacht werden. Hierzu stehen insgesamt 15 Orte
zur Verfügung. Sie werden über Fotos repräsentiert, die einzelne Standorte am jeweiligen Ort
darstellen. Es können neben biographischen Fragen Audio-Features und Quiz abgerufen werden.

Die Orte sind auf einer Startseite aufgelistet. In einem Überblick dieser Auflistung ist auch ein
Indikator zur Gesprächstiefe sichtbar. In drei Stufen (1 = leicht, 2 = mittel, 3 = schwer) ist die
potentielle Gesprächstiefe beurteilt. Um in fortlaufenden Treffen die Übersicht zu bewahren, welche
Orte mit einer Gesprächsgruppe schon aufgesucht wurden, lässt sich ein Thema über die
Besucht-Checkbox abhaken. Zudem gibt es einen Favoriten-Button. Dieser kann z. B. genutzt werden, um
ein Thema für eine nächste Stunde zu priorisieren. Es rutscht in der Liste dann an die oberste
Stelle.

Sobald man mit einem Anklicken eines Themas den Ort betritt, wird man anfangs an ein Blitzlicht
erinnert, zu dem man der Frage nachgehen kann, wie das eigene Wohlbefinden an dem Tag eingeschätzt
wird. Hier werden die Wortbeiträge urteilsfrei im Raum stehen gelassen. Über einen Weiter-Button
gelangt man auf eine Startseite eines Themas, die das erste Bild zu dem Ort repräsentiert. Dieses
ist das erste von insgesamt vier Bildern. Auf den Bildern zwei bis vier sind weitere Funktionen
abrufbar: Hier gibt es den Sprechblase-Button, über den sich Moderationsfragen abrufen lassen. Pro
Bild sind drei bis vier biographische Moderationsfragen hinterlegt. Neben dem Sprechblase-Button
gibt es den Geschenk-Button. Hier lassen sich auf dem zweiten Bild besondere Features abrufen (
Audio-Features, Quiz).

## Voraussetzungen

- Dart & Flutter
- Entsprechend leistungsfähiger Rechner/Laptop
- (S)FTP-Server mit ca. 2 GB Speicherplatz
- iPad Pro 12" oder vergleichbares Android-Tablet

## Installation

Um den Quellcode auf Ihrem System zu kompilieren, werden Dart und Flutter benötigt. Flutter kann unter Verwendung der offiziellen Anleitung installiert werden. 

Das Projekt kann wie folgt abgerufen und gestartet werden:

1. `$ git clone https://github.com/logo-othr/BaSeTaLK.git`
2. `$ cd BaSeTaLK`
3. `$ flutter pub get`
4. `$ flutter pub run build_runner build --delete-conflicting-outputs`
5. `$ flutter run`



## Benutzung

### Installation

Die App ist für das iPad Pro 12“ optimiert und ist in der aktuellen Version nicht für Smartphones geeignet. Aufgrund der gewählten Programmiersprache und Framework Dart und Flutter ist die Kompatibilität zu Android-Tablets sehr hoch. Im Einzelfall muss dies jedoch getestet werden. Die App kann über die üblichen Wege (Testflight, Google Playstore, Apple App Store, APK) auf Geräten installiert werden.

Die App benötigt beim Start Internetzugriff, damit die Themenliste (Thema = Ort) geladen werden kann. Die Themenliste in JSON-Form enthält die in der App angezeigten Themen zusammen mit allen Fragen der jeweiligen Themen. Die einzelnen Medien, also Audio-Dateien, Quiz-JSON-Dateien und Bilder können dann pro Thema heruntergeladen werden. Wurden die Medien für ein Thema heruntergeladen, ist dieses offline verfügbar. Lediglich beim Start der App wird immer die aktuelle Themenliste heruntergeladen.

Die Nutzung der App ist ohne ein Nutzerkonto möglich.

### Serverbetrieb

Zum Betrieb der App wird ein (S)FTP-Server benötigt. Ein solcher kann im Internet preisgünstig von verschiedenen Anbietern gemietet werden.

In der derzeitigen Implementierung werden die Themenliste in JSON-Form sowie die Medien (Fotos, Audio, JSON-Dateien) von einem (S)FTP-Server geladen. Dafür müssen diese auf dem FTP-Server abgelegt werden und in der App die Zugangsdaten (assets/sftp_auth.json) zum (S)FTP-Server hinterlegt werden. Die Medien müssen alle zusammen in einem  Ordner auf dem FTP-Server abgelegt werden. Es gibt hier keine Unterordner für einzelne Themen.

### Weiterentwicklung und Sicherheit

Das Hinterlegen der FTP-Zugangsdaten in der App birgt gewisse Sicherheitsrisiken. Durch Reverse-Engineering können die Benutzerdaten zum (S)FTP-Account aus der App ausgelesen werden. In einem kontrollierten Setting mit einer kleinen festen Anzahl an Nutzern ist dies kein Problem. Bei einer öffentlichen Verteilung der App können die Zugangsdaten zum (S)FTP-Server in falsche Hände geraten, da die Zugangsdaten im Quellcode gespeichert sind. Es ist deshalb notwendig, dass für den Zugriff auf den Server ein Read-Only-Benutzer erstellt wird, dessen Zugangsdaten in die App eingebaut werden. Dies schützt aber nicht vor einem unbefugten Stehlen bzw. Downloaden der Themenliste und der Medien. Für eine öffentliche Verbreitung der App wäre eine Möglichkeit zur Weiterentwicklung das Ersetzen des FTP-Servers mit einer REST-API und einem API-Key. Weiterhin könnte ein Anmeldeprozess eingebaut werden, um einzelne Nutzer zu identifizieren. 

### Komprimierung der Medien

Die Medien im Repository sind weitestgehend unkomprimiert und in ihrer Originalqualität abgelegt. Da dies für die Verwendung in der App je nach Gerät und Internetverbindung unnötig große Dateigrößen verursacht, wird empfohlen die Medien vorher zu komprimieren. Für die Komprimierung von JPEG und MP3-Dateien gibt es verschiedene Programme, welche sich für das jeweilige Betriebssystem durch eine Internetsuche finden lassen.

### Datenschutz & Statistik

Die App wurde möglichst datenschutzfreundlich entwickelt. Es werden nur sehr wenige Daten erfasst. Zum einen werden durch den FTP-Server bei einer Verbindung möglicherweise Daten erfasst. Welche Daten genau erfasst werden, kann beim Betreiber des genutzten FTP-Servers erfragt werden. Zum anderen wird eine Log-Datei "Statistik" angelegt.

In der Datei statistic_logger.dart ist erklärt, welche Logdaten erfasst werden. Diese Daten werden in eine CSV-Datei auf dem Gerät geloggt. Die Daten werden im BaSeTaLK App-Verzeichnis öffentlich (innerhalb des Gerätes) für andere Apps zugreifbar gespeichert. So können die Daten einfach vom Gerät kopiert werden. Aus Sicherheitsaspekten sollte der Speicherort bei einem nicht-kontrollierten Setting in das private App-Verzeichnis verschoben werden. Die Daten werden nur lokal abgespeichert.


## Sponsoren, Mitwirkende und Danksagung

Das Verbundprojekt wurde vom Bundesministerium für Bildung und Forschung (BMBF) im Rahmen der Förderrichtline „Lebensqualität durch soziale Innovationen (FH-Sozial)“ im Programm „Forschung an Fachhochschulen“, Themenfeld „Soziale Innovationen zur digitalen Inklusion" gefördert. Es erstreckte sich über insgesamt dreidreiviertel Jahre (2019-2023).

Förderkennzeichen: FKZ 13FH515SA7 (KH Mainz) and FKZ 13FH515SB7 (OTH Regensburg)

Diese Personen waren an der Erstellung des Projektes beteiligt und haben ihr Einverständnis für die Nennung gegeben. Rechtlicher Hinweis: §13 Urheberrechtsgesetz (https://dejure.org/gesetze/UrhG/13.html)

**Projektleitung**

- Prof.in Dr. Sabine Corsten
- Prof.in Dr. Norina Lauer

**Wissenschaftliche Mitarbeiterinnen**

- Katharina Giordano
- Vera Leusch
- Almut Path

**Technische Mitarbeiter**

- Daniel Kreiter

**Studentische Hilftskräfte - Logopädie**

- Cäcilia Danner
- Johanna Coppers
- Jana Heidemann
- Karla Tiemann
- Pia Enzner

**Studentische Hilftskräfte – Technik**

- Michael Lazik

**Aufnahme und Mischung**

- Sonaris Tonstudio

**Sprecher**

- Tobias Radloff

**Weitere Mitwirkende, welche nicht genannt werden möchten.**

Vielen herzlichen Dank für Eure Unterstützung des Projekts!

## Mitwirken

Dieses Projekt wurde erfolgreich abgeschlossen und wird von uns in genau dieser Form nicht weiter aktiv entwickelt. Wir schätzen jedoch das Interesse der Open Source Community. Wir freuen uns, wenn Sie einen Fork erstellen und eigene Anpassungen vornehmen. Wir freuen uns darauf zu sehen, welche neuen Ideen und Verbesserungen aus der Community entstehen.

## Lizenz

Die in der App verwendeten Medien, wie Bilder, Grafiken und Texte für die Themen (Orte), befinden sich im Ordner Medien und unterliegen einer separaten Lizenz. Diese Lizenz ist in der LICENSE-Datei im Medien-Ordner beschrieben. Zudem finden Sie für jedes Medium eine Angabe des jeweiligen Lizenzgebers (Ostbayerische Technische Hochschule Regensburg oder Katholische Hochschule Mainz) in den Metadaten und/oder als separate Datei LICENSE in dem selben Verzeichnis.

In diesem Repository stellen wir Ihnen die Medien für das Thema "Garten" zur Verfügung.

Bitte beachten Sie, dass nur das "Beispiel-Thema" für die Benutzung freigegeben ist.
Für die Lizenzierung weiterer Themen wenden Sie sich bitte an uns unter denen in „Kontakt“ angegebenen Kontaktdaten.


## Genutzte Dart und Flutter Packages
- [ftpclient](https://pub.dev/packages/ftpclient) ([MIT](https://pub.dev/packages/ftpclient/license))
- [path_provider](https://pub.dev/packages/path_provider) ([BSD-3-Clause](https://pub.dev/packages/path_provider/license))
- [provider](https://pub.dev/packages/provider) ([MIT](https://pub.dev/packages/provider/license))
- [json_annotation](https://pub.dev/packages/json_annotation) ([BSD-3-Clause](https://pub.dev/packages/json_annotation/license))
- [meta](https://pub.dev/packages/meta) ([BSD-3-Clause](https://pub.dev/packages/meta/license))
- [shared_preferences](https://pub.dev/packages/shared_preferences) ([BSD-3-Clause](https://pub.dev/packages/shared_preferences/license))
- [get_it](https://pub.dev/packages/get_it) ([MIT](https://pub.dev/packages/get_it/license))
- [audioplayers](https://pub.dev/packages/audioplayers) ([MIT](https://pub.dev/packages/audioplayers/license))
- [transparent_image](https://pub.dev/packages/transparent_image) ([MIT](https://pub.dev/packages/transparent_image/license))
- [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar) ([MIT](https://pub.dev/packages/flutter_rating_bar/license))
- [intl](https://pub.dev/packages/intl) ([BSD-3-Clause](https://pub.dev/packages/intl/license))
- [enum_to_string](https://pub.dev/packages/enum_to_string) ([MIT](https://pub.dev/packages/enum_to_string/license))
- [flutter_svg](https://pub.dev/packages/flutter_svg) ([MIT](https://pub.dev/packages/flutter_svg/license))
- [cupertino_icons](https://pub.dev/packages/cupertino_icons) ([MIT](https://pub.dev/packages/cupertino_icons/license))
- [ssh2](https://pub.dev/packages/ssh2) ([MIT](https://pub.dev/packages/ssh2/license))
- [json_serializable](https://pub.dev/packages/json_serializable) ([BSD-3-Clause](https://pub.dev/packages/json_serializable/license))



## Kontakt

Nachdem die Projektlaufzeit des eigentlichen Forschungsprojekts abgelaufen ist, werden die Anwendung sowie dieses Repository nicht mehr vom BaSeTaLK-Team betreut. Falls Sie das Projekt selbstständig weiterentwickeln wollen, können Sie gerne einen Fork des Repositorys erstellen.

**Herausgeber**:

- Katholische Hochschule Mainz (KH)  
Saarstr. 3  
55122 Mainz
[https://www.kh-mz.de](https://www.kh-mz.de)

- Ostbayerische Technische Hochschule Regensburg (OTH)  
Seybothstr. 2  
93053 Regensburg
[https://www.oth-regensburg.de](https://www.oth-regensburg.de)

**Kontaktpersonen:**

- **Frau Prof.in Dr. Sabine Corsten**
Tel.: 06131 – 289 44 540  
Fax: 06131 – 289 44 8 540  
E-Mail: [sabine.corsten@kh-mz.de](mailto:sabine.corsten@kh-mz.de)
Katholische Hochschule Mainz (KH)  
Saarstr. 3  
55122 Mainz

- **Frau Prof.in Dr. Norina Lauer**
Tel.: +49 941 943-1087  
Fax: +49 941 943-1468  
E-Mail: [norina.lauer@oth-regensburg.de](mailto:norina.lauer@oth-regensburg.de)
Ostbayerische Technische Hochschule Regensburg (OTH)  
Seybothstr. 2  
93053 Regensburg

