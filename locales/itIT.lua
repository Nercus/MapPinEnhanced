---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

if MapPinEnhanced.locale ~= "itIT" then return end

---@class Locale
local L = MapPinEnhanced.L

------------------------------ Shared UI ------------------------------
L["Cancel"] = "Annulla"
L["Close"] = "Chiudi"
L["A new version (%s) for Map Pin Enhanced is available. You are on (%s)."] =
"È disponibile una nuova versione (%s) di Map Pin Enhanced. Stai utilizzando la versione (%s)."
L["Addon conflicts"] = "Conflitti tra componenti aggiuntivi"
L["The following addons interfere with Map Pin Enhanced and should not be used together:\n\n%s\n\nDisable them in the AddOns menu and reload your UI."] =
"I seguenti addon interferiscono con Map Pin Enhanced e non devono essere usati insieme:\n\n%s\n\nDisattivali nel menu AddOn e ricarica l'interfaccia."
L["Confirm"] = "Conferma"
L["Icon Picker"] = "Selezione icone"
L["Select an icon"] = "Seleziona un'icona"
L["%d icons"] = "%d icone"
L["%d icons (loading...)"] = "%d icone (caricamento in corso...)"
L["Import"] = "Importa"
L["Save"] = "Salva"
L["Stop tracking"] = "Interrompi il tracciamento"
L["This is the location you are navigating to."] = "Questa è la destinazione verso cui ti stai dirigendo."
L["Track"] = "Traccia"
L["Remove"] = "Rimuovi"

L["Click to edit"] = "Clicca per modificare"
L["<x> <y> [title]"] = "<x> <y> [titolo]"
L["Create and track a pin at percentage coordinates. Example: /mpe 50 50 My pin"] =
"Crea e monitora un segnaposto alle coordinate percentuali. Esempio: /mpe 50 50 Il mio segnaposto"
L["You can also use /way instead of /mpe."] = "È anche possibile utilizzare /way al posto di /mpe."

L["Navigation Hearthstone Data Missing"] =
"Posizione della Pietra del Ritorno sconosciuta. Usa la tua Pietra del Ritorno una volta per registrarla."
L["Navigation Flight Data Missing"] =
"Rotte di volo non ancora registrate. Parla con un maestro di volo per registrarle."

------------------------------ Pins ------------------------------
L["Map Pin"] = "Segnaposto sulla mappa"
L["Add Pin"] = "Aggiungi segnaposto"
L["Target"] = "Obiettivo"
L["Change Color"] = "Cambia colore"
L["Change Icon"] = "Cambia icona"
L["Atlas"] = "Atlas"
L["Color"] = "Colore"
L["Icon"] = "Icona"
L["Locked"] = "Bloccato"
L["Map"] = "Mappa"
L["Name"] = "Nome"
L["X"] = "X"
L["Y"] = "Y"
L["Show on Map"] = "Mostra sulla mappa"
L["Clear Pin"] = "Rimuovi segnaposto"
L["Delete Permanently"] = "Elimina definitivamente"
L["Delete pin \"%s\"?"] = "Elimina il segnaposto \"%s\"?"
L["Share to Chat"] = "Condividi nella chat"
L["Failed to place pin on the map. Please check if the coordinates are correct!"] =
"Impossibile posizionare il segnaposto sulla mappa. Verifica che le coordinate siano corrette!"
L["Can't Show on Map in Combat"] = "Impossibile visualizzare sulla mappa durante il combattimento"
L["The world map cannot be opened automatically during combat. It will open after combat ends."] =
"La mappa del mondo non può essere aperta automaticamente durante il combattimento. Si aprirà al termine del combattimento."

------------------------------ Groups And Tracker ------------------------------
L["Group"] = "Gruppo"
L["Hidden"] = "Nascosto"
L["Show hidden group"] = "Mostra gruppo nascosto"
L["No hidden groups"] = "Nessun gruppo nascosto"
L["Your pins (%d)"] = "I tuoi segnaposto (%d)"
L["New Group %d"] = "Nuovo gruppo %d"
L["Groups"] = "Gruppi"
L["Create Group"] = "Crea gruppo"
L["Select"] = "Seleziona"
L["Select a group to start editing."] = "Seleziona un gruppo per iniziare a modificarlo."
L["Show"] = "Mostra"
L["Hide"] = "Nascondi"
L["Ungrouped Pins"] = "Segnaposto non raggruppati"
L["My Way Back"] = "Il mio ritorno"
L["Import %d"] = "Importa %d"
L["%d |4pin:pins;"] = "%d |4segnaposto:segnaposto;"
L["A group named \"%s\" already exists."] = "Esiste già un gruppo denominato \"%s\"."
L["Rename Group"] = "Rinomina gruppo"
L["Add to New Group"] = "Aggiungi a un nuovo gruppo"
L["Delete Group"] = "Elimina gruppo"
L["Clear Group"] = "Svuota gruppo"
L["Show Group"] = "Mostra gruppo"
L["Hide Group"] = "Nascondi gruppo"
L["Restore Pins"] = "Ripristina segnaposto"
L["Make pins restorable"] = "Rendere i segnaposto ripristinabili"
L["Delete group \"%s\" and all of its pins?"] = "Elimina il gruppo \"%s\" e tutti i suoi segnaposto?"
L["Clear all pins from \"%s\"?"] = "Eliminare tutti i segnaposto da \"%s\"?"
L["Tracking Mode"] = "Modalità di tracciamento"
L["Track by Distance"] = "Traccia per distanza"
L["Track by Order"] = "Traccia in ordine"
L["Toggle the tracker visibility."] = "Attiva/disattiva la visibilità del tracker."
L["Dungeon"] = "Spedizione"
L["Raid"] = "Incursione"
L["Scenario"] = "Scenario"
L["Battleground"] = "Campo di battaglia"
L["Arena"] = "Arena"
L["None"] = "Nessuno"
L["No active pins"] = "Nessun segnaposto attivo"
L["No coordinates available"] = "Nessuna coordinata disponibile"
L["Coordinates.Visibility_LABEL"] = "Nascondi automaticamente"
L["Coordinates.Visibility_DESCRIPTION"] =
"Nascondi la visualizzazione delle coordinate quando è attiva una qualsiasi delle condizioni selezionate."
L["Tracker.Visibility_LABEL"] = "Nascondi automaticamente"
L["Tracker.Visibility_DESCRIPTION"] =
"Nascondi il tracker quando una qualsiasi delle condizioni selezionate è attiva."
L["Toggle the group editor."] = "Attiva/disattiva l'editor di gruppo."

