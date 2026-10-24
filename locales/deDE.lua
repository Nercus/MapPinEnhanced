---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

if MapPinEnhanced.locale ~= "deDE" then return end

---@class Locale
local L = MapPinEnhanced.L

------------------------------ Shared UI ------------------------------
L["Cancel"] = "Abbrechen"
L["Close"] = "Schließen"
L["A new version (%s) for Map Pin Enhanced is available. You are on (%s)."] =
"Eine neue Version (%s) von Map Pin Enhanced ist verfügbar. Du verwendest (%s)."
L["Addon conflicts"] = "Add-on-Konflikte"
L["The following addons interfere with Map Pin Enhanced and should not be used together:\n\n%s\n\nDisable them in the AddOns menu and reload your UI."] =
"Die folgenden Addons verursachen Konflikte mit Map Pin Enhanced und sollten nicht zusammen verwendet werden:\n\n%s\n\nDeaktiviere sie im Addon-Menü und lade deine Benutzeroberfläche neu."
L["Confirm"] = "Bestätigen"
L["Icon Picker"] = "Symbolauswahl"
L["Select an icon"] = "Symbol auswählen"
L["%d icons"] = "%d Symbole"
L["%d icons (loading...)"] = "%d Symbole (wird geladen...)"
L["Import"] = "Importieren"
L["Save"] = "Speichern"
L["Stop tracking"] = "Verfolgung beenden"
L["This is the location you are navigating to."] = "Dies ist der Ort, zu dem du navigierst."
L["Track"] = "Verfolgen"
L["Remove"] = "Entfernen"

L["Click to edit"] = "Zum Bearbeiten hier klicken"
L["<x> <y> [title]"] = "<x> <y> [Titel]"
L["Create and track a pin at percentage coordinates. Example: /mpe 50 50 My pin"] =
"Erstelle und verfolge eine Markierung an Prozentkoordinaten. Beispiel: /mpe 50 50 Meine Markierung"
L["You can also use /way instead of /mpe."] = "Du kannst auch /way anstelle von /mpe verwenden."

L["Navigation Hearthstone Data Missing"] =
"Zielort des Ruhesteins unbekannt. Benutze deinen Ruhestein einmal, um ihn zu speichern."
L["Navigation Flight Data Missing"] = "Flugrouten noch nicht erfasst. Besuche einen Flugmeister, um sie zu erfassen."

------------------------------ Pins ------------------------------
L["Map Pin"] = "Kartenmarkierung"
L["Add Pin"] = "Markierung hinzufügen"
L["Target"] = "Ziel"
L["Change Color"] = "Farbe ändern"
L["Change Icon"] = "Symbol ändern"
L["Atlas"] = "Atlas"
L["Color"] = "Farbe"
L["Icon"] = "Symbol"
L["Locked"] = "Gesperrt"
L["Map"] = "Karte"
L["Name"] = "Name"
L["X"] = "X"
L["Y"] = "Y"
L["Show on Map"] = "Auf der Karte anzeigen"
L["Clear Pin"] = "Markierung entfernen"
L["Delete Permanently"] = "Endgültig löschen"
L["Delete pin \"%s\"?"] = "Markierung „%s“ löschen?"
L["Share to Chat"] = "Im Chat teilen"
L["Failed to place pin on the map. Please check if the coordinates are correct!"] =
"Die Markierung konnte nicht auf der Karte gesetzt werden. Bitte prüfe, ob die Koordinaten stimmen!"
L["Can't Show on Map in Combat"] = "Kann im Kampf nicht auf der Karte angezeigt werden"
L["The world map cannot be opened automatically during combat. It will open after combat ends."] =
"Die Weltkarte lässt sich während eines Kampfes nicht automatisch öffnen. Sie wird erst nach Ende des Kampfes geöffnet."

------------------------------ Groups And Tracker ------------------------------
L["Group"] = "Gruppe"
L["Hidden"] = "Versteckt"
L["Show hidden group"] = "Versteckte Gruppe anzeigen"
L["No hidden groups"] = "Keine versteckten Gruppen"
L["Your pins (%d)"] = "Deine Markierungen (%d)"
L["New Group %d"] = "Neue Gruppe %d"
L["Groups"] = "Gruppen"
L["Create Group"] = "Gruppe erstellen"
L["Select"] = "Auswählen"
L["Select a group to start editing."] = "Wähle eine Gruppe aus, um sie zu bearbeiten."
L["Show"] = "Anzeigen"
L["Hide"] = "Ausblenden"
L["Ungrouped Pins"] = "Nicht gruppierte Markierungen"
L["My Way Back"] = "Mein Weg zurück"
L["Import %d"] = "Import %d"
L["%d |4pin:pins;"] = "%d |4Markierung:Markierungen;"
L["A group named \"%s\" already exists."] = "Eine Gruppe mit dem Namen „%s“ existiert bereits."
L["Rename Group"] = "Gruppe umbenennen"
L["Add to New Group"] = "Zu neuer Gruppe hinzufügen"
L["Delete Group"] = "Gruppe löschen"
L["Clear Group"] = "Gruppe leeren"
L["Show Group"] = "Gruppe anzeigen"
L["Hide Group"] = "Gruppe ausblenden"
L["Restore Pins"] = "Markierungen wiederherstellen"
L["Make pins restorable"] = "Wiederherstellung von Markierungen erlauben"
L["Delete group \"%s\" and all of its pins?"] = "Gruppe „%s“ und alle ihre Markierungen löschen?"
L["Clear all pins from \"%s\"?"] = "Alle Markierungen aus „%s“ entfernen?"
L["Tracking Mode"] = "Verfolgungsmodus"
L["Track by Distance"] = "Nach Entfernung verfolgen"
L["Track by Travel Time"] = "Strecke nach Fahrzeit"
L["Next Pin Travel Time Description"] = "Während der Fahrt wird anhand der aktivierten Reiseoptionen der schnellste nächste Zielort von Ihrem aktuellen Standort aus ermittelt. Bei der Ankunft wird diese Schätzung verwendet, sofern sie bereits vorliegt und noch gültig ist; andernfalls erfolgt die Auswahl nach Entfernung."

