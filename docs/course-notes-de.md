============================================================
       Zusammenfassung von allem, was wir gelernt haben
============================================================

In dieser Zusammenfassung erkläre ich kurz die Themen,
die wir im Unterricht gelernt und praktisch angewendet haben.
Dazu gehören das Terminal, Bash-Befehle, Netzwerke, Server,
Git, GitLab, Container und das Starten von Diensten.

Wir haben außerdem mit unserem Hochschul-Account ein
Beleg-Projekt auf GitLab erstellt. Dort haben wir unsere
Arbeiten hochgeladen und einen großen Teil der gelernten
Themen praktisch umgesetzt.


============================================================
Teil 1: Linux und Bash
============================================================

1- Terminal und Linux
------------------------------------------------------------
Wir haben gelernt, was ein Terminal ist und wie man es unter
Linux öffnet. Über das Terminal können wir das System bedienen
und Befehle ohne eine grafische Oberfläche ausführen.


2- Grundlegende Bash-Befehle
------------------------------------------------------------
Wir haben gelernt, Dateien und Ordner zu erstellen, Dateien
zu öffnen und anzuzeigen sowie Dateien zu kopieren, zu
verschieben und zu löschen.

Wichtige Befehle:
pwd    ls    cd    mkdir    touch    cat    cp    mv    rm


3- Dateisystem und Berechtigungen
------------------------------------------------------------
Wir haben gelernt, wie das Linux-Dateisystem aufgebaut ist
und wie man zwischen Ordnern wechselt. Außerdem haben wir
Dateiberechtigungen angezeigt und verändert.

Wichtige Befehle:
ls -l
chmod


4- Umleitung und Verbindung von Befehlen
------------------------------------------------------------
Wir haben die Ausgabe eines Befehls mit > oder >> in einer
Datei gespeichert. Mit einer Pipe | konnten wir mehrere
Befehle miteinander verbinden.

Wichtige Zeichen:
>      >>      |


5- Variablen und Umgebung in Bash
------------------------------------------------------------
Wir haben Variablen im Terminal und in Skripten erstellt.
Außerdem haben wir Umgebungsvariablen wie PATH und HOME
kennengelernt und den Befehl export verwendet.


6- Suche in Dateien und Ordnern
------------------------------------------------------------
Wir haben mit find nach Dateien und Ordnern gesucht.
Mit grep haben wir bestimmte Wörter oder Texte innerhalb
von Dateien gefunden.

Wichtige Befehle:
find
grep


7- Bash-Skripte schreiben
------------------------------------------------------------
Wir haben Bash-Skripte geschrieben, die mit dieser Zeile
beginnen:

#!/bin/bash

Danach haben wir dem Skript Ausführungsrechte gegeben
und es über das Terminal gestartet.

Wichtige Befehle:
chmod +x script.sh
./script.sh


8- Skripte verbessern
------------------------------------------------------------
Wir haben Bedingungen wie if und else, Schleifen wie for
und while sowie Funktionen und Variablen verwendet.
Dadurch konnten unsere Skripte mehrere Aufgaben ausführen.


============================================================
Teil 2: Prozesse unter Linux
============================================================

9- Prozesse verwalten
------------------------------------------------------------
Wir haben gelernt, dass laufende Programme unter Linux
Prozesse genannt werden. Wir haben Prozesse angezeigt,
beendet und Programme im Hintergrund gestartet.

Wichtige Befehle:
ps
top
kill


10- Signale
------------------------------------------------------------
Wir haben gelernt, dass Linux Signale zur Steuerung von
Prozessen verwendet. SIGTERM beendet einen Prozess normal,
während SIGKILL das Beenden erzwingt.


============================================================
Teil 3: Netzwerke und Serververbindung
============================================================

11- Grundlagen der Netzwerke
------------------------------------------------------------
Wir haben Grundlagen wie IP-Adressen, MAC-Adressen, Ports
und Protokolle kennengelernt. Außerdem haben wir verstanden,
wie Geräte im Netzwerk und über das Internet kommunizieren.


12- Internet, DNS und Routing
------------------------------------------------------------
Wir haben gelernt, dass DNS einen Domainnamen in eine
IP-Adresse umwandelt. Ein Router leitet Daten zwischen
verschiedenen Netzwerken weiter.


13- Werkzeuge zur Netzwerkprüfung
------------------------------------------------------------
Wir haben Befehle verwendet, um Verbindungen zu prüfen,
die IP-Adresse anzuzeigen, den Weg der Daten zu verfolgen
und offene Ports und Verbindungen zu sehen.