------------------------------ Editor ------------------------------
L["Editor"] = "Editor"
L["Edit Group"] = "Modifica gruppo"
L["Search"] = "Cerca"
L["Rename Pin"] = "Rinomina il segnaposto"
L["Create a new pin group."] = "Crea un nuovo gruppo di segnaposto."
L["Choose an icon for this group."] = "Scegli un'icona per questo gruppo."
L["Delete this group and all of its pins. System groups are cleared instead."] =
"Elimina questo gruppo e tutti i suoi segnaposto. I gruppi di sistema vengono invece svuotati."
L["Hide or show this group."] = "Nascondi o mostra questo gruppo."
L["Permanently delete this pin."] = "Elimina definitivamente questo segnaposto."
L["Create a copy of this pin."] = "Crea una copia di questo segnaposto."
L["copy of %s"] = "copia di %s"
L["Loading"] = "Caricamento in corso"

------------------------------ Dialogs ------------------------------
L["Version: %s (%s)"] = "Versione: %s (%s)"
L["Build: %s"] = "Build: %s"
L["Special thanks to Byyrax and Pamoo for the help with translations"] =
"Un ringraziamento speciale a Byyrax e Pamoo per l'aiuto con le traduzioni"
L["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs!"] =
"Grazie a Eminos per le innumerevoli ore dedicate alla creazione di texture, al “rubber-ducking” e alla riflessione sulle idee insieme a me. Grazie a tutti coloro che mi hanno aiutato a testare le nuove versioni, mi hanno fornito feedback e segnalato i bug!"
L["Open the about dialog to view version information."] =
"Apri la finestra di dialogo \"Informazioni su\" per visualizzare le informazioni sulla versione."

------------------------------ Transfer ------------------------------
L["Export"] = "Esporta"
L["Way commands"] = "Comandi Way"
L["Serialized data"] = "Dati serializzati"
L["Open the import dialog to import map pins from a string."] =
"Apri la finestra di dialogo di importazione per importare i segnaposto della mappa da una stringa."
L["You can import pins by pasting multiple slash commands or a Map Pin Enhanced export string (starting with %s)"] =
"È possibile importare i segnaposto incollando più comandi con barra o una stringa di esportazione Map Pin Enhanced (che inizia con %s)"
L["Click to paste export string or slash commands here"] =
"Clicca qui per incollare la stringa di esportazione o i comandi con la barra"
L["Choose an export format, then copy the text below."] =
"Scegli un formato di esportazione, quindi copia il testo riportato di seguito."
L["Command prefix:"] = "Prefisso di comando:"
L["Exporting %d pins across %d maps"] = "Esportazione di %d |4segnaposto:segnaposto; su %d |4mappa:mappe;"
L["%s: %d pins across %d maps"] = "%s: %d |4segnaposto:segnaposto; su %d |4mappa:mappe;"
L["%d invalid entries will be skipped"] = "%d |4voce non valida verrà saltata:voci non valide verranno saltate;"
L["Invalid or corrupted serialized data."] = "Dati serializzati non validi o danneggiati."
L["No valid pins were found to import."] = "Nessun segnaposto valido da importare."
L["Importing %d pins; skipped %d invalid entries."] =
"Importazione di %d |4segnaposto:segnaposto;; %d |4voce non valida saltata:voci non valide saltate;."
L["Import failed."] = "L'importazione non è andata a buon fine."
L["Warning: slash commands do not preserve descriptions, custom icons or colors. /mappin also omits pin titles."] =
"Attenzione: i comandi slash non mantengono le descrizioni, le icone personalizzate né i colori. Inoltre, il comando /mappin omette i titoli dei segnaposto."