L["Track by Order"] = "Nach Reihenfolge verfolgen"
L["Toggle the tracker visibility."] = "Die Sichtbarkeit des Trackers umschalten."
L["Dungeon"] = "Dungeon"
L["Raid"] = "Schlachtzug"
L["Scenario"] = "Szenario"
L["Battleground"] = "Schlachtfeld"
L["Arena"] = "Arena"
L["None"] = "Keine"
L["No active pins"] = "Keine aktiven Markierungen"
L["No coordinates available"] = "Keine Koordinaten verfügbar"
L["Coordinates.Visibility_LABEL"] = "Automatisch ausblenden"
L["Coordinates.Visibility_DESCRIPTION"] =
"Die Koordinatenanzeige ausblenden, wenn eine der ausgewählten Bedingungen aktiv ist."
L["Tracker.Visibility_LABEL"] = "Automatisch ausblenden"
L["Tracker.Visibility_DESCRIPTION"] =
"Den Tracker ausblenden, wenn eine der ausgewählten Bedingungen erfüllt ist."
L["Toggle the group editor."] = "Den Gruppeneditor ein- bzw. ausschalten."

------------------------------ Editor ------------------------------
L["Editor"] = "Editor"
L["Edit Group"] = "Gruppe bearbeiten"
L["Search"] = "Suche"
L["Rename Pin"] = "Markierung umbenennen"
L["Create a new pin group."] = "Erstelle eine neue Gruppe für Markierungen."
L["Choose an icon for this group."] = "Wähle ein Symbol für diese Gruppe."
L["Delete this group and all of its pins. System groups are cleared instead."] =
"Diese Gruppe und alle ihre Markierungen löschen. Systemgruppen werden stattdessen geleert."
L["Hide or show this group."] = "Diese Gruppe ausblenden oder anzeigen."
L["Permanently delete this pin."] = "Diese Markierung endgültig löschen."
L["Create a copy of this pin."] = "Eine Kopie dieser Markierung erstellen."
L["copy of %s"] = "Kopie von %s"
L["Loading"] = "Wird geladen"

------------------------------ Dialogs ------------------------------
L["Version: %s (%s)"] = "Version: %s (%s)"
L["Build: %s"] = "Build: %s"
L["Special thanks to Byyrax and Pamoo for the help with translations"] =
"Ein besonderer Dank geht an Byyrax und Pamoo für ihre Hilfe bei den Übersetzungen"
L["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs!"] =
"Vielen Dank an Eminos für die unzähligen Stunden, die er damit verbracht hat, Texturen zu erstellen, „Rubber-Ducking“ zu betreiben und gemeinsam mit mir Ideen zu entwickeln. Vielen Dank an alle, die mir beim Testen neuer Versionen geholfen, Feedback gegeben und Fehler gemeldet haben!"
L["Open the about dialog to view version information."] = "Öffne den Info-Dialog, um Versionsinformationen anzuzeigen."

------------------------------ Transfer ------------------------------
L["Export"] = "Exportieren"
L["Way commands"] = "Way-Befehle"
L["Serialized data"] = "Serialisierte Daten"
L["Open the import dialog to import map pins from a string."] =
"Öffne den Importdialog, um Kartenmarkierungen aus einer Zeichenfolge zu importieren."
L["You can import pins by pasting multiple slash commands or a Map Pin Enhanced export string (starting with %s)"] =
"Du kannst Markierungen importieren, indem du mehrere Slash-Befehle oder eine Exportzeichenfolge von Map Pin Enhanced (beginnend mit %s) einfügst."
L["Click to paste export string or slash commands here"] =
"Hier klicken, um eine Exportzeichenfolge oder Slash-Befehle einzufügen"
L["Choose an export format, then copy the text below."] = "Wähle ein Exportformat und kopiere dann den folgenden Text."
L["Command prefix:"] = "Befehlspräfix:"
L["Exporting %d pins across %d maps"] = "Export von %d |4Markierung:Markierungen; auf %d |4Karte:Karten;"
L["%s: %d pins across %d maps"] = "%s: %d |4Markierung:Markierungen; auf %d |4Karte:Karten;"
L["%d invalid entries will be skipped"] = "%d |4ungültiger Eintrag wird:ungültige Einträge werden; übersprungen"
L["Invalid or corrupted serialized data."] = "Ungültige oder beschädigte serialisierte Daten."
L["No valid pins were found to import."] = "Keine gültigen Markierungen zum Importieren gefunden."
L["Importing %d pins; skipped %d invalid entries."] =
"Import von %d |4Markierung:Markierungen;; %d |4ungültiger Eintrag:ungültige Einträge; übersprungen."
L["Import failed."] = "Der Import ist fehlgeschlagen."
L["Warning: slash commands do not preserve descriptions, custom icons or colors. /mappin also omits pin titles."] =
"Warnung: Bei Slash-Befehlen bleiben Beschreibungen, benutzerdefinierte Symbole und Farben nicht erhalten. Bei /mappin werden zudem die Titel der Markierungen weggelassen."

------------------------------ Providers ------------------------------
L["%s added hidden group \"%s\"."] = "%s hat die versteckte Gruppe „%s“ hinzugefügt."
L["TomTom Pins"] = "TomTom-Markierungen"
L["TomTom Waypoint"] = "TomTom-Wegpunkt"
L["TomTom Is Loaded! You may experience some unexpected behavior."] =
"TomTom ist geladen! Es kann zu unerwartetem Verhalten kommen."
L["\"%s\" reached at %s."] = "„%s“ bei %s erreicht."
L["Location reached at %s."] = "Ziel bei %s erreicht."
L["Equipped %s."] = "%s ausgerüstet."
L["Re-equipped %s."] = "%s wieder angelegt."
L["Restored empty equipment slot."] = "Der leere Ausrüstungsplatz wurde wiederhergestellt."
L["Could not restore %s."] = "%s konnte nicht wiederhergestellt werden."
L["Could not restore empty equipment slot."] = "Der leere Ausrüstungsplatz konnte nicht wiederhergestellt werden."
L["It is locked."] = "Die Markierung ist gesperrt."
L["Turn in: %s"] = "Abgeben: %s"
L["Corpse"] = "Leiche"
L["Quest"] = "Quest"
L["Content"] = "Inhalt"
L["Vignette"] = "Interessanter Ort"
L["House"] = "Haus"
L["%s's House"] = "Das Haus von %s"

------------------------------ Miscellaneous ------------------------------
L["Back"] = "Zurück"
L["Create a Pin at Your Current Location"] = "Markierung am aktuellen Standort erstellen"
L["Unable to determine your current map location."] =
"Dein aktueller Standort auf der Karte kann nicht ermittelt werden."
L["Unable to determine your current position on the map."] =
"Deine aktuelle Position auf der Karte kann nicht ermittelt werden."
L["%s's Position"] = "Position von %s"
L["You Are in an Instance or a Zone Where the Map Is Not Available"] =
"Du befindest dich in einer Instanz oder einem Gebiet, in dem die Karte nicht verfügbar ist."
L["My Way Back is unavailable on the map you are on right now."] =
"„Mein Weg zurück“ ist auf deiner aktuellen Karte nicht verfügbar."