Wichtige Befehle:
ping
ip addr
traceroute
ss
netstat


14- SSH und Fernzugriff
------------------------------------------------------------
Wir haben SSH verwendet, um über das Terminal eine Verbindung
zu einem anderen Computer oder Server herzustellen. Danach
konnten wir Befehle auf dem entfernten Server ausführen.


15- Verbindung mit dem Hochschulserver
------------------------------------------------------------
Wir haben uns über SSH mit dem Server der Hochschule
verbunden, zum Beispiel mit:

ssh local@user.f4.htw-berlin.de

Teilweise haben wir uns als root angemeldet. Danach haben
wir einen neuen Benutzer erstellt und ihm die benötigten
Berechtigungen gegeben, damit wir nicht alle Aufgaben als
root ausführen müssen.


============================================================
Teil 4: Git und GitLab
============================================================

16- Git und Versionsverwaltung
------------------------------------------------------------
Wir haben Git verwendet, um Änderungen an unserem Projekt
zu speichern. Außerdem haben wir Repositorys und Branches
kennengelernt.

Wichtige Befehle:
git status
git add .
git commit -m "message"
git push


17- GitLab
------------------------------------------------------------
Wir haben uns mit unserem Hochschul-Account bei GitLab
angemeldet und dort ein Beleg-Projekt erstellt. In diesem
Projekt haben wir unsere Arbeiten aus dem Unterricht
gespeichert.

Mit git clone haben wir das Projekt heruntergeladen und mit
git push die neuen Änderungen zu GitLab hochgeladen.

Wichtige Befehle:
git clone
git pull
git push


18- CI/CD
------------------------------------------------------------
Wir haben gelernt, dass CI/CD nach dem Hochladen eines
Projekts automatisch bestimmte Schritte ausführen kann.
Dazu gehören das Prüfen der Dateien, das Bauen des Projekts
oder das Starten des Programms.


============================================================
Teil 5: Serversicherheit und Daten
============================================================

19- Firewall
------------------------------------------------------------
Wir haben gelernt, dass eine Firewall die ein- und
ausgehenden Verbindungen eines Servers kontrolliert.
Benötigte Ports können geöffnet und unnötige Ports
geschlossen werden.


20- Datenformate
------------------------------------------------------------
Wir haben Datenformate wie JSON und YAML kennengelernt.
Diese Formate wurden für Konfigurationsdateien benutzt,
weil sie übersichtlich und für Programme lesbar sind.


============================================================
Teil 6: Container und Dienste
============================================================

21- Container
------------------------------------------------------------
Wir haben gelernt, dass Programme zusammen mit ihren
Abhängigkeiten in einer isolierten Umgebung ausgeführt
werden können. Außerdem haben wir den Unterschied zwischen
Containern und virtuellen Maschinen kennengelernt.


22- Compose
------------------------------------------------------------
Wir haben Compose benutzt, um mehrere Container gemeinsam
zu starten, zum Beispiel eine Anwendung zusammen mit einer
Datenbank.

Die Dienste, Netzwerke und Volumes wurden in dieser Datei
festgelegt:

compose.yaml


23- Konfigurationsdateien .env
------------------------------------------------------------
Wir haben eine .env-Datei verwendet, um Variablen und
Einstellungen wie Benutzernamen, Passwörter und Portnummern
zu speichern. Dadurch mussten diese Informationen nicht
direkt in die Projektdateien geschrieben werden.


24- Infrastructure as Code
------------------------------------------------------------
Wir haben gelernt, dass Server und Dienste durch Dateien
und Code eingerichtet werden können. Dadurch können die
Einstellungen einfacher wiederholt, verändert und auf
andere Server übertragen werden.


============================================================
Teil 7: Praktische Umsetzung und Fehlersuche
============================================================

25- Praktische Umsetzung im Beleg-Projekt
------------------------------------------------------------
Wir haben die gelernten Themen in unserem Beleg-Projekt
praktisch angewendet. Dazu gehörten Linux, Bash-Befehle,
Skripte, die Serververbindung, GitLab, Netzwerke und das
Starten von Diensten in Containern.


26- Fehlersuche und Problemlösung
------------------------------------------------------------
Bei Problemen haben wir Fehlermeldungen, Prozesse,
Verbindungen, Ports und Konfigurationsdateien geprüft.
Danach haben wir die möglichen Ursachen Schritt für Schritt
untersucht und den Fehler behoben.
