---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

if MapPinEnhanced.locale ~= "frFR" then return end

---@class Locale
local L = MapPinEnhanced.L

------------------------------ Shared UI ------------------------------
L["Cancel"] = "Annuler"
L["Close"] = "Fermer"
L["A new version (%s) for Map Pin Enhanced is available. You are on (%s)."] =
"Une nouvelle version (%s) de Map Pin Enhanced est disponible. Vous utilisez actuellement la version (%s)."
L["Addon conflicts"] = "Conflits entre add-ons"
L["The following addons interfere with Map Pin Enhanced and should not be used together:\n\n%s\n\nDisable them in the AddOns menu and reload your UI."] =
"Les add-ons suivants entrent en conflit avec Map Pin Enhanced et ne doivent pas être utilisés conjointement :\n\n%s\n\nDésactivez-les dans le menu « Add-ons » et rechargez votre interface utilisateur."
L["Confirm"] = "Confirmer"
L["Icon Picker"] = "Sélecteur d'icônes"
L["Select an icon"] = "Sélectionnez une icône"
L["%d icons"] = "%d icônes"
L["%d icons (loading...)"] = "%d icônes (chargement en cours...)"
L["Import"] = "Importer"
L["Save"] = "Enregistrer"
L["Stop tracking"] = "Arrêter le suivi"
L["This is the location you are navigating to."] = "C'est l'endroit vers lequel vous vous rendez."
L["Track"] = "Suivre"
L["Remove"] = "Supprimer"

L["Click to edit"] = "Cliquez ici pour modifier"
L["<x> <y> [title]"] = "<x> <y> [titre]"
L["Create and track a pin at percentage coordinates. Example: /mpe 50 50 My pin"] =
"Créer et suivre un repère situé à des coordonnées exprimées en pourcentage. Exemple : /mpe 50 50 Mon repère"
L["You can also use /way instead of /mpe."] = "Vous pouvez également utiliser /way à la place de /mpe."

L["Navigation Hearthstone Data Missing"] =
"La destination à laquelle votre Pierre de foyer est liée inconnue. Utilisez votre Pierre de foyer une fois pour l'enregistrer."
L["Navigation Flight Data Missing"] = "Trajets aériens non débloqués. Parlez à un maître de vol pour les débloquer."

------------------------------ Pins ------------------------------
L["Map Pin"] = "Repère de carte"
L["Add Pin"] = "Ajouter un repère"
L["Target"] = "Cible"
L["Change Color"] = "Changer de couleur"
L["Change Icon"] = "Changer l'icône"
L["Atlas"] = "Atlas"
L["Color"] = "Couleur"
L["Icon"] = "Icône"
L["Locked"] = "Verrouillé"
L["Map"] = "Carte"
L["Name"] = "Nom"
L["X"] = "X"
L["Y"] = "Y"
L["Show on Map"] = "Afficher sur la carte"
L["Clear Pin"] = "Retirer le repère"
L["Delete Permanently"] = "Supprimer définitivement"
L["Delete pin \"%s\"?"] = "Supprimer le repère « %s » ?"
L["Share to Chat"] = "Partager dans le chat"
L["Failed to place pin on the map. Please check if the coordinates are correct!"] =
"Impossible de placer le repère sur la carte. Vérifiez si les coordonnées sont correctes !"
L["Can't Show on Map in Combat"] = "Impossible d'afficher sur la carte en combat"
L["The world map cannot be opened automatically during combat. It will open after combat ends."] =
"La carte du monde ne peut pas être ouverte automatiquement pendant un combat. Elle sera ouverte une fois le combat terminé."

------------------------------ Groups And Tracker ------------------------------
L["Group"] = "Groupe"
L["Hidden"] = "Caché"
L["Show hidden group"] = "Afficher le groupe masqué"
L["No hidden groups"] = "Pas de groupes cachés"
L["Your pins (%d)"] = "Vos repères (%d)"
L["New Group %d"] = "Nouveau groupe %d"
L["Groups"] = "Groupes"
L["Create Group"] = "Créer un groupe"
L["Select"] = "Sélectionner"
L["Select a group to start editing."] = "Sélectionnez un groupe pour commencer à le modifier."
L["Show"] = "Afficher"
L["Hide"] = "Masquer"
L["Ungrouped Pins"] = "Repères non groupés"
L["My Way Back"] = "Mon trajet de retour"
L["Import %d"] = "Importer %d"
L["%d |4pin:pins;"] = "%d |4repère:repères;"
L["A group named \"%s\" already exists."] = "Un groupe nommé « %s » existe déjà."
L["Rename Group"] = "Renommer un groupe"
L["Add to New Group"] = "Ajouter à un nouveau groupe"
L["Delete Group"] = "Supprimer un groupe"
L["Clear Group"] = "Vider le groupe"
L["Show Group"] = "Afficher le groupe"
L["Hide Group"] = "Masquer le groupe"
L["Restore Pins"] = "Restaurer les repères"
L["Make pins restorable"] = "Rendre les repères restaurables"
L["Delete group \"%s\" and all of its pins?"] = "Souhaitez-vous supprimer le groupe « %s » et tous ses repères ?"
L["Clear all pins from \"%s\"?"] = "Retirer tous les repères de « %s » ?"
L["Tracking Mode"] = "Mode de suivi"
L["Track by Distance"] = "Suivre en fonction de la distance"
L["Track by Order"] = "Suivre en fonction l'ordre"
L["Toggle the tracker visibility."] = "Activer ou désactiver l'affichage du suivi."
L["Dungeon"] = "Donjon"
L["Raid"] = "Raid"
L["Scenario"] = "Scénario"
L["Battleground"] = "Champ de bataille"
L["Arena"] = "Arène"
L["None"] = "Aucun"
L["No active pins"] = "Aucun repère actif"
L["No coordinates available"] = "Aucune coordonnée disponible"
L["Miscellaneous.Coords.Visibility_LABEL"] = "Masquage automatique"
L["Miscellaneous.Coords.Visibility_DESCRIPTION"] =
"Masquer l'affichage des coordonnées lorsqu'une condition sélectionnée est active."
L["Miscellaneous.Tracker_GROUPLABEL"] = "Suivi"
L["Miscellaneous.Tracker.Visibility_LABEL"] = "Masquage automatique"
L["Miscellaneous.Tracker.Visibility_DESCRIPTION"] =
"Masquer le suivi lorsqu'une des conditions sélectionnées est active."
L["Toggle the group editor."] = "Activer/désactiver l'éditeur de groupe."