------------------------------ Options ------------------------------
L["General"] = "Allgemein"
L["Pins"] = "Markierungen"
L["Miscellaneous"] = "Verschiedenes"
L["Wayfinder"] = "Wegweiser"
L["Search for option..."] = "Nach Option suchen..."
L["Open the options frame"] = "Optionsfenster öffnen"
L["Open options"] = "Optionen öffnen"
L["Open editor"] = "Editor öffnen"

L["Clear all pins"] = "Alle Markierungen entfernen"
L["Some pins are still being updated. Try clearing again when the current operation finishes."] =
"Einige Markierungen werden noch aktualisiert. Versuche das Entfernen erneut, sobald der aktuelle Vorgang abgeschlossen ist."
L["Hide minimap button"] = "Minikarten-Schaltfläche ausblenden"
L["Toggle the minimap button visibility."] = "Die Sichtbarkeit der Minikarten-Schaltfläche umschalten."
L["General.ShowMinimapButton_LABEL"] = "Minikarten-Schaltfläche anzeigen"
L["General.ShowMinimapButton_DESCRIPTION"] = "Zeige die Add-on-Schaltfläche auf der Minikarte an."
L["General.CustomMinimapButton_LABEL"] = "Benutzerdefinierte Minikarten-Schaltfläche"
L["General.CustomMinimapButton_DESCRIPTION"] =
"Verwende ein größeres Logo ohne den üblichen Rahmen und Hintergrund der Minikarten-Schaltfläche."
L["Wayfinder.ShowDistanceUnit_LABEL"] = "Entfernungseinheit anzeigen"
L["Wayfinder.ShowDistanceUnit_DESCRIPTION"] = "Zeige die Entfernungseinheit neben den Entfernungswerten an."
L["Reload UI"] = "UI neu laden"
L["This change requires a UI reload. Reload now?"] =
"Diese Änderung erfordert eine Neuladung der Benutzeroberfläche. Jetzt neu laden?"

L["Pins.ScaleOnHover_LABEL"] = "Markierungen beim Darüberfahren vergrößern"
L["Pins.ScaleOnHover_DESCRIPTION"] = "Vergrößere Weltkartenmarkierungen beim Darüberfahren mit der Maus."

L["Coordinates.Enable_LABEL"] = "Koordinatenanzeige aktivieren"
L["Coordinates.Enable_DESCRIPTION"] =
"Anzeige deiner aktuellen Koordinaten auf dem Bildschirm ein- oder ausschalten"
L["Coordinates.Lock_LABEL"] = "Anzeige der Koordinaten sperren"
L["Coordinates.Lock_DESCRIPTION"] = "Lege fest, ob sich die Koordinatenanzeige verschieben lässt."

L["Wayfinder.HideBlizzardFloatingDiamond_LABEL"] = "Blizzards schwebende Raute ausblenden"
L["Wayfinder.HideBlizzardFloatingDiamond_DESCRIPTION"] =
"Blizzards schwebende Navigationsraute ausblenden, wenn der schwebende Wegweiser von Map Pin Enhanced deaktiviert ist."
L["Wayfinder.Selection_LABEL"] = "Wegweiser"
L["Wayfinder.Selection_DESCRIPTION"] = "Wähle den Wegweiser für die Navigation."
L["Arrow"] = "Pfeil"
L["Floating"] = "Schwebend"
L["Navigation"] = "Navigation"
L["Navigation.Enable_LABEL"] = "Routennavigation aktivieren"
L["Navigation.Enable_DESCRIPTION"] =
"Berechne Reiserouten unter Berücksichtigung der verfügbaren Bewegungsmöglichkeiten, Portale, Transportmittel, Zaubersprüche, Gegenstände und Spielzeuge."
L["Navigation.AutomaticTravelSelection_LABEL"] = "Automatische Reiseauswahl"
L["Navigation.AutomaticTravelSelection_DESCRIPTION"] =
"Wähle automatisch die NPC-Dialogoptionen und Flugziele aus, die für deine aktuelle Route erforderlich sind. Halte die Umschalttaste gedrückt, wenn du die Flugkarte öffnest, um einen Flug manuell auszuwählen."
L["Navigation.WorldMap_LABEL"] = "Route auf der Weltkarte anzeigen"
L["Navigation.WorldMap_DESCRIPTION"] = "Zeige die berechnete Route auf der Weltkarte an."
L["Navigation.Minimap_LABEL"] = "Route auf der Minikarte anzeigen"
L["Navigation.Minimap_DESCRIPTION"] = "Zeige die berechnete Route auf der Minikarte an."
L["Navigation Calculating"] = "Route wird berechnet..."
L["Navigation Direct Guidance"] = "Keine Route verfügbar. Begib dich direkt zum Ziel."
L["Navigation No Direction"] = "Für dieses Ziel liegen keine Wegbeschreibungen vor."
L["Navigation Step Waiting Combat"] =
"Dieser Schritt ist möglicherweise nicht auf dem neuesten Stand. Er wird aktualisiert, sobald der Kampf beendet ist."
L["Navigation Action Shift Combat"] =
"Drücke die Umschalttaste und klicke mit der linken Maustaste, um die angezeigte Aktion im Kampf auszuführen."
L["Navigation Action Unavailable Combat"] = "Diese Aktion steht nach dem Kampf zur Verfügung."
L["Navigation Action Started"] = "Warte auf Ankunftsbestätigung."
L["Navigation Action Failed"] = "Die Aktion wurde nicht abgeschlossen. Versuche es erneut oder berechne die Route neu."
L["Navigation Finding Another Route"] = "Andere Route wird gesucht..."
L["Navigation Arrival Confirming"] = "Ankunft bestätigen..."
L["Navigation Walk"] = "Begib dich zum nächsten Punkt."
L["Navigation Fly"] = "Flieg zum nächsten Punkt."
L["Navigation Travel To Destination"] = "Reise nach %s."
L["Navigation Fly To Destination"] = "Fliege nach %s."
L["Navigation Route To"] = "Route nach: %s (%s)"
L["Navigation Chat Header"] = "Route nach: %s (%s) - %s"
L["Navigation Chat Unavailable"] =
"Wähle einen verfügbaren Chatkanal oder einen Flüsterempfänger, bevor du die Route exportierst."
L["Send"] = "Senden"
L["Navigation Chat Choose Channel"] = "Wähle, wohin diese Route gesendet werden soll:"
L["Navigation Chat Whisper To"] = "Flüstern an"
L["Navigation Chat Player Name"] = "Spielername oder Name-Realm"
L["Navigation Chat Route Changed"] = "Die Route hat sich geändert. Schließe diesen Dialog und exportiere sie erneut."
L["Party"] = "Gruppe"
L["Say"] = "Sagen"
L["Whisper"] = "Flüstern"
L["Navigation Step Number"] = "Schritt %d: %s"
L["Navigation Cross Border"] = "Gehe in das nächste Gebiet."
L["Navigation Change Floor"] = "Wechsle zur angegebenen Etage."
L["Navigation Talk To NPC"] = "Sprich mit dem angegebenen NPC."
L["Navigation Method Travel"] = "Reisen"
L["Navigation Method Walking"] = "Zu Fuß"
L["Navigation Method Flying"] = "Fliegen"
L["Navigation Method Portal"] = "Portal"
L["Navigation Method NPC Travel"] = "Reise per NPC"
L["Navigation Method Border"] = "Grenzübergang"
L["Navigation Method Floor Change"] = "Etagenwechsel"
L["Navigation Method Spell"] = "Zauber"
L["Navigation Method Item"] = "Gegenstand"
L["Navigation Method Toy"] = "Spielzeug"
L["Navigation Method Boat"] = "Boot"
L["Navigation Method Hearthstone"] = "Ruhestein"
L["Navigation Method Flight Taxi"] = "Flugmeister"
L["Navigation Method Phase Change"] = "Phasenwechsel"
L["Navigation Method Ship"] = "Schiff"
L["Navigation Method Tram"] = "Straßenbahn"
L["Navigation Method Transport"] = "Transport"
L["Navigation Method Lift"] = "Aufzug"