------------------------------ Providers ------------------------------
L["%s added hidden group \"%s\"."] = "%s ha aggiunto il gruppo nascosto \"%s\"."
L["TomTom Pins"] = "Segnaposto TomTom"
L["TomTom Waypoint"] = "Punto di riferimento TomTom"
L["TomTom Is Loaded! You may experience some unexpected behavior."] =
"TomTom è caricato! Potrebbero verificarsi alcuni comportamenti imprevisti."
L["\"%s\" reached at %s."] = "\"%s\" raggiunto alle coordinate %s."
L["Location reached at %s."] = "Destinazione raggiunta alle coordinate %s."
L["Equipped %s."] = "Equipaggiato con %s."
L["Re-equipped %s."] = "%s equipaggiato di nuovo."
L["Restored empty equipment slot."] = "È stato ripristinato lo slot per l'equipaggiamento vuoto."
L["Could not restore %s."] = "Impossibile ripristinare %s."
L["Could not restore empty equipment slot."] = "Impossibile ripristinare uno slot attrezzatura vuoto."
L["It is locked."] = "Il segnaposto è bloccato."
L["Turn in: %s"] = "Consegna: %s"
L["Corpse"] = "Cadavere"
L["Quest"] = "Missione"
L["Content"] = "Contenuto"
L["Vignette"] = "Punto d'interesse"
L["House"] = "Casa"
L["%s's House"] = "La casa di %s"

------------------------------ Miscellaneous ------------------------------
L["Back"] = "Indietro"
L["Create a Pin at Your Current Location"] = "Crea un segnaposto nella tua posizione attuale"
L["Unable to determine your current map location."] = "Impossibile determinare la tua posizione attuale sulla mappa."
L["Unable to determine your current position on the map."] =
"Impossibile determinare la tua posizione attuale sulla mappa."
L["%s's Position"] = "Posizione di %s"
L["You Are in an Instance or a Zone Where the Map Is Not Available"] =
"Ti trovi in un'istanza o in una zona in cui la mappa non è disponibile"
L["My Way Back is unavailable on the map you are on right now."] =
"«Il mio ritorno» non è disponibile sulla mappa attuale."

------------------------------ Options ------------------------------
L["General"] = "Generale"
L["Pins"] = "Segnaposto"
L["Miscellaneous"] = "Varie"
L["Wayfinder"] = "Indicatore di direzione"
L["Search for option..."] = "Cerca un'opzione..."
L["Open the options frame"] = "Apri la finestra delle opzioni"
L["Open options"] = "Apri opzioni"
L["Open editor"] = "Apri l'editor"

L["Clear all pins"] = "Rimuovi tutti i segnaposto"
L["Some pins are still being updated. Try clearing again when the current operation finishes."] =
"Alcuni segnaposto sono ancora in fase di aggiornamento. Prova a eseguire nuovamente la cancellazione al termine dell'operazione in corso."
L["Hide minimap button"] = "Nascondi il pulsante della minimappa"
L["Toggle the minimap button visibility."] = "Attiva o disattiva la visualizzazione del pulsante della minimappa."
L["General.ShowMinimapButton_LABEL"] = "Mostra il pulsante della minimappa"
L["General.ShowMinimapButton_DESCRIPTION"] = "Mostra il pulsante dell'add-on sulla minimappa."
L["General.CustomMinimapButton_LABEL"] = "Pulsante personalizzato per la minimappa"
L["General.CustomMinimapButton_DESCRIPTION"] =
"Utilizza un logo più grande, senza il bordo e lo sfondo standard del pulsante della minimappa."
L["Wayfinder.ShowDistanceUnit_LABEL"] = "Mostra l'unità di misura della distanza"
L["Wayfinder.ShowDistanceUnit_DESCRIPTION"] = "Visualizza l'unità di misura accanto ai valori di distanza."
L["Reload UI"] = "Ricarica interfaccia"
L["This change requires a UI reload. Reload now?"] =
"Questa modifica richiede di ricaricare l'interfaccia. Ricaricare ora?"

L["Pins.ScaleOnHover_LABEL"] = "Ingrandisci i segnaposto al passaggio del mouse"
L["Pins.ScaleOnHover_DESCRIPTION"] =
"Ingrandisci i segnaposto sulla mappa del mondo quando ci passi sopra con il mouse."

L["Coordinates.Enable_LABEL"] = "Abilita la visualizzazione delle coordinate"
L["Coordinates.Enable_DESCRIPTION"] =
"Attiva/disattiva la visualizzazione sullo schermo delle tue coordinate attuali"
L["Coordinates.Lock_LABEL"] = "Blocca la visualizzazione delle coordinate"
L["Coordinates.Lock_DESCRIPTION"] =
"Attiva o disattiva la possibilità di spostare la visualizzazione delle coordinate."