------------------------------ Editor ------------------------------
L["Editor"] = "Éditeur"
L["Edit Group"] = "Modifier le groupe"
L["Search"] = "Rechercher"
L["Rename Pin"] = "Renommer un repère"
L["Create a new pin group."] = "Créer un nouveau groupe de repères."
L["Choose an icon for this group."] = "Choisissez une icône pour ce groupe."
L["Delete this group and all of its pins. System groups are cleared instead."] =
"Supprimer ce groupe et tous ses repères. Les groupes système sont effacés au lieu d'être supprimés."
L["Hide or show this group."] = "Masquer ou afficher ce groupe."
L["Permanently delete this pin."] = "Supprimer définitivement ce repère."
L["Create a copy of this pin."] = "Créer une copie de ce repère."
L["copy of %s"] = "copie de %s"
L["Loading"] = "Chargement en cours"

------------------------------ Dialogs ------------------------------
L["Version: %s (%s)"] = "Version : %s (%s)"
L["Build: %s"] = "Build : %s"
L["Special thanks to Byyrax and Pamoo for the help with translations"] =
"Un grand merci à Byyrax et Pamoo pour leur aide dans les traductions"
L["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs!"] =
"Merci à Eminos pour les innombrables heures passées à créer des textures, à réfléchir à des solutions et à échanger des idées avec moi. Merci à tous ceux qui m'ont aidé à tester les nouvelles versions, qui m'ont fait part de leurs commentaires et qui m'ont signalé des bugs !"
L["Open the about dialog to view version information."] =
"Ouvrez la boîte de dialogue « À propos » pour afficher les informations relatives à la version."

------------------------------ Transfer ------------------------------
L["Export"] = "Exporter"
L["Way commands"] = "Commandes « Way »"
L["Serialized data"] = "Données sérialisées"
L["Open the import dialog to import map pins from a string."] =
"Ouvrez la boîte de dialogue d'importation pour importer des repères de carte à partir d'une chaîne de caractères."
L["You can import pins by pasting multiple slash commands or a Map Pin Enhanced export string (starting with %s)"] =
"Vous pouvez importer des repères en collant plusieurs commandes slash (« / ») ou une chaîne d'exportation « Map Pin Enhanced » (commençant par %s)"
L["Click to paste export string or slash commands here"] =
"Cliquez ici pour coller une chaîne d'exportation ou des commandes slash (« / »)"
L["Choose an export format, then copy the text below."] =
"Choisissez un format d'exportation, puis copiez le texte ci-dessous."
L["Command prefix:"] = "Préfixe de commande :"
L["Exporting %d pins across %d maps"] = "Exportation de %d |4repère:repères; sur %d |4carte:cartes;"
L["%s: %d pins across %d maps"] = "%s : %d |4repère:repères; sur %d |4carte:cartes;"
L["%d invalid entries will be skipped"] = "%d |4entrée non valide sera ignorée: les entrées non valides seront ignorées"
L["Invalid or corrupted serialized data."] = "Données sérialisées non valides ou corrompues."
L["No valid pins were found to import."] = "Aucun repère valide à importer."
L["Importing %d pins; skipped %d invalid entries."] =
"Importation de %d |4repère:repères; ; %d |4entrée non valide ignorée:entrées non valides ignorées;."
L["Import failed."] = "L'importation a échoué."
L["Warning: slash commands do not preserve descriptions, custom icons or colors. /mappin also omits pin titles."] =
"Avertissement : les commandes slash (« / ») ne conservent pas les descriptions, les icônes personnalisées ni les couleurs. La commande /mappin omet également les titres des repères."

------------------------------ Providers ------------------------------
L["%s added hidden group \"%s\"."] = "%s a ajouté le groupe masqué « %s »."
L["TomTom Pins"] = "Repères TomTom"
L["TomTom Waypoint"] = "Point de passage TomTom"
L["TomTom Is Loaded! You may experience some unexpected behavior."] =
"TomTom est chargé ! Vous pourriez constater un comportement inattendu."
L["\"%s\" reached at %s."] = "« %s » atteint aux coordonnées %s."
L["Location reached at %s."] = "Destination atteinte aux coordonnées %s."
L["Equipped %s."] = "%s équipé."
L["Re-equipped %s."] = "%s équipé à nouveau."
L["Restored empty equipment slot."] = "L'emplacement d'équipement vide a été rétabli."
L["Could not restore %s."] = "Impossible de restaurer %s."
L["Could not restore empty equipment slot."] = "Impossible de restaurer l'emplacement d'équipement vide."
L["It is locked."] = "C'est verrouillé"
L["Turn in: %s"] = "Rendre : %s"
L["Corpse"] = "Cadavre"
L["Quest"] = "Quête"
L["Content"] = "Contenu"
L["Vignette"] = "Vignette"
L["House"] = "Maison"
L["%s's House"] = "Maison de %s"