L["Navigation Method Teleport"] = "Teleportieren"
L["Navigation Method Zeppelin"] = "Zeppelin"
L["Navigation Use Spell"] = "Wende den erforderlichen Zauber an."
L["Navigation Use Item"] = "Benutze den erforderlichen Gegenstand."
L["Navigation Use Toy"] = "Verwende das erforderliche Spielzeug."
L["Navigation Use Hearthstone"] = "Benutze deinen Ruhestein."
L["Navigation Use Teleport"] = "Benutze den angegebenen Teleport."
L["Navigation Take Portal"] = "Geh durch das Portal."
L["Navigation Take Portal To"] = "Nimm das Portal nach %s."
L["Navigation Take Portal From To"] = "Nimm das Portal von %s nach %s."
L["Navigation Cross Border To"] = "Gehe nach %s."
L["Navigation Change Floor To"] = "Wechsle die Etage, um %s zu erreichen."
L["Navigation Talk To NPC To"] = "Sprich mit dem angegebenen NPC, um %s zu erreichen."
L["Navigation Cast Named Spell"] = "Wirke %s."
L["Navigation Cast Named Spell To"] = "Wende %s an, um dich nach %s zu teleportieren."
L["Navigation Cast Named Spell Return"] = "Wirke %s, um nach %s zurückzukehren."
L["Navigation Use Toy And Select"] = "Verwende %s, gehe dann in Interaktion und wähle %s aus."
L["Navigation Select Toy Destination"] = "Interagiere mit dem Spielzeug und wähle %s aus."
L["Navigation Cast And Select"] = "Wende %s an, interagiere anschließend und wähle %s aus."
L["Navigation Select Spell Destination"] = "Interagiere mit dem herbeigerufenen Transportmittel und wähle %s aus."

L["Navigation Use Named Item"] = "Verwende %s."
L["Navigation Use Named Item To"] = "Verwende %s, um nach %s zu reisen."
L["Navigation Use Named Item Return"] = "Benutze %s, um nach %s zurückzukehren."
L["Navigation Use Spell To"] = "Verwende den erforderlichen Zauber, um dich nach %s zu teleportieren."
L["Navigation Use Teleport To"] = "Nutze den angegebenen Teleport, um %s zu erreichen."
L["Navigation Use Item To"] = "Verwende den erforderlichen Gegenstand, um nach %s zu reisen."
L["Navigation Use Toy To"] = "Benutze das erforderliche Spielzeug, um nach %s zu reisen."
L["Navigation Use Hearthstone To"] = "Benutze deinen Ruhestein, um nach %s zurückzukehren."
L["Navigation Take Boat"] = "Nimm das Boot."
L["Navigation Take Boat To"] = "Fahre mit dem Boot nach %s."
L["Navigation Traveling By Boat"] = "Mit dem Boot reisen."
L["Navigation Traveling By Boat To"] = "Mit dem Boot nach %s reisen."
L["Navigation Take Ship"] = "Nimm das Schiff."
L["Navigation Take Ship To"] = "Fahre mit dem Schiff nach %s."
L["Navigation Traveling By Ship"] = "Reisen mit dem Schiff."
L["Navigation Traveling By Ship To"] = "Mit dem Schiff nach %s reisen."
L["Navigation Take Zeppelin"] = "Nimm den Zeppelin."
L["Navigation Take Zeppelin To"] = "Fahre mit dem Zeppelin nach %s."
L["Navigation Traveling By Zeppelin"] = "Reisen mit dem Zeppelin."
L["Navigation Traveling By Zeppelin To"] = "Mit dem Zeppelin nach %s reisen."
L["Navigation Take Tram"] = "Fahre mit der Straßenbahn."
L["Navigation Take Tram To"] = "Fahre mit der Straßenbahn nach %s."
L["Navigation Traveling By Tram"] = "Mit der Straßenbahn fahren."
L["Navigation Traveling By Tram To"] = "Mit der Straßenbahn nach %s fahren."
L["Navigation Take Transport"] = "Benutze das Transportmittel."
L["Navigation Take Transport To"] = "Benutze das Transportmittel nach %s."
L["Navigation Traveling By Transport"] = "Unterwegs mit dem Transportmittel."
L["Navigation Traveling By Transport To"] = "Unterwegs mit dem Transportmittel nach %s."
L["Navigation Take Lift"] = "Nimm den Aufzug."
L["Navigation Take Lift To"] = "Fahren Sie mit dem Aufzug bis zur Etage %s."
L["Navigation Traveling By Lift"] = "Mit dem Aufzug fahren."
L["Navigation Traveling By Lift To"] = "Mit dem Aufzug nach %s fahren."