L["Wayfinder.HideBlizzardFloatingDiamond_LABEL"] = "Nascondi il rombo fluttuante di Blizzard"
L["Wayfinder.HideBlizzardFloatingDiamond_DESCRIPTION"] =
"Nascondi il rombo di navigazione fluttuante di Blizzard quando è disattivato il sistema di orientamento fluttuante \"Map Pin Enhanced\"."
L["Wayfinder.Selection_LABEL"] = "Indicatore di direzione"
L["Wayfinder.Selection_DESCRIPTION"] =
"Scegliere il singolo indicatore di rotta da utilizzare per la navigazione."
L["Arrow"] = "Freccia"
L["Floating"] = "Fluttuante"
L["Navigation"] = "Navigazione"
L["Navigation.Enable_LABEL"] = "Abilita la navigazione lungo il percorso"
L["Navigation.Enable_DESCRIPTION"] =
"Calcola i percorsi di viaggio utilizzando gli spostamenti, i portali, i mezzi di trasporto, gli incantesimi, gli oggetti e i giocattoli a tua disposizione."
L["Navigation.AutomaticTravelSelection_LABEL"] = "Selezione automatica del percorso"
L["Navigation.AutomaticTravelSelection_DESCRIPTION"] =
"Seleziona automaticamente le opzioni di dialogo degli NPC e le destinazioni di volo richieste dal percorso attuale. Tieni premuto il tasto Maiusc quando apri la mappa di volo per selezionare manualmente un volo."
L["Navigation.WorldMap_LABEL"] = "Mostra il percorso sulla mappa del mondo"
L["Navigation.WorldMap_DESCRIPTION"] = "Mostra il percorso calcolato sulla mappa del mondo."
L["Navigation.Minimap_LABEL"] = "Mostra il percorso sulla minimappa"
L["Navigation.Minimap_DESCRIPTION"] = "Mostra il percorso calcolato sulla minimappa."
L["Navigation Calculating"] = "Calcolo del percorso..."
L["Navigation Direct Guidance"] = "Non è disponibile alcun percorso. Dirigiti direttamente a destinazione."
L["Navigation No Direction"] = "Non sono disponibili indicazioni per questa destinazione."
L["Navigation Step Waiting Combat"] =
"Questo passaggio potrebbe non essere aggiornato. Verrà aggiornato al termine del combattimento."
L["Navigation Action Shift Combat"] =
"Premi Shift + clic sinistro per eseguire l'azione visualizzata durante il combattimento."
L["Navigation Action Unavailable Combat"] = "Questa azione sarà disponibile al termine del combattimento."
L["Navigation Action Started"] = "In attesa della conferma di arrivo."
L["Navigation Action Failed"] = "L'operazione non è stata completata. Riprova o ricalcola il percorso."
L["Navigation Finding Another Route"] = "Ricerca di un altro percorso..."
L["Navigation Arrival Confirming"] = "Conferma di arrivo..."
L["Navigation Walk"] = "Vai al punto successivo."
L["Navigation Fly"] = "Vola al punto successivo."
L["Navigation Travel To Destination"] = "Raggiungi %s."
L["Navigation Fly To Destination"] = "Vola a %s."
L["Navigation Route To"] = "Percorso verso: %s (%s)"
L["Navigation Chat Header"] = "Percorso verso: %s (%s) - %s"
L["Navigation Chat Unavailable"] =
"Seleziona un canale di chat disponibile o un destinatario per un sussurro prima di esportare il percorso."
L["Send"] = "Invia"
L["Navigation Chat Choose Channel"] = "Scegli dove inviare questo percorso:"
L["Navigation Chat Whisper To"] = "Sussurra a"
L["Navigation Chat Player Name"] = "Nome del giocatore o Nome-Reame"
L["Navigation Chat Route Changed"] = "Il percorso è cambiato. Chiudi questa finestra ed esportalo di nuovo."
L["Party"] = "Gruppo"
L["Say"] = "Dici"
L["Whisper"] = "Sussurro"
L["Navigation Step Number"] = "Passaggio %d: %s"
L["Navigation Cross Border"] = "Passa all’area successiva."
L["Navigation Change Floor"] = "Passa al piano indicato."
L["Navigation Talk To NPC"] = "Parla con il personaggio non giocante indicato."
L["Navigation Method Travel"] = "Viaggi"
L["Navigation Method Walking"] = "A piedi"
L["Navigation Method Flying"] = "Volo"
L["Navigation Method Portal"] = "Portale"
L["Navigation Method NPC Travel"] = "Viaggio tramite PNG"
L["Navigation Method Border"] = "Attraversamento della frontiera"
L["Navigation Method Floor Change"] = "Cambio di piano"
L["Navigation Method Spell"] = "Incantesimo"
L["Navigation Method Item"] = "Oggetto"
L["Navigation Method Toy"] = "Giocattolo"
L["Navigation Method Boat"] = "Barca"
L["Navigation Method Hearthstone"] = "Pietra del Ritorno"
L["Navigation Method Flight Taxi"] = "Maestro di volo"
L["Navigation Method Phase Change"] = "Cambiamento di fase"
L["Navigation Method Ship"] = "Nave"
L["Navigation Method Tram"] = "Tram"
L["Navigation Method Transport"] = "Trasporto"
L["Navigation Method Teleport"] = "Teletrasporto"
L["Navigation Method Zeppelin"] = "Zeppelin"
L["Navigation Use Spell"] = "Usa l'incantesimo richiesto."
L["Navigation Use Item"] = "Utilizza l'oggetto richiesto."
L["Navigation Use Toy"] = "Utilizza il giocattolo richiesto."
L["Navigation Use Hearthstone"] = "Usa la tua Pietra del Ritorno."
L["Navigation Use Teleport"] = "Utilizza il teletrasporto indicato."
L["Navigation Take Portal"] = "Entra nel portale."
L["Navigation Take Portal To"] = "Prendi il portale per %s."
L["Navigation Take Portal From To"] = "Prendi il portale da %s a %s."
L["Navigation Cross Border To"] = "Entra in %s."
L["Navigation Change Floor To"] = "Cambia piano per raggiungere %s."
L["Navigation Talk To NPC To"] = "Parla con il personaggio non giocante indicato per raggiungere %s."
L["Navigation Cast Named Spell"] = "Lancia %s."
L["Navigation Cast Named Spell To"] = "Lancia %s per teletrasportarti a %s."
L["Navigation Cast Named Spell Return"] = "Lancia %s per tornare a %s."
L["Navigation Use Toy And Select"] = "Usa %s, poi interagisci e seleziona %s."
L["Navigation Select Toy Destination"] = "Interagisci con il giocattolo e seleziona %s."
L["Navigation Use Named Item"] = "Utilizza %s."
L["Navigation Use Named Item To"] = "Usa %s per recarti a %s."
L["Navigation Use Named Item Return"] = "Usa %s per tornare a %s."
L["Navigation Use Spell To"] = "Usa l'incantesimo richiesto per teletrasportarti a %s."
L["Navigation Use Teleport To"] = "Usa il teletrasporto indicato per raggiungere %s."
L["Navigation Use Item To"] = "Usa l'oggetto richiesto per recarti a %s."
L["Navigation Use Toy To"] = "Usa il giocattolo richiesto per recarti a %s."
L["Navigation Use Hearthstone To"] = "Usa la tua Pietra del Ritorno per tornare a %s."
L["Navigation Take Boat"] = "Prendi la barca."
L["Navigation Take Boat To"] = "Prendi la barca per %s."
L["Navigation Traveling By Boat"] = "Viaggiare in barca."
L["Navigation Traveling By Boat To"] = "In viaggio in barca verso %s."
L["Navigation Take Ship"] = "Prendi la nave."
L["Navigation Take Ship To"] = "Prendi la nave per %s."
L["Navigation Traveling By Ship"] = "Viaggiare in nave."
L["Navigation Traveling By Ship To"] = "In viaggio in nave verso %s."
L["Navigation Take Zeppelin"] = "Prendi lo zeppelin."
L["Navigation Take Zeppelin To"] = "Prendi lo zeppelin per %s."
L["Navigation Traveling By Zeppelin"] = "Viaggiare in dirigibile."
L["Navigation Traveling By Zeppelin To"] = "In viaggio in dirigibile verso %s."
L["Navigation Take Tram"] = "Prendi il tram."
L["Navigation Take Tram To"] = "Prendi il tram per %s."
L["Navigation Traveling By Tram"] = "Viaggiare in tram."
L["Navigation Traveling By Tram To"] = "In viaggio in tram verso %s."
L["Navigation Take Transport"] = "Usa il mezzo di trasporto."
L["Navigation Take Transport To"] = "Usa il mezzo di trasporto per %s."
L["Navigation Traveling By Transport"] = "Viaggio in corso."
L["Navigation Traveling By Transport To"] = "In viaggio verso %s con il mezzo di trasporto."
L["Navigation Take Flight To"] = "Prendi il volo per %s."
L["Navigation Take Flight"] = "Prendi il volo."
L["Navigation Traveling By Flight"] = "Volo in corso."
L["Navigation Traveling By Flight To"] = "Volo verso %s."
L["Recalculate Route"] = "Ricalcola il percorso"
L["%s - %s"] = "%s - %s"
L["System Groups"] = "Gruppi di sistema"
L["System groups are managed by Map Pin Enhanced for special features. Their core settings cannot be changed."] =
"I gruppi di sistema sono gestiti da Map Pin Enhanced per funzionalità speciali. Le loro impostazioni principali non possono essere modificate."