------------------------------ Miscellaneous ------------------------------
L["Back"] = "Retour"
L["Create a Pin at Your Current Location"] = "Créer un repère à votre position actuelle"
L["Unable to determine your current map location."] = "Impossible de déterminer votre position actuelle sur la carte."
L["Unable to determine your current position on the map."] =
"Impossible de déterminer votre position actuelle sur la carte."
L["%s's Position"] = "Position de %s"
L["You Are in an Instance or a Zone Where the Map Is Not Available"] =
"Vous vous trouvez dans une instance ou une zone où la carte n'est pas disponible"
L["My Way Back is unavailable on the map you are on right now."] =
"« Mon retour » n'est pas disponible sur la carte actuelle."

------------------------------ Options ------------------------------
L["General"] = "Général"
L["Pins"] = "Repères"
L["Miscellaneous"] = "Divers"
L["Wayfinder"] = "Guide de navigation"
L["Search for option..."] = "Rechercher une option..."
L["Open the options frame"] = "Ouvrez la fenêtre des options"
L["Open options"] = "Ouvrir les options"
L["Open editor"] = "Ouvrir l'éditeur"

L["General.Minimap_GROUPLABEL"] = "Mini-carte"
L["Clear all pins"] = "Retirer tous les repères"
L["Some pins are still being updated. Try clearing again when the current operation finishes."] =
"Certains repères sont encore en cours de mise à jour. Réessayez de les retirer une fois l'opération terminée."
L["Hide minimap button"] = "Masquer le bouton de la mini-carte"
L["Toggle the minimap button visibility."] = "Activer ou désactiver l'affichage du bouton de la mini-carte."
L["General.Minimap.ShowButton_LABEL"] = "Afficher le bouton de la mini-carte"
L["General.Minimap.ShowButton_DESCRIPTION"] = "Afficher le bouton de l'add-on sur la mini-carte."
L["General.Minimap.CustomButton_LABEL"] = "Bouton personnalisé pour la mini-carte"
L["General.Minimap.CustomButton_DESCRIPTION"] =
"Utiliser un logo plus grand, sans la bordure ni l'arrière-plan standard du bouton de la mini-carte."
L["General.Distance_GROUPLABEL"] = "Distance"
L["General.Distance.ShowUnit_LABEL"] = "Afficher l'unité de distance"
L["General.Distance.ShowUnit_DESCRIPTION"] = "Afficher l'unité de distance à côté des valeurs de distance."
L["General.Tracking_GROUPLABEL"] = "Suivi"
L["Reload UI"] = "Recharger l'interface"
L["This change requires a UI reload. Reload now?"] =
"Ce changement nécessite de recharger l'interface. Recharger maintenant ?"

L["Pins.Miscellaneous_GROUPLABEL"] = "Divers"
L["Pins.Miscellaneous.ScaleOnHover_LABEL"] = "Agrandir les repères lorsque vous passez la souris dessus"
L["Pins.Miscellaneous.ScaleOnHover_DESCRIPTION"] =
"Agrandissez les repères sur la carte du monde lorsque vous passez la souris dessus."

L["Miscellaneous.Coords_GROUPLABEL"] = "Affichage des coordonnées"
L["Miscellaneous.Coords.Enable_LABEL"] = "Activer l'affichage des coordonnées"
L["Miscellaneous.Coords.Enable_DESCRIPTION"] = "Activer ou désactiver l'affichage à l'écran de vos coordonnées actuelles"
L["Miscellaneous.Coords.Lock_LABEL"] = "Verrouiller l'affichage des coordonnées"
L["Miscellaneous.Coords.Lock_DESCRIPTION"] =
"Activer ou désactiver la possibilité de déplacer l'affichage des coordonnées."