L["Navigation Take Flight To"] = "Nimm den Flug nach %s."
L["Navigation Take Flight"] = "Nimm den Flug."
L["Navigation Traveling By Flight"] = "Flug läuft."
L["Navigation Traveling By Flight To"] = "Flug nach %s läuft."
L["Recalculate Route"] = "Route neu berechnen"
L["%s - %s"] = "%s – %s"
L["System Groups"] = "Systemgruppen"
L["System groups are managed by Map Pin Enhanced for special features. Their core settings cannot be changed."] =
"Systemgruppen werden von „Map Pin Enhanced“ für spezielle Funktionen verwaltet. Ihre Grundeinstellungen können nicht geändert werden."


L["Report"] = "Bericht"
L["Report a navigation problem"] = "Ein Navigationsproblem melden"
L["Help improve navigation"] = "Hilf mit, die Navigation zu verbessern"
L["Describe the problem, then copy the report below and post it on either issue page. Copy a URL into your browser to get started."] =
"Beschreibe das Problem, kopiere den Bericht unten und veröffentliche ihn auf einer der beiden Fehlermeldungsseiten. Kopiere eine URL in deinen Browser, um zu beginnen."
L["What went wrong?"] = "Was ist schiefgelaufen?"
L["What happened, what did you expect, and how can we reproduce it?"] =
"Was ist passiert, was hast du erwartet und wie können wir das nachstellen?"
L["Your report (description and debug data)"] = "Dein Bericht (Beschreibung und Debug-Daten)"
L["Click the report or a URL to select it, then press Ctrl+C to copy."] =
"Klicke auf den Bericht oder eine URL, um den Text auszuwählen, und drücke Strg+C zum Kopieren."
L["Navigation Debug Dump"] = "Navigations-Debug-Dump"


L["Description"] = "Beschreibung"
L["Edit Description"] = "Beschreibung bearbeiten"
L["Add notes for this pin. Descriptions appear in pin tooltips and below the wayfinder title."] =
"Füge Notizen zu dieser Markierung hinzu. Beschreibungen erscheinen in den Tooltips der Markierungen und unter dem Titel des Wegweisers."
L["This pin is no longer in this group."] = "Diese Markierung gehört nicht mehr zu dieser Gruppe."
L["Apply"] = "Übernehmen"

L["Wayfinder.ScaleWithDistance_LABEL"] = "Skalierung mit der Entfernung"
L["Wayfinder.ScaleWithDistance_DESCRIPTION"] =
"Die schwebende Markierung und ihr Strahl wachsen beim Näherkommen von 75% auf 100%. Die Entfernungsbereiche richten sich nach deiner beim Laden des Addons erlernten Reit- oder Flugfähigkeit und bleiben bis zum Neuladen unverändert."
L["Wayfinder.ShowBeam_LABEL"] = "Strahl anzeigen"
L["Wayfinder.ShowBeam_DESCRIPTION"] =
"Zeige einen Strahl über der schwebenden Markierung an, wenn diese auf dem Bildschirm zu sehen ist."
L["Wayfinder.ShowTextOutline_LABEL"] = "Textkontur anzeigen"
L["Wayfinder.ShowTextOutline_DESCRIPTION"] =
"Distanz, geschätzte Ankunftszeit und den beim Einblenden oder Darüberfahren angezeigten Titel der schwebenden Markierung mit einer Textkontur versehen."
L["Wayfinder.ShowETA_LABEL"] = "Voraussichtliche Ankunftszeit anzeigen"
L["Wayfinder.ShowObjectiveFrame_LABEL"] = "Questziel-Rahmen anzeigen"
L["Wayfinder.ShowObjectiveFrame_DESCRIPTION"] =
"Questziele beim Betreten eines Zielgebiets anzeigen. Wenn deaktiviert, wird der schwebende Wegweiser ausgeblendet und der Pfeil bleibt in seiner Nahansicht."
L["Wayfinder.ShowETA_DESCRIPTION"] =
"Zeige die geschätzte Reisezeit zum aktuellen Ziel neben der Entfernung an, sofern verfügbar."
L["Navigation.TransportationGroups_LABEL"] = "Transportmittel"
L["Navigation.TransportationGroups_DESCRIPTION"] =
"Wähle, welche Transportmittel die Navigation vorschlagen darf. Linienverkehr umfasst Boote, Zeppeline und Straßenbahnen. Persönliche Teleports umfassen Reisezauber, Gegenstände, Spielzeuge und den Dalaran-Ruhestein."
L["Navigation Transportation Portals"] = "Portale"
L["Navigation Transportation Flight paths"] = "Flugwege"
L["Navigation Transportation Scheduled transport"] = "Linienverkehr"
L["Navigation Transportation NPC travel"] = "Reise per NPC"
L["Navigation Transportation Phase changes"] = "Phasenübergänge"
L["Navigation Transportation Personal teleports"] = "Persönliche Teleportationen"
L["Navigation Transportation Dungeon teleports"] = "Dungeon-Teleports"

L["Settings for Floating; Arrow is still selected."] = "Einstellungen für „Schwebend“; „Pfeil“ ist weiterhin ausgewählt."
L["Settings for Arrow; Floating is still selected."] = "Einstellungen für „Pfeil“; „Schwebend“ ist weiterhin ausgewählt."

L["Clear Tracking"] = "Verfolgung beenden"
L["In objective area"] = "Im Zielgebiet"
L["Why do I see this navigation element?"] = "Warum wird dieses Navigationselement angezeigt?"
L["Wayfinder.Fallback_DESCRIPTION"] =
"Die Benutzeroberfläche von Blizzard kann für dieses Ziel in diesem Bereich keine verwertbaren Weltkoordinaten bereitstellen. Dieser Pfeil wird nur vorübergehend angezeigt und verschwindet wieder, sobald verwertbare Spielinformationen verfügbar sind."

L["Group sharing timed out. The sender must be online and the link must still be available."] =
"Die Zeit für die Freigabe in der Gruppe ist abgelaufen. Der Absender muss online sein und der Link muss noch verfügbar sein."
L["Requesting shared group..."] = "Geteilte Gruppe wird angefordert..."
L["Receiving shared group..."] = "Geteilte Gruppe wird empfangen..."
L["Shared group \"%s\" received."] = "Die freigegebene Gruppe „%s“ wurde empfangen."
L["This shared group is no longer available. Ask the sender for a new link."] =
"Diese geteilte Gruppe ist nicht mehr verfügbar. Bitte den Absender um einen neuen Link."