L["Report"] = "Relazione"
L["Report a navigation problem"] = "Segnala un problema di navigazione"
L["Help improve navigation"] = "Aiutaci a migliorare la navigazione"
L["Describe the problem, then copy the report below and post it on either issue page. Copy a URL into your browser to get started."] =
"Descrivi il problema, quindi copia il testo riportato di seguito e pubblicalo su una delle due pagine dedicate ai problemi. Inserisci l'URL nel browser per iniziare."
L["What went wrong?"] = "Cosa è andato storto?"
L["What happened, what did you expect, and how can we reproduce it?"] =
"Cosa è successo, cosa ti aspettavi e come possiamo riprodurre il fenomeno?"
L["Your report (description and debug data)"] = "Il tuo rapporto (descrizione e dati di debug)"
L["Click the report or a URL to select it, then press Ctrl+C to copy."] =
"Fai clic sul report o su un URL per selezionarlo, quindi premi Ctrl+C per copiarlo."
L["Navigation Debug Dump"] = "Dump di debug della navigazione"


L["Description"] = "Descrizione"
L["Edit Description"] = "Modifica descrizione"
L["Add notes for this pin. Descriptions appear in pin tooltips and below the wayfinder title."] =
"Aggiungi delle note a questo segnaposto. Le descrizioni vengono visualizzate nei suggerimenti dei segnaposto e sotto il titolo dell'indicatore di direzione."
L["This pin is no longer in this group."] = "Questo segnaposto non fa più parte di questo gruppo."
L["Apply"] = "Applica"