L["Wayfinder.General.HideBlizzardFloatingDiamond_LABEL"] = "Masquer le losange flottant de Blizzard"
L["Wayfinder.General.HideBlizzardFloatingDiamond_DESCRIPTION"] =
"Masquer le losange de navigation flottant de Blizzard lorsque le guide de navigation flottant « Map Pin Enhanced » est désactivé."
L["Wayfinder.General.Selection_LABEL"] = "Guide de navigation"
L["Wayfinder.General.Selection_DESCRIPTION"] = "Choisissez le guide de navigation à utiliser."
L["Arrow"] = "Flèche"
L["Floating"] = "Flottant"
L["Wayfinder.Navigation_GROUPLABEL"] = "Navigation"
L["Wayfinder.Navigation.Enable_LABEL"] = "Activer la navigation par itinéraire"
L["Wayfinder.Navigation.Enable_DESCRIPTION"] =
"Calculez des itinéraires en utilisant les déplacements, portails, moyens de transport, sorts, objets et jouets à votre disposition."
L["Wayfinder.Navigation.AutomaticTravelSelection_LABEL"] = "Sélection automatique de l'itinéraire"
L["Wayfinder.Navigation.AutomaticTravelSelection_DESCRIPTION"] =
"Sélectionnez automatiquement les options de dialogue des PNJ et les destinations de vol requises par votre itinéraire actuel. Maintenez la touche Maj enfoncée lorsque vous ouvrez la carte de vol pour sélectionner manuellement un vol."
L["Wayfinder.Navigation.WorldMap_LABEL"] = "Afficher l'itinéraire sur une carte du monde"
L["Wayfinder.Navigation.WorldMap_DESCRIPTION"] = "Afficher l'itinéraire calculé sur la carte du monde."
L["Wayfinder.Navigation.Minimap_LABEL"] = "Afficher l'itinéraire sur la mini-carte"
L["Wayfinder.Navigation.Minimap_DESCRIPTION"] = "Afficher l'itinéraire calculé sur la mini-carte."
L["Navigation Calculating"] = "Calcul de l'itinéraire..."
L["Navigation Direct Guidance"] = "Aucun itinéraire n'est disponible. Suivez directement votre destination."
L["Navigation No Direction"] = "Aucune direction disponible pour cette destination."
L["Navigation Step Waiting Combat"] =
"Il se peut que cette étape ne soit pas à jour. Elle sera mise à jour à la fin du combat."
L["Navigation Action Shift Combat"] = "Appuyez sur Maj + clic gauche pour utiliser l'action affichée pendant le combat."
L["Navigation Action Unavailable Combat"] = "Cette action sera disponible après le combat."
L["Navigation Action Started"] = "En attente de la confirmation d'arrivée."
L["Navigation Action Failed"] = "L'opération n'a pas abouti. Veuillez réessayer ou recalculer l'itinéraire."
L["Navigation Finding Another Route"] = "Recherche d'un autre itinéraire..."
L["Navigation Arrival Confirming"] = "Confirmation de l'arrivée..."
L["Navigation Walk"] = "Rendez-vous au point suivant."
L["Navigation Fly"] = "Volez vers le point suivant."
L["Navigation Travel To Destination"] = "Rendez-vous à %s."
L["Navigation Fly To Destination"] = "Volez vers %s."
L["Navigation Route To"] = "Itinéraire vers : %s (%s)"
L["Navigation Chat Header"] = "Itinéraire vers : %s (%s) — %s"
L["Navigation Chat Unavailable"] =
"Sélectionnez un canal de discussion disponible ou un destinataire de chuchotement avant d'exporter l'itinéraire."
L["Send"] = "Envoyer"
L["Navigation Chat Choose Channel"] = "Choisissez où envoyer cet itinéraire :"
L["Navigation Chat Whisper To"] = "Chuchoter à"
L["Navigation Chat Player Name"] = "Nom du joueur ou Nom-Royaume"
L["Navigation Chat Route Changed"] = "L'itinéraire a changé. Fermez cette fenêtre et exportez-le à nouveau."
L["Party"] = "Groupe"
L["Say"] = "Dire"
L["Whisper"] = "Chuchoter"
L["Navigation Step Number"] = "Étape %d : %s"
L["Navigation Cross Border"] = "Passez dans la zone suivante."
L["Navigation Change Floor"] = "Rendez-vous à l'étage indiqué."
L["Navigation Talk To NPC"] = "Parlez au PNJ indiqué."
L["Navigation Method Travel"] = "Voyage"
L["Navigation Method Walking"] = "À pied"
L["Navigation Method Flying"] = "Vol"
L["Navigation Method Portal"] = "Portail"
L["Navigation Method NPC Travel"] = "Voyage via un PNJ"
L["Navigation Method Border"] = "Passage d'une frontière"
L["Navigation Method Floor Change"] = "Changement d'étage"
L["Navigation Method Spell"] = "Sort"
L["Navigation Method Item"] = "Objet"
L["Navigation Method Toy"] = "Jouet"
L["Navigation Method Boat"] = "Bateau"
L["Navigation Method Hearthstone"] = "Pierre de foyer"
L["Navigation Method Flight Taxi"] = "Maître de vol"
L["Navigation Method Phase Change"] = "Changement de phase"
L["Navigation Method Ship"] = "Navire"
L["Navigation Method Tram"] = "Tram"
L["Navigation Method Transport"] = "Transport"
L["Navigation Method Teleport"] = "Téléportation"
L["Navigation Method Zeppelin"] = "Zeppelin"
L["Navigation Use Spell"] = "Utilisez le sort requis."
L["Navigation Use Item"] = "Utilisez l'objet requis."
L["Navigation Use Toy"] = "Utilisez le jouet requis."
L["Navigation Use Hearthstone"] = "Utilisez votre Pierre de foyer."
L["Navigation Use Teleport"] = "Utilisez le téléporteur indiqué."
L["Navigation Take Portal"] = "Empruntez le portail."
L["Navigation Take Portal To"] = "Empruntez le portail vers %s."
L["Navigation Take Portal From To"] = "Empruntez le portail reliant %s à %s."
L["Navigation Cross Border To"] = "Entrez dans %s."
L["Navigation Change Floor To"] = "Changez d'étage pour vous rendre au %s."
L["Navigation Talk To NPC To"] = "Parlez au PNJ indiqué pour vous rendre à %s."
L["Navigation Cast Named Spell"] = "Lancez le sort %s."
L["Navigation Cast Named Spell To"] = "Lancez le sort %s pour vous téléporter vers %s."
L["Navigation Cast Named Spell Return"] = "Lancez le sort %s pour retourner à %s."
L["Navigation Use Toy And Select"] = "Utilisez %s, puis interagissez et sélectionnez %s."
L["Navigation Select Toy Destination"] = "Interagissez avec le jouet et sélectionnez %s."
L["Navigation Use Named Item"] = "Utilisez %s."
L["Navigation Use Named Item To"] = "Utilisez %s pour vous rendre à %s."
L["Navigation Use Named Item Return"] = "Utilisez %s pour revenir à %s."
L["Navigation Use Spell To"] = "Utilisez le sort requis pour vous téléporter vers %s."
L["Navigation Use Teleport To"] = "Utilisez le téléporteur indiqué pour vous rendre à %s."
L["Navigation Use Item To"] = "Utilisez l'objet requis pour vous rendre à %s."
L["Navigation Use Toy To"] = "Utilisez le jouet requis pour vous rendre à %s."
L["Navigation Use Hearthstone To"] = "Utilisez votre Pierre de foyer pour retourner à %s."
L["Navigation Take Boat"] = "Prenez le bateau."
L["Navigation Take Boat To"] = "Prenez le bateau pour %s."
L["Navigation Traveling By Boat"] = "Voyager en bateau."
L["Navigation Traveling By Boat To"] = "Se rendre à %s en bateau."
L["Navigation Take Ship"] = "Prenez le navire."
L["Navigation Take Ship To"] = "Prenez le navire pour %s."
L["Navigation Traveling By Ship"] = "Voyager en navire."
L["Navigation Traveling By Ship To"] = "Voyage en navire vers %s."
L["Navigation Take Zeppelin"] = "Prenez le zeppelin."
L["Navigation Take Zeppelin To"] = "Prenez le zeppelin pour %s."
L["Navigation Traveling By Zeppelin"] = "Voyager en zeppelin."
L["Navigation Traveling By Zeppelin To"] = "Voyage en zeppelin vers %s."
L["Navigation Take Tram"] = "Prenez le tram."
L["Navigation Take Tram To"] = "Prenez le tram jusqu'à %s."
L["Navigation Traveling By Tram"] = "Se déplacer en tram."
L["Navigation Traveling By Tram To"] = "Se rendre à %s en tram."
L["Navigation Take Transport"] = "Prenez le moyen de transport."
L["Navigation Take Transport To"] = "Prenez le moyen de transport vers %s."
L["Navigation Traveling By Transport"] = "Transport en cours."
L["Navigation Traveling By Transport To"] = "Transport vers %s."
L["Navigation Take Flight To"] = "Prenez le vol à destination de %s."
L["Navigation Take Flight"] = "Prenez le vol."
L["Navigation Traveling By Flight"] = "Vol en cours."
L["Navigation Traveling By Flight To"] = "Vol vers %s."
L["Recalculate Route"] = "Recalculer l'itinéraire"
L["%s - %s"] = "%s - %s"
L["System Groups"] = "Groupes système"
L["System groups are managed by Map Pin Enhanced for special features. Their core settings cannot be changed."] =
"Les groupes système sont gérés par Map Pin Enhanced pour des fonctionnalités spéciales. Leurs paramètres principaux ne peuvent pas être modifiés."