L["Pin operation stopped after %d of %d pins. Completed changes were kept."] =
"Die Aktion wurde nach %d von %d Markierungen gestoppt. Bereits abgeschlossene Änderungen wurden beibehalten."

-- Category options (0041).
L["Coordinates.ShowZone_LABEL"] = "Gebiet anzeigen"
L["Coordinates.ShowZone_DESCRIPTION"] =
"Zeige den vollständigen Kartennamen zwischen deinen X- und Y-Koordinaten an."
L["Coordinates.ShowDecimals_LABEL"] = "Dezimalstellen anzeigen"
L["Coordinates.ShowDecimals_DESCRIPTION"] =
"Zwei Dezimalstellen anzeigen. Deaktivieren, um gekürzte ganzzahlige Koordinaten anzuzeigen."
L["Pins.AlwaysPingTracked_LABEL"] = "Verfolgte Markierung dauerhaft pulsieren lassen"
L["Pins.AlwaysPingTracked_DESCRIPTION"] =
"Lass den Marker auf der Weltkarte alle zwei Sekunden blinken, solange er sichtbar ist."
L["Pins.MinimapScale_LABEL"] = "Größe der Markierungen auf der Minikarte"
L["Pins.MinimapScale_DESCRIPTION"] = "Wähle die Größe normaler Minikartenmarkierungen."
L["Pins.WorldMapScale_LABEL"] = "Größe der Weltkartenmarkierungen"
L["Pins.WorldMapScale_DESCRIPTION"] =
"Wähle die Größe normaler Weltkartenmarkierungen. Die Vergrößerung beim Darüberfahren wird zusätzlich angewendet."
L["Pins.DefaultColor_LABEL"] = "Standardfarbe der Markierungen"
L["Pins.DefaultColor_DESCRIPTION"] =
"Farbe für neue Markierungen ohne ausdrücklich festgelegtes Symbol oder Farbe. Bestehende und importierte Markierungen behalten ihr Aussehen."
L["Pins.FadeUntracked_LABEL"] = "Nicht verfolgte Markierungen abdunkeln"
L["Pins.FadeUntracked_DESCRIPTION"] =
"Die Deckkraft der nicht verfolgten Kartenmarkierungen auf 40 % reduzieren. Beim Bewegen des Mauszeigers über die Markierung wird die volle Deckkraft wiederhergestellt."
L["Pins.ShowMinimapPins_LABEL"] = "Minikarten-Markierungen anzeigen"
L["Pins.ShowMinimapPins_DESCRIPTION"] =
"Gewöhnliche Addon-Markierungen auf der Minikarte anzeigen. Minikarten-Markierungen erfordern Positionsaktualisierungen; Wegweiser und Routenmarkierungen bleiben davon unberührt."
L["Pins.EnableLockedPins_LABEL"] = "Sperren von Markierungen erlauben"
L["Pins.EnableLockedPins_DESCRIPTION"] =
"Neue Sperren erlauben. Gesperrte Markierungen bleiben bestehen, bis du sie entfernst; vorhandene Markierungen lassen sich jederzeit entsperren."
L["Pins.ArrivalNotification_LABEL"] = "Benachrichtigung beim Erreichen der Markierung"
L["Pins.ArrivalNotification_DESCRIPTION"] =
"Einmal pro Verfolgung-Sitzung benachrichtigen, sobald das endgültige Add-on-Ziel physisch erreicht wurde."
L["Pins.TomTom_LABEL"] = "TomTom-Integration aktivieren"
L["Pins.TomTom_DESCRIPTION"] = "Befolgen Sie die von TomTom ausgewählten Wegpunkte und Entfernungen oder übernehmen Sie TomTom-Wegpunkte aus anderen Add-ons, wenn TomTom nicht installiert ist. Durch Deaktivieren wird die Verfolgung des synchronisierten Ziels beendet und die vorhandenen Markierungen bleiben erhalten. Wählen Sie nach der Aktivierung erneut einen Wegpunkt aus, um fortzufahren."

L["Pins.AutoUntrack_LABEL"] = "Verfolgung automatisch beenden"
L["Pins.AutoUntrack_DESCRIPTION"] =
"Verfolgung durch das Addon und Blizzard beim Betreten eines Dungeons, Schlachtzugs, Szenarios, Schlachtfelds oder einer Arena beenden."
L["Tracker.AutoShow_LABEL"] = "Bei neuer Markierung automatisch anzeigen"
L["Tracker.AutoShow_DESCRIPTION"] =
"Zeige den Tracker an und klappe ihn auf, nachdem eine eigene Markierung erstellt oder ein Import bestätigt wurde. Das Verfolgen eines Blizzard-Elements löst dies nicht aus. Die Regeln zum automatischen Ausblenden gelten weiterhin."
L["Tracker.CloseAction_LABEL"] = "Tracker minimieren statt schließen"
L["Tracker.CloseAction_DESCRIPTION"] =
"Beim Minimieren des Trackers soll nur die Kopfzeile sichtbar bleiben."
L["Tracker.ShowCoordinates_LABEL"] = "Koordinaten anzeigen"
L["Tracker.ShowCoordinates_DESCRIPTION"] =
"Koordinaten neben dem Gebietsnamen in den Markierungseinträgen des Trackers anzeigen."
L["Tracker.MaximumRows_LABEL"] = "Maximale Anzahl sichtbarer Zeilen"
L["Tracker.MaximumRows_DESCRIPTION"] =
"Maximale Anzahl an Gruppen- und Markierungszeilen vor dem Scrollen, ohne Kopfzeile."
L["Tracker.BackgroundOpacity_LABEL"] = "Deckkraft des Tracker-Hintergrunds"
L["Tracker.BackgroundOpacity_DESCRIPTION"] = "Deckkraft hinter der Markierungsliste, von 0% bis 100%."
L["Tracker.Scale_LABEL"] = "Tracker-Größe"
L["Tracker.Scale_DESCRIPTION"] = "Wähle die Größe des Trackers."
L["Coordinates"] = "Koordinaten"
L["Tracker"] = "Tracker"
L["Small (90%)"] = "Klein (90 %)"
L["Default (100%)"] = "Standard (100 %)"
L["Large (125%)"] = "Groß (125 %)"
L["Huge (150%)"] = "Riesig (150 %)"
L["Red"] = "Rot"
L["Orange"] = "Orange"
L["Pale"] = "Blass"
L["Yellow"] = "Gelb"
L["Green"] = "Grün"
L["LightBlue"] = "Hellblau"
L["DarkBlue"] = "Dunkelblau"
L["Purple"] = "Lila"
L["Pink"] = "Rosa"
L["Only locked pins"] = "Nur gesperrte Markierungen"
L["All pins"] = "Alle Markierungen"
L["Disabled"] = "Deaktiviert"
L["Minimize"] = "Minimieren"
L["Expand"] = "Erweitern"
L["Lock Pin"] = "Markierung sperren"
L["Unlock Pin"] = "Markierung entsperren"