L["Wayfinder.ScaleWithDistance_LABEL"] = "Scala in funzione della distanza"
L["Wayfinder.ScaleWithDistance_DESCRIPTION"] =
"Il segnaposto fluttuante e il raggio crescono dal 75% al 100% mentre ti avvicini. Gli intervalli di distanza dipendono dall'abilità di cavalcatura o volo appresa al caricamento dell'addon e restano fissi fino al ricaricamento."
L["Wayfinder.ShowBeam_LABEL"] = "Mostra il raggio"
L["Wayfinder.ShowBeam_DESCRIPTION"] =
"Mostra un raggio sopra il segnaposto fluttuante quando è visibile sullo schermo."
L["Wayfinder.ShowTextOutline_LABEL"] = "Mostra contorno del testo"
L["Wayfinder.ShowTextOutline_DESCRIPTION"] =
"Aggiungi un contorno al testo di distanza, tempo di arrivo stimato e titolo del segnaposto fluttuante, mostrato all'apparizione o al passaggio del mouse."
L["Wayfinder.ShowETA_LABEL"] = "Mostra l'orario di arrivo previsto"
L["Wayfinder.ShowObjectiveFrame_LABEL"] = "Mostra la finestra degli obiettivi della missione"
L["Wayfinder.ShowObjectiveFrame_DESCRIPTION"] =
"Mostra gli obiettivi della missione quando entri nell'area obiettivo. Se disattivato, l'indicatore fluttuante viene nascosto e la freccia mantiene la visualizzazione per le brevi distanze."
L["Wayfinder.ShowETA_DESCRIPTION"] =
"Mostra la stima del tempo di percorrenza fino alla destinazione corrente insieme alla distanza, se disponibile."
L["Navigation.TransportationGroups_LABEL"] = "Trasporti"
L["Navigation.TransportationGroups_DESCRIPTION"] =
"Scegli quale mezzo di trasporto ti suggerisce il sistema di navigazione. I mezzi di trasporto di linea includono barche, dirigibili e tram. I teletrasporti personali includono incantesimi di viaggio, oggetti, giocattoli e la Pietra del Ritorno di Dalaran."
L["Navigation Transportation Portals"] = "Portali"
L["Navigation Transportation Flight paths"] = "Rotte di volo"
L["Navigation Transportation Scheduled transport"] = "Trasporto di linea"
L["Navigation Transportation NPC travel"] = "Viaggio tramite PNG"
L["Navigation Transportation Phase changes"] = "Cambiamenti di fase"
L["Navigation Transportation Personal teleports"] = "Teletrasporti personali"
L["Navigation Transportation Dungeon teleports"] = "Teletrasporti nei dungeon"

L["Settings for Floating; Arrow is still selected."] = "Impostazioni di Fluttuante; Freccia è ancora selezionata."
L["Settings for Arrow; Floating is still selected."] = "Impostazioni di Freccia; Fluttuante è ancora selezionato."

L["Clear Tracking"] = "Interrompi il tracciamento"
L["In objective area"] = "Nell'area di obiettivo"
L["Why do I see this navigation element?"] = "Perché vedo questo elemento di navigazione?"
L["Wayfinder.Fallback_DESCRIPTION"] =
"L'interfaccia utente di Blizzard non è in grado di fornire una posizione nel mondo utilizzabile per questo bersaglio in quest'area. Questa freccia viene utilizzata solo temporaneamente e verrà rimossa non appena saranno disponibili informazioni di gioco utilizzabili."

L["Group sharing timed out. The sender must be online and the link must still be available."] =
"La condivisione di gruppo ha superato il limite di tempo. Il mittente deve essere online e il link deve essere ancora disponibile."
L["Requesting shared group..."] = "Richiesta di gruppo condiviso..."
L["Receiving shared group..."] = "Ricezione del gruppo condiviso..."
L["Shared group \"%s\" received."] = "Ricevuto il gruppo condiviso \"%s\"."
L["This shared group is no longer available. Ask the sender for a new link."] =
"Questo gruppo condiviso non è più disponibile. Chiedi al mittente un nuovo link."

L["Pin operation stopped after %d of %d pins. Completed changes were kept."] =
"L'operazione sui segnaposto si è interrotta dopo %d su %d segnaposto. Le modifiche completate sono state salvate."