L["Report"] = "Rapport"
L["Report a navigation problem"] = "Signaler un problème de navigation"
L["Help improve navigation"] = "Aidez-nous à améliorer la navigation"
L["Describe the problem, then copy the report below and post it on either issue page. Copy a URL into your browser to get started."] =
"Décrivez le problème, puis copiez le rapport ci-dessous et publiez-le sur l'une des pages dédiées aux problèmes. Copiez une URL dans votre navigateur pour commencer."
L["What went wrong?"] = "Qu'est-ce qui a mal fonctionné ?"
L["What happened, what did you expect, and how can we reproduce it?"] =
"Que s'est-il passé, à quoi vous attendiez-vous et comment peut-on reproduire ce bug ?"
L["Your report (description and debug data)"] = "Votre rapport (description et données de débogage)"
L["Click the report or a URL to select it, then press Ctrl+C to copy."] =
"Cliquez sur le rapport ou sur une URL pour le/la sélectionner, puis appuyez sur Ctrl+C pour le/la copier."
L["Navigation Debug Dump"] = "Vidage de débogage de la navigation"


L["Description"] = "Description"
L["Edit Description"] = "Modifier la description"
L["Add notes for this pin. Descriptions appear in pin tooltips and below the wayfinder title."] =
"Ajoutez des notes à ce repère. Les descriptions apparaissent dans les infobulles des repères et sous le titre du guide de navigation."
L["This pin is no longer in this group."] = "Ce repère ne fait plus partie de ce groupe."
L["Apply"] = "Appliquer"