------------------------------ Legacy migration ------------------------------
L["Legacy migration could not update groups. Original saved data was kept."] =
"Bei der Migration aus dem Altsystem konnten die Gruppen nicht aktualisiert werden. Die ursprünglich gespeicherten Daten blieben erhalten."
L["Migrated %d legacy pins and %d saved sets. Original saved data was kept."] =
"%d alte Markierungen und %d gespeicherte Sets wurden migriert. Die ursprünglichen gespeicherten Daten blieben erhalten."
L["%d legacy entries could not be migrated. Original saved data was kept."] =
"%d alte Einträge konnten nicht migriert werden. Die ursprünglich gespeicherten Daten wurden beibehalten."

L["Navigation.RestoreEquipment_LABEL"] = "Ausrüstung nach der Reise wieder anlegen"
L["Navigation.RestoreEquipment_DESCRIPTION"] =
"Ausrüstung, die durch Navigationselemente ersetzt wurde, wiederherstellen und Ausrüstungsbenachrichtigungen anzeigen. Auch wenn diese Option deaktiviert ist, wird bereits ersetzte Ausrüstung wiederhergestellt."

L["Clear"] = "Löschen"
L["Options"] = "Optionen"
L["Minimap"] = "Minikarte"
L["Help"] = "Hilfe"
L["Clear all active pins in visible groups."] = "Alle aktiven Markierungen in sichtbaren Gruppen entfernen."

-- Startup introduction
L["Example pin"] = "Beispielmarkierung"
L["Introduction"] = "Einleitung"
L["Step %d of %d"] = "Schritt %d von %d"
L["Reset the startup introduction."] = "Die Einführungssequenz beim Start zurücksetzen."
L["This introduction covers some of the addon's core settings. You can change all of these choices later in settings."] =
"Diese Einführung erklärt einige Grundeinstellungen des Addons. Du kannst diese Auswahl später jederzeit in den Einstellungen ändern."
L["Floating shows a diamond in the world at your target. Arrow uses a simple pointer to show the direction."] =
"„Schwebend“ zeigt eine Raute an deinem Ziel in der Spielwelt. „Pfeil“ zeigt die Richtung mit einem einfachen Zeiger an."
L["Navigation shows the best available route to your target location."] =
"Die Navigation zeigt die beste verfügbare Route zu deinem Ziel."
L["Hold Ctrl and click the world map to place a pin. The button below creates a test pin near your character and finishes the introduction."] =
"Halte die Strg-Taste gedrückt und klicke auf die Weltkarte, um eine Markierung zu setzen. Mit der Schaltfläche unten kannst du eine Testmarkierung in der Nähe deines Charakters setzen und die Einführung abschließen."
L["Let's go!"] = "Los geht’s!"
L["Finish"] = "Fertigstellen"
L["Next"] = "Weiter"
L["Place test pin and finish"] = "Testmarkierung setzen und abschließen"
L["Welcome to Map Pin Enhanced!"] = "Willkommen bei „Map Pin Enhanced“!"
L["Select a wayfinder"] = "Wegweiser auswählen"
L["Enable navigation"] = "Navigation aktivieren"
L["Place your first pin"] = "Setze deine erste Markierung"

------------------------------ Tooltip helper ------------------------------
L["Click"] = "Klicken"
L["Alt + Click"] = "Alt + Klick"
L["Left Click"] = "Linksklick"
L["Right Click"] = "Rechtsklick"
L["Middle Click"] = "Mittlerer Mausklick"
L["Ctrl + Left Click"] = "Strg + Linksklick"
L["Shift + Left Click"] = "Umschalt + Linksklick"
L["Alt + Left Click"] = "Alt + Linksklick"
L["Open menu"] = "Menü öffnen"
L["Collapse"] = "Zusammenklappen"
L["Clear without confirmation"] = "Ohne Bestätigung löschen"
L["Delete without confirmation"] = "Ohne Bestätigung löschen"
L["Change pin appearance"] = "Aussehen der Markierung ändern"
L["General.TooltipHelper_LABEL"] = "Tooltip-Hilfsfunktion aktivieren"
L["General.TooltipHelper_DESCRIPTION"] = "Verfügbare Klickaktionen in Tooltips anzeigen."

L["Common options"] = "Häufige Optionen"
L["Choose which helpers you want to enable. You can change these choices later in settings."] =
"Wähle, welche Hilfsfunktionen du aktivieren möchtest. Du kannst diese Auswahl später in den Einstellungen ändern."

--@debug@
L["Profiler"] = "Profiler"
L["Profiler: restore"] = "Profiler: Wiederherstellen"
L["Profiler: recording - restore"] = "Profiler: Aufzeichnung – Wiederherstellung"
L["Modules"] = "Module"
L["Modules: %d"] = "Module: %d"
L["All modules"] = "Alle Module"
L["Start"] = "Start"
L["Stop"] = "Stopp"
L["Reset"] = "Zurücksetzen"
L["Recording. Closing this window stops capture."] =
"Aufnahme. Durch Schließen dieses Fensters wird die Aufnahme beendet."
L["Capture stopped: %.2f seconds. Export to inspect results."] =
"Aufzeichnung beendet: %.2f Sekunden. Exportiere die Daten, um die Ergebnisse zu prüfen."
L["Select modules, then start a new capture."] = "Wähle Module und starte dann eine neue Aufzeichnung."
L["Open the profiler."] = "Öffne den Profiler."
--@end-debug@

L["FlightTimer.Enable_LABEL"] = "Flug-Timer aktivieren"
L["FlightTimer.Enable_DESCRIPTION"] =
"Zeige bei Flügen über Flugmeister einen verschiebbaren Fortschrittsbalken und die geschätzte Restzeit an."
L["FlightTimer.Lock_LABEL"] = "Flug-Timer sperren"
L["FlightTimer.Lock_DESCRIPTION"] = "Verhindere, dass der Flug-Timer verschoben wird."
L["FlightTimer.Scale_LABEL"] = "Größe des Flug-Timers"
L["FlightTimer.Scale_DESCRIPTION"] = "Wähle die Größe des Flug-Timers."
L["FlightTimer.Gradient_LABEL"] = "Flugzeit-Verlauf"
L["FlightTimer.Gradient_DESCRIPTION"] = "Klicken Sie auf die linke oder rechte Hälfte, um den Farbverlauf an diesem Ende des Flugzeiters zu ändern."