-- Category options (0041).
L["Coordinates.ShowZone_LABEL"] = "Mostra zona"
L["Coordinates.ShowZone_DESCRIPTION"] = "Indica il nome completo della mappa tra le coordinate X e Y."
L["Coordinates.ShowDecimals_LABEL"] = "Mostra cifre decimali"
L["Coordinates.ShowDecimals_DESCRIPTION"] =
"Visualizza due cifre decimali. Disattivare questa opzione per visualizzare le coordinate intere troncate."
L["Pins.AlwaysPingTracked_LABEL"] = "Fai pulsare sempre il segnaposto tracciato"
L["Pins.AlwaysPingTracked_DESCRIPTION"] =
"Fai lampeggiare il segnaposto sulla mappa del mondo ogni due secondi finché è visibile."
L["Pins.MinimapScale_LABEL"] = "Dimensione dei segnaposto sulla minimappa"
L["Pins.MinimapScale_DESCRIPTION"] = "Scegli la dimensione dei normali segnaposto della minimappa."
L["Pins.WorldMapScale_LABEL"] = "Dimensioni dei segnaposto sulla mappa del mondo"
L["Pins.WorldMapScale_DESCRIPTION"] =
"Scegli le dimensioni dei normali segnaposto sulla mappa del mondo. L'ingrandimento al passaggio del mouse si applica in aggiunta."
L["Pins.DefaultColor_LABEL"] = "Colore predefinito del segnaposto"
L["Pins.DefaultColor_DESCRIPTION"] =
"Colore per i nuovi segnaposto privi di un'icona o di un colore specifico. I segnaposto esistenti e quelli importati mantengono il loro aspetto."
L["Pins.FadeUntracked_LABEL"] = "Attenua i segnaposto non tracciati"
L["Pins.FadeUntracked_DESCRIPTION"] =
"Riduci l'opacità dei segnaposto non tracciati al 40%. Passandoci sopra con il mouse, l'opacità torna al massimo."
L["Pins.ShowMinimapPins_LABEL"] = "Mostra i segnaposto sulla minimappa"
L["Pins.ShowMinimapPins_DESCRIPTION"] =
"Mostra i normali segnaposto degli add-on sulla minimappa. I segnaposto della minimappa richiedono aggiornamenti di posizione; le indicazioni e i marcatori di percorso rimangono indipendenti."
L["Pins.EnableLockedPins_LABEL"] = "Abilita i segnaposto bloccati"
L["Pins.EnableLockedPins_DESCRIPTION"] =
"Consenti l'aggiunta di nuovi blocchi. I segnaposto bloccati rimangono tali finché non li rimuovi; i segnaposto esistenti possono sempre essere sbloccati."
L["Pins.ArrivalNotification_LABEL"] = "Notifica al raggiungimento del segnaposto"
L["Pins.ArrivalNotification_DESCRIPTION"] =
"Avvisare una volta per ogni sessione di tracciamento quando si raggiunge fisicamente la destinazione finale dell'add-on."
L["Pins.AutoUntrack_LABEL"] = "Interrompi automaticamente il tracciamento"
L["Pins.AutoUntrack_DESCRIPTION"] =
"Interrompi il tracciamento dell'addon e di Blizzard quando entri in una spedizione, un'incursione, uno scenario, un campo di battaglia o un'arena."
L["Tracker.AutoShow_LABEL"] = "Mostra automaticamente con un nuovo segnaposto"
L["Tracker.AutoShow_DESCRIPTION"] =
"Mostra ed espandi il tracker dopo la creazione di un segnaposto o la conferma di un'importazione. Tracciare un elemento di Blizzard non attiva questa funzione. Le regole di occultamento automatico restano valide."
L["Tracker.CloseAction_LABEL"] = "Riduci a icona il tracker invece di chiuderlo"
L["Tracker.CloseAction_DESCRIPTION"] =
"Quando si riduce a icona il tracker, mantenere visibile solo l'intestazione."
L["Tracker.ShowCoordinates_LABEL"] = "Mostra le coordinate"
L["Tracker.ShowCoordinates_DESCRIPTION"] =
"Mostra le coordinate accanto al nome della zona nelle voci relative ai segnaposto del tracker."
L["Tracker.MaximumRows_LABEL"] = "Numero massimo di righe visibili"
L["Tracker.MaximumRows_DESCRIPTION"] =
"Numero massimo di righe di gruppi e segnaposto prima dello scorrimento, esclusa l'intestazione."
L["Tracker.BackgroundOpacity_LABEL"] = "Opacità dello sfondo del tracker"
L["Tracker.BackgroundOpacity_DESCRIPTION"] =
"Opacità dello sfondo della lista dei segnaposto, da 0% a 100%."
L["Tracker.Scale_LABEL"] = "Dimensioni del tracker"
L["Tracker.Scale_DESCRIPTION"] = "Scegli le dimensioni del tracker."
L["Coordinates"] = "Coordinate"
L["Tracker"] = "Tracker"
L["Small (90%)"] = "Piccolo (90%)"
L["Default (100%)"] = "Predefinito (100%)"
L["Large (125%)"] = "Grande (125%)"
L["Huge (150%)"] = "Enorme (150%)"
L["Red"] = "Rosso"
L["Orange"] = "Arancione"
L["Pale"] = "Pallido"
L["Yellow"] = "Giallo"
L["Green"] = "Verde"
L["LightBlue"] = "Azzurro"
L["DarkBlue"] = "Blu scuro"
L["Purple"] = "Viola"
L["Pink"] = "Rosa"
L["Only locked pins"] = "Solo segnaposto bloccati"
L["All pins"] = "Tutti i segnaposto"
L["Disabled"] = "Disattivato"
L["Minimize"] = "Riduci a icona"
L["Expand"] = "Espandi"
L["Lock Pin"] = "Blocca segnaposto"
L["Unlock Pin"] = "Sblocca segnaposto"

------------------------------ Legacy migration ------------------------------
L["Legacy migration could not update groups. Original saved data was kept."] =
"La migrazione dei dati storici non è riuscita ad aggiornare i gruppi. I dati originari salvati sono stati mantenuti."
L["Migrated %d legacy pins and %d saved sets. Original saved data was kept."] =
"Sono stati migrati %d segnaposto legacy e %d set salvati. I dati salvati originali sono stati conservati."
L["%d legacy entries could not be migrated. Original saved data was kept."] =
"Non è stato possibile migrare %d voci legacy. I dati originali salvati sono stati conservati."

L["Navigation.RestoreEquipment_LABEL"] = "Ripristina l'equipaggiamento dopo il viaggio"
L["Navigation.RestoreEquipment_DESCRIPTION"] =
"Ripristina l'equipaggiamento sostituito dagli oggetti di navigazione e mostra le notifiche relative all'equipaggiamento. Anche se questa opzione è disattivata, l'equipaggiamento già sostituito viene comunque ripristinato."

L["Clear"] = "Cancella"
L["Options"] = "Opzioni"
L["Minimap"] = "Minimappa"
L["Help"] = "Aiuto"
L["Clear all active pins in visible groups."] = "Cancella tutti i segnaposto attivi nei gruppi visibili."