L["Wayfinder.Floating.ScaleWithDistance_LABEL"] = "Échelle en fonction de la distance"
L["Wayfinder.Floating.ScaleWithDistance_DESCRIPTION"] =
"Le repère flottant et son faisceau passent de 75% à 100% à mesure que vous approchez. Les plages de distance dépendent de la compétence de monte ou de vol au chargement de l'addon et restent fixes jusqu'au rechargement."
L["Wayfinder.Floating.ShowBeam_LABEL"] = "Afficher le faisceau"
L["Wayfinder.Floating.ShowBeam_DESCRIPTION"] =
"Afficher un faisceau au-dessus du marqueur flottant lorsqu'il est à l'écran."
L["Wayfinder.Floating.ShowTextOutline_LABEL"] = "Afficher le contour du texte"
L["Wayfinder.Floating.ShowTextOutline_DESCRIPTION"] =
"Ajouter un contour au texte de distance, de temps d'arrivée estimé et au titre du repère flottant affiché à son apparition ou au survol."
L["Wayfinder.General.ShowETA_LABEL"] = "Afficher l'heure d'arrivée estimée"
L["Wayfinder.General.ShowObjectiveFrame_LABEL"] = "Afficher l'encadré des objectifs de quête"
L["Wayfinder.General.ShowObjectiveFrame_DESCRIPTION"] =
"Afficher les objectifs de quête en entrant dans leur zone. Si cette option est désactivée, le guide flottant est masqué et la flèche reste en affichage de proximité."
L["Wayfinder.General.ShowETA_DESCRIPTION"] =
"Afficher l'estimation du temps de trajet jusqu'à la destination actuelle, ainsi que la distance correspondante, lorsque ces informations sont disponibles."
L["Wayfinder.Navigation.TransportationGroups_LABEL"] = "Transports"
L["Wayfinder.Navigation.TransportationGroups_DESCRIPTION"] =
"Choisissez parmi les moyens de transport proposés par le système de navigation. Les transports réguliers comprennent les bateaux, les zeppelins et les tramways. Les moyens de téléportation personnels comprennent les sorts de voyage, les objets, les jouets et la Pierre de foyer de Dalaran."
L["Navigation Transportation Portals"] = "Portails"
L["Navigation Transportation Flight paths"] = "Trajets aériens"
L["Navigation Transportation Scheduled transport"] = "Transports réguliers"
L["Navigation Transportation NPC travel"] = "Voyage via un PNJ"
L["Navigation Transportation Phase changes"] = "Changements de phase"
L["Navigation Transportation Personal teleports"] = "Téléportations personnelles"
L["Navigation Transportation Dungeon teleports"] = "Téléportations dans les donjons"

L["Wayfinder.Display_GROUPLABEL"] = "Affichage"
L["Settings for Floating; Arrow is still selected."] = "Paramètres de Flottant ; Flèche est toujours sélectionné."
L["Settings for Arrow; Floating is still selected."] = "Paramètres de Flèche ; Flottant est toujours sélectionné."

L["Clear Tracking"] = "Arrêter le suivi"
L["In objective area"] = "Dans la zone d'objectif"
L["Why do I see this navigation element?"] = "Pourquoi cet élément de navigation s'affiche-t-il ?"
L["Wayfinder.Floating.Fallback_DESCRIPTION"] =
"L'interface utilisateur de Blizzard ne peut pas fournir de position dans le monde valable pour cette cible dans cette zone. Cette flèche n'est utilisée qu'à titre temporaire et disparaîtra dès que des informations de jeu valides seront disponibles."

L["Group sharing timed out. The sender must be online and the link must still be available."] =
"Le délai de partage du groupe a expiré. L'expéditeur doit être en ligne et le lien doit toujours être disponible."
L["Requesting shared group..."] = "Demande du groupe partagé..."
L["Receiving shared group..."] = "Réception du groupe partagé..."
L["Shared group \"%s\" received."] = "Le groupe partagé « %s » a été reçu."
L["This shared group is no longer available. Ask the sender for a new link."] =
"Ce groupe partagé n'est plus disponible. Demandez un nouveau lien à l'expéditeur."

L["Pin operation stopped after %d of %d pins. Completed changes were kept."] =
"L'opération s'est arrêtée après %d repères sur %d. Les modifications effectuées ont été conservées."