L["Flight Timer"] = "Flug-Timer"
L["Flight elapsed: %s"] = "Verstrichene Zeit: %s"
L["Flight remaining: %s"] = "%s verbleibend"

L["Mode: baseline"] = "Modus: Basis"
L["Mode: detailed"] = "Modus: detailliert"

L["Baseline measures whole-addon engine time. Detailed adds function scopes and preparation phases. Both include percentage impact and a timeline. Compare matching gameplay; profiling adds overhead and detailed times overlap."] =
"Der Basismodus misst die gesamte vom Addon verbrauchte Rechenzeit. Der Detailmodus erfasst zusätzlich einzelne Funktionen und Vorbereitungsphasen. Beide zeigen den prozentualen Anteil und eine Zeitleiste. Vergleiche ähnliche Spielsituationen; die Messung verursacht zusätzlichen Aufwand und die Detailzeiten überschneiden sich."

L["Share location"] = "Standort teilen"
L["Place a pin here"] = "Setze hier eine Markierung"
L["Enter the Wizard's Sanctum."] = "Betritt das Magiersanktum."

L["Navigation Phase Past"] = "Sprich mit Zidormi und wähle die frühere Version aus."
L["Navigation Phase Present"] = "Sprich mit Zidormi und kehre in die Gegenwart zurück."
L["Auction House"] = "Auktionshaus"
L["Bank"] = "Bank"
L["City"] = "Stadt"
L["Could not create a pin for this location."] = "Für diesen Standort konnte kein Pin erstellt werden."
L["Delve"] = "Tief eintauchen"
L["Finding the nearest location..."] = "Der nächstgelegene Standort wird gesucht..."
L["Inn"] = "Gasthaus"
L["Loading locations..."] = "Standorte werden geladen..."
L["Location"] = "Standort"
L["Location Lexicon"] = "Location Lexicon"
L["Location Lexicon is disabled."] = "Location Lexicon ist deaktiviert."
L["Location search failed. Try again."] = "Die Standortsuche ist fehlgeschlagen. Bitte versuchen Sie es erneut."
L["Location unavailable"] = "Standort nicht verfügbar"
L["Locations could not be loaded."] = "Die Standorte konnten nicht geladen werden."
L["Nearest %s"] = "Nächstgelegenes %s"
L["No locations found."] = "Es wurden keine Standorte gefunden."
L["No suitable nearby location is available."] = "Es ist kein geeigneter Standort in der Nähe verfügbar."
L["Open the Location Lexicon."] = "Öffnen Sie die Standortsuche „Location Lexicon“."
L["Point of interest"] = "Sehenswürdigkeit"
L["Raid Finder"] = "Raid-Finder"
L["Repair"] = "Reparatur"
L["Searching locations..."] = "Standorte werden gesucht..."
L["Stable Master"] = "Stallmeister"
L["This location is currently unavailable."] = "Dieser Standort ist derzeit nicht verfügbar."
L["This location is not available to this character."] = "Dieser Ort steht diesem Charakter nicht zur Verfügung."
L["Trainer"] = "Trainer"
L["Try a city, dungeon, or location name"] = "Gib den Namen einer Stadt, eines Dungeons oder eines Ortes ein"
L["Unknown zone"] = "Unbekanntes Gebiet"
L["Vault"] = "Tresor"
L["Vendor"] = "Anbieter"
L["Lexicon.Enable_LABEL"] = "Location Lexicon aktivieren"
L["Lexicon.Enable_DESCRIPTION"] = "Orte suchen und verfolgen oder einfache Markierungen setzen."
L["Lexicon.DataTypes_LABEL"] = "Aktivierte Datentypen"
L["Lexicon.DataTypes_DESCRIPTION"] = "Wählen Sie aus, welche Standorte und Dienstleistungsarten in den Suchergebnissen angezeigt werden sollen. Standorte mit mehreren Rollen bleiben suchbar, solange mindestens eine Rolle aktiviert ist."
L["Click to pick up the macro"] = "Klicken Sie hier, um das Makro abzurufen"
L["Lexicon.Macro_LABEL"] = "Makro „Location Lexicon“"
L["Lexicon.Macro_DESCRIPTION"] = "Klicke darauf, um das Makro auszuwählen und es in einer Aktionsleiste abzulegen."
L["Macros cannot be picked up during combat."] = "Makros können während des Kampfes nicht aufgenommen werden."
L["No account macro slots available."] = "Es sind keine Makro-Slots für dieses Konto verfügbar."
L["%s Trainer"] = "%s Trainer"
L["Alchemy"] = "Alchemie"
L["Ammunition Vendor"] = "Munitionhändler"
L["Armor Vendor"] = "Rüstungshändler"
L["Bag Vendor"] = "Taschenverkäufer"
L["Blacksmithing"] = "Schmiedekunst"
L["Class Trainer"] = "Klassenlehrer"
L["Cooking"] = "Kochen"
L["Enchanting"] = "Bezaubernd"
L["Engineering"] = "Ingenieurwesen"
L["First Aid"] = "Erste Hilfe"
L["Fishing"] = "Angeln"
L["Fishing Vendor"] = "Angelfachgeschäft"
L["Food Vendor"] = "Lebensmittelverkäufer"
L["General Goods Vendor"] = "Anbieter von allgemeinen Waren"
L["Herbalism"] = "Kräuterkunde"
L["Leatherworking"] = "Lederverarbeitung"
L["Mailbox"] = "Postfach"
L["Mining"] = "Bergbau"
L["Pet Training"] = "Tiererziehung"
L["Poison Vendor"] = "Giftverkäufer"
L["Portals"] = "Portale"
L["Profession Supplies Vendor"] = "Anbieter von Berufsbedarf"
L["Profession Trainer"] = "Beruf: Trainer"
L["Reagent Vendor"] = "Reagenzienlieferant"
L["Riding"] = "Reiten"
L["Skinning"] = "Häuten"
L["Tailoring"] = "Maßschneiderei"
L["Town"] = "Stadt"
L["Trade Goods Vendor"] = "Händler für Handelswaren"
L["Weapon Skills"] = "Waffenfertigkeiten"
L["Weapon Vendor"] = "Waffenhändler"
L["%d results"] = "%d Ergebnisse"