-- Startup introduction
L["Example pin"] = "Segnaposto di esempio"
L["Introduction"] = "Introduzione"
L["Step %d of %d"] = "Passo %d di %d"
L["Reset the startup introduction."] = "Reimposta l'introduzione all'avvio."
L["This introduction covers some of the addon's core settings. You can change all of these choices later in settings."] =
"Questa introduzione illustra alcune delle impostazioni principali dell'add-on. Potrai modificare tutte queste opzioni in un secondo momento nelle impostazioni."
L["Floating shows a diamond in the world at your target. Arrow uses a simple pointer to show the direction."] =
"Fluttuante mostra un rombo nel mondo in corrispondenza della destinazione. Freccia usa un semplice puntatore per indicare la direzione."
L["Navigation shows the best available route to your target location."] =
"Il sistema di navigazione indica il percorso migliore disponibile per raggiungere la destinazione desiderata."
L["Hold Ctrl and click the world map to place a pin. The button below creates a test pin near your character and finishes the introduction."] =
"Tieni premuto il tasto Ctrl e clicca sulla mappa del mondo per posizionare un segnaposto. Il pulsante qui sotto crea un segnaposto di prova vicino al tuo personaggio e conclude l'introduzione."
L["Let's go!"] = "Andiamo!"
L["Finish"] = "Fine"
L["Next"] = "Avanti"
L["Place test pin and finish"] = "Posiziona un segnaposto di prova e termina"
L["Welcome to Map Pin Enhanced!"] = "Benvenuti su Map Pin Enhanced!"
L["Select a wayfinder"] = "Seleziona un indicatore di direzione"
L["Enable navigation"] = "Abilita la navigazione"
L["Place your first pin"] = "Posiziona il tuo primo segnaposto"

------------------------------ Tooltip helper ------------------------------
L["Click"] = "Clicca"
L["Alt + Click"] = "Alt + clic"
L["Left Click"] = "Clic sinistro"
L["Right Click"] = "Clic destro"
L["Middle Click"] = "Clic con il tasto centrale"
L["Ctrl + Left Click"] = "Ctrl + clic sinistro"
L["Shift + Left Click"] = "Maiusc + clic sinistro"
L["Alt + Left Click"] = "Alt + clic sinistro"
L["Open menu"] = "Apri il menu"
L["Collapse"] = "Comprimi"
L["Clear without confirmation"] = "Cancella senza conferma"
L["Delete without confirmation"] = "Elimina senza conferma"
L["Change pin appearance"] = "Modifica l'aspetto del segnaposto"
L["General.TooltipHelper_LABEL"] = "Abilita l'aiuto con i suggerimenti"
L["General.TooltipHelper_DESCRIPTION"] = "Mostra le azioni disponibili con un clic nei suggerimenti."

L["Common options"] = "Opzioni comuni"
L["Choose which helpers you want to enable. You can change these choices later in settings."] =
"Scegli quali funzioni di assistenza desideri attivare. Potrai modificare queste impostazioni in un secondo momento nelle impostazioni."

--@debug@
L["Profiler"] = "Profiler"
L["Profiler: restore"] = "Profiler: ripristino"
L["Profiler: recording - restore"] = "Profiler: registrazione - ripristino"
L["Modules"] = "Moduli"
L["Modules: %d"] = "Moduli: %d"
L["All modules"] = "Tutti i moduli"
L["Start"] = "Avvia"
L["Stop"] = "Ferma"
L["Reset"] = "Reimposta"
L["Recording. Closing this window stops capture."] =
"Registrazione. Chiudendo questa finestra si interrompe la registrazione."
L["Capture stopped: %.2f seconds. Export to inspect results."] =
"Acquisizione interrotta: %.2f secondi. Eseguire l'esportazione per esaminare i risultati."
L["Select modules, then start a new capture."] = "Seleziona i moduli, quindi avvia una nuova acquisizione."
L["Open the profiler."] = "Apri il profiler."
--@end-debug@

L["FlightTimer.Enable_LABEL"] = "Attiva il timer di volo"
L["FlightTimer.Enable_DESCRIPTION"] =
"Mostra una barra di avanzamento spostabile e il tempo rimanente stimato durante i voli dei maestri di volo."
L["FlightTimer.Lock_LABEL"] = "Blocca il timer di volo"
L["FlightTimer.Lock_DESCRIPTION"] = "Impedire che il timer di volo venga spostato."
L["FlightTimer.Scale_LABEL"] = "Dimensioni del timer di volo"
L["FlightTimer.Scale_DESCRIPTION"] = "Scegli la dimensione del timer di volo."
L["Flight Timer"] = "Timer di volo"
L["Flight elapsed: %s"] = "Tempo trascorso: %s"
L["Flight remaining: %s"] = "%s rimanenti"

L["Mode: baseline"] = "Modalità: di riferimento"
L["Mode: detailed"] = "Modalità: dettagliata"

L["Baseline measures whole-addon engine time. Detailed adds function scopes and preparation phases. Both include percentage impact and a timeline. Compare matching gameplay; profiling adds overhead and detailed times overlap."] =
"La modalità di base misura il tempo di elaborazione totale dell'addon. Quella dettagliata aggiunge le singole funzioni e le fasi di preparazione. Entrambe mostrano l'impatto percentuale e una linea temporale. Confronta situazioni di gioco simili: la profilazione comporta un carico aggiuntivo e i tempi dettagliati si sovrappongono."

L["Share location"] = "Condividi la posizione"
L["Place a pin here"] = "Metti un segnaposto qui"
L["Enter the Wizard's Sanctum."] = "Entra nel Santuario della Magia."