-- Category options (0041).
L["Miscellaneous.Coords.ShowZone_LABEL"] = "Afficher la zone"
L["Miscellaneous.Coords.ShowZone_DESCRIPTION"] = "Indiquez le nom complet de la carte entre vos coordonnées X et Y."
L["Miscellaneous.Coords.ShowDecimals_LABEL"] = "Afficher les décimales"
L["Miscellaneous.Coords.ShowDecimals_DESCRIPTION"] =
"Afficher deux décimales. Désactiver cette option pour afficher les coordonnées entières tronquées."
L["Pins.Appearance.AlwaysPingTracked_LABEL"] = "Toujours ping le repère suivi"
L["Pins.Appearance.AlwaysPingTracked_DESCRIPTION"] =
"Faire clignoter le repère de la carte du monde toutes les deux secondes tant qu'il est visible."
L["Pins.Appearance.MinimapScale_LABEL"] = "Taille des repères sur la mini-carte"
L["Pins.Appearance.MinimapScale_DESCRIPTION"] = "Choisissez la taille des repères ordinaires sur la mini-carte."
L["Pins.Appearance.WorldMapScale_LABEL"] = "Taille des repères sur la carte du monde"
L["Pins.Appearance.WorldMapScale_DESCRIPTION"] =
"Choisissez la taille des repères standard de la carte du monde. L'agrandissement au survol s'applique en supplément."
L["Pins.Appearance.DefaultColor_LABEL"] = "Couleur par défaut des repères"
L["Pins.Appearance.DefaultColor_DESCRIPTION"] =
"Couleur des nouveaux repères sans icône ni couleur explicitement définie. Les repères existants et importés conservent leur apparence."
L["Pins.Appearance.FadeUntracked_LABEL"] = "Rendre opaques les repères non suivis"
L["Pins.Appearance.FadeUntracked_DESCRIPTION"] =
"Réglez l'opacité des repères de carte non suivis à 40 %. Le survol rétablit l'opacité maximale."
L["Pins.Appearance.ShowMinimapPins_LABEL"] = "Afficher les repères sur la mini-carte"
L["Pins.Appearance.ShowMinimapPins_DESCRIPTION"] =
"Afficher les repères standard des add-ons sur la mini-carte. Les repères de la mini-carte nécessitent des mises à jour de position ; les repères de guidage et d'itinéraire restent indépendants."
L["Pins.Miscellaneous.EnableLockedPins_LABEL"] = "Activer le verrouillage des repères"
L["Pins.Miscellaneous.EnableLockedPins_DESCRIPTION"] =
"Autoriser les nouveaux verrouillages. Les repères verrouillés restent en place jusqu'à leur retrait ; les repères existants peuvent toujours être déverrouillés."
L["Pins.Tracking.ArrivalNotification_LABEL"] = "Notification à l'arrivée au repère"
L["Pins.Tracking.ArrivalNotification_DESCRIPTION"] =
"Envoyer une notification une fois par session de suivi lorsque la destination finale du module est physiquement atteinte."
L["Pins.Tracking.AutoUntrack_LABEL"] = "Arrêter automatiquement le suivi"
L["Pins.Tracking.AutoUntrack_DESCRIPTION"] =
"Effacer le suivi de l'addon et de Blizzard à l'entrée dans un donjon, un raid, un scénario, un champ de bataille ou une arène."
L["Miscellaneous.Tracker.AutoShow_LABEL"] = "Afficher automatiquement à l'ajout d'un repère"
L["Miscellaneous.Tracker.AutoShow_DESCRIPTION"] =
"Afficher et développer le suivi après la création d'un repère ou la confirmation d'une importation. Suivre un élément de Blizzard ne déclenche pas cette action. Les règles de masquage automatique restent actives."
L["Miscellaneous.Tracker.CloseAction_LABEL"] = "Réduire le suivi au lieu de le fermer"
L["Miscellaneous.Tracker.CloseAction_DESCRIPTION"] = "Lorsque le suivi est réduit, ne laisser apparaître que l'en-tête."
L["Miscellaneous.Tracker.ShowCoordinates_LABEL"] = "Afficher les coordonnées"
L["Miscellaneous.Tracker.ShowCoordinates_DESCRIPTION"] =
"Afficher les coordonnées à côté du nom de la zone dans les entrées de repères du suivi."
L["Miscellaneous.Tracker.MaximumRows_LABEL"] = "Nombre maximal de lignes visibles"
L["Miscellaneous.Tracker.MaximumRows_DESCRIPTION"] =
"Nombre maximal de lignes de groupes et de repères avant le défilement, hors en-tête."
L["Miscellaneous.Tracker.BackgroundOpacity_LABEL"] = "Opacité de l'arrière-plan du suivi"
L["Miscellaneous.Tracker.BackgroundOpacity_DESCRIPTION"] = "Opacité derrière la liste des repères, de 0 % à 100 %."
L["Miscellaneous.Tracker.Scale_LABEL"] = "Taille du suivi"
L["Miscellaneous.Tracker.Scale_DESCRIPTION"] = "Choisissez la taille du suivi."
L["Pins.Appearance_GROUPLABEL"] = "Apparence"
L["Pins.Tracking_GROUPLABEL"] = "Suivi"
L["Coordinates"] = "Coordonnées"
L["Tracker"] = "Suivi"
L["Small (90%)"] = "Petit (90 %)"
L["Default (100%)"] = "Par défaut (100 %)"
L["Large (125%)"] = "Grand (125 %)"
L["Huge (150%)"] = "Énorme (150 %)"
L["Red"] = "Rouge"
L["Orange"] = "Orange"
L["Pale"] = "Pâle"
L["Yellow"] = "Jaune"
L["Green"] = "Vert"
L["LightBlue"] = "Bleu clair"
L["DarkBlue"] = "Bleu foncé"
L["Purple"] = "Violet"
L["Pink"] = "Rose"
L["Only locked pins"] = "Uniquement les repères verrouillés"
L["All pins"] = "Tous les repères"
L["Disabled"] = "Désactivé"
L["Minimize"] = "Réduire"
L["Expand"] = "Agrandir"
L["Lock Pin"] = "Verrouiller le repère"
L["Unlock Pin"] = "Déverrouiller le repère"

------------------------------ Legacy migration ------------------------------
L["Legacy migration could not update groups. Original saved data was kept."] =
"La migration des anciennes données n'a pas permis de mettre à jour les groupes. Les données d'origine enregistrées ont été conservées."
L["Migrated %d legacy pins and %d saved sets. Original saved data was kept."] =
"%d anciens repères et %d ensembles enregistrés ont été migrés. Les données d'origine ont été conservées."
L["%d legacy entries could not be migrated. Original saved data was kept."] =
"%d les entrées anciennes n'ont pas pu être migrées. Les données d'origine enregistrées ont été conservées."

L["Wayfinder.Navigation.RestoreEquipment_LABEL"] = "Rééquiper après le voyage"
L["Wayfinder.Navigation.RestoreEquipment_DESCRIPTION"] =
"Restaurer l'équipement remplacé par des objets de navigation et afficher les notifications relatives à l'équipement. Même si cette option est désactivée, l'équipement déjà remplacé est tout de même restauré."

L["Clear"] = "Retirer."
L["Options"] = "Options"
L["Minimap"] = "Mini-carte"
L["Help"] = "Aide"
L["Clear all active pins in visible groups."] = "Retirer tous les repères actifs des groupes visibles."

-- Startup introduction
L["Example pin"] = "Exemple de repère"
L["Introduction"] = "Introduction"
L["Step %d of %d"] = "Étape %d sur %d"
L["Reset the startup introduction."] = "Réinitialiser l'introduction au démarrage."
L["This introduction covers some of the addon's core settings. You can change all of these choices later in settings."] =
"Cette introduction présente certains des paramètres essentiels de l'add-on. Vous pourrez modifier tous ces paramètres ultérieurement dans les options."
L["Floating shows a diamond in the world at your target. Arrow uses a simple pointer to show the direction."] =
"Flottant affiche un losange dans le monde à votre destination. Flèche utilise un simple pointeur pour indiquer la direction."
L["Navigation shows the best available route to your target location."] =
"La navigation vous indique le meilleur itinéraire disponible pour rejoindre votre destination."
L["Hold Ctrl and click the world map to place a pin. The button below creates a test pin near your character and finishes the introduction."] =
"Maintenez la touche Ctrl enfoncée et cliquez sur la carte du monde pour placer un repère. Le bouton ci-dessous permet de créer un repère test près de votre personnage et de terminer l'introduction."
L["Let's go!"] = "C'est parti !"
L["Finish"] = "Terminer"
L["Next"] = "Suivant"
L["Place test pin and finish"] = "Placer un repère test et terminer"
L["Welcome to Map Pin Enhanced!"] = "Bienvenue sur Map Pin Enhanced !"
L["Select a wayfinder"] = "Sélectionnez un guide de navigation"
L["Enable navigation"] = "Activer la navigation"
L["Place your first pin"] = "Placez votre premier repère"

------------------------------ Tooltip helper ------------------------------
L["Click"] = "Cliquez"
L["Alt + Click"] = "Alt + clic"
L["Left Click"] = "Clic gauche"
L["Right Click"] = "Clic droit"
L["Middle Click"] = "Clic du milieu"
L["Ctrl + Left Click"] = "Ctrl + clic gauche"
L["Shift + Left Click"] = "Maj + clic gauche"
L["Alt + Left Click"] = "Alt + clic gauche"
L["Open menu"] = "Ouvrir le menu"
L["Collapse"] = "Réduire"
L["Clear without confirmation"] = "Retirer sans confirmation"
L["Delete without confirmation"] = "Supprimer sans confirmation"
L["Change pin appearance"] = "Modifier l'apparence du repère"
L["General.TooltipHelper_LABEL"] = "Activer l'aide par info-bulle"
L["General.TooltipHelper_DESCRIPTION"] = "Afficher les actions disponibles par clic dans les infobulles."

L["Common options"] = "Options courantes"
L["Choose which helpers you want to enable. You can change these choices later in settings."] =
"Sélectionnez les aides que vous souhaitez activer. Vous pourrez modifier ces choix ultérieurement dans les paramètres."

--@debug@
L["Profiler"] = "Profiler"
L["Profiler: restore"] = "Profiler : restauration"
L["Profiler: recording - restore"] = "Profiler : enregistrement - restauration"
L["Modules"] = "Modules"
L["Modules: %d"] = "Modules : %d"
L["All modules"] = "Tous les modules"
L["Start"] = "Démarrer"
L["Stop"] = "Arrêter"
L["Reset"] = "Réinitialiser"
L["Recording. Closing this window stops capture."] =
"Enregistrement. La fermeture de cette fenêtre met fin à la capture."
L["Capture stopped: %.2f seconds. Export to inspect results."] =
"Capture arrêtée : %.2f secondes. Exportez les données pour examiner les résultats."
L["Select modules, then start a new capture."] = "Sélectionnez les modules, puis lancez une nouvelle capture."
L["Open the profiler."] = "Ouvrez le profileur."
--@end-debug@

L["General.FlightTimer.Enable_LABEL"] = "Activer le chronomètre de vol"
L["General.FlightTimer.Enable_DESCRIPTION"] =
"Afficher une barre de progression déplaçable et le temps restant estimé pendant les trajets des maîtres de vol."
L["General.FlightTimer.Lock_LABEL"] = "Verrouiller le chronomètre de vol"
L["General.FlightTimer.Lock_DESCRIPTION"] = "Empêcher que le minuteur de vol ne soit déplacé."
L["General.FlightTimer.Scale_LABEL"] = "Taille du chronomètre de vol"
L["General.FlightTimer.Scale_DESCRIPTION"] = "Choisissez la taille du chronomètre de vol."
L["Flight Timer"] = "Chronomètre de vol"
L["Flight elapsed: %s"] = "Temps écoulé : %s"
L["Flight remaining: %s"] = "%s restant"

L["Mode: baseline"] = "Mode : standard"
L["Mode: detailed"] = "Mode : détaillé"

L["Baseline measures whole-addon engine time. Detailed adds function scopes and preparation phases. Both include percentage impact and a timeline. Compare matching gameplay; profiling adds overhead and detailed times overlap."] =
"Le mode standard mesure le temps de calcul total de l'addon. Le mode détaillé ajoute les fonctions individuelles et les phases de préparation. Les deux affichent l'impact en pourcentage et une chronologie. Comparez des situations de jeu similaires : le profilage ajoute une charge et les durées détaillées se chevauchent."

L["Share location"] = "Partager la localisation"
L["Place a pin here"] = "Placez un repère ici"
L["Enter the Wizard's Sanctum."] = "Entrez dans le Sanctuaire du Sorcier."
