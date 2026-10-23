---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

if MapPinEnhanced.locale ~= "esMX" then return end

---@class Locale
local L = MapPinEnhanced.L

------------------------------ Shared UI ------------------------------
L["Cancel"] = "Cancelar"
L["Close"] = "Cerrar"
L["A new version (%s) for Map Pin Enhanced is available. You are on (%s)."] =
"Hay disponible una nueva versión (%s) de Map Pin Enhanced. Tu versión es (%s)."
L["Addon conflicts"] = "Conflicto entre addons"
L["The following addons interfere with Map Pin Enhanced and should not be used together:\n\n%s\n\nDisable them in the AddOns menu and reload your UI."] =
"Los siguientes addons interfieren con «Map Pin Enhanced» y no deben utilizarse junto con él:\n\n%s\n\nDesactívalos en el menú «Addons» y actualiza tu interfaz."
L["Confirm"] = "Confirmar"
L["Icon Picker"] = "Selector de iconos"
L["Select an icon"] = "Selecciona un icono"
L["%d icons"] = "%d iconos"
L["%d icons (loading...)"] = "%d iconos (cargando...)"
L["Import"] = "Importar"
L["Save"] = "Guardar"
L["Stop tracking"] = "Parar seguimiento"
L["This is the location you are navigating to."] = "Esta es la ubicación a la que te diriges."
L["Track"] = "Seguimiento"
L["Remove"] = "Eliminar"

L["Click to edit"] = "Haz clic para editar"
L["<x> <y> [title]"] = "<x> <y> [título]"
L["Create and track a pin at percentage coordinates. Example: /mpe 50 50 My pin"] =
"Crea y realiza un seguimiento de un marcador en unas coordenadas porcentuales. Ejemplo: /mpe 50 50 Mi marcador"
L["You can also use /way instead of /mpe."] = "También puedes usar /way en lugar de /mpe."

L["Navigation Hearthstone Data Missing"] =
"Ubicación de la piedra de hogar desconocida. Usa tu piedra de hogar una vez para registrarla."
L["Navigation Flight Data Missing"] =
"Rutas de vuelo aún no registradas. Habla con un maestro de vuelo para registrarlas."

------------------------------ Pins ------------------------------
L["Map Pin"] = "Marcador del mapa"
L["Add Pin"] = "Añadir marcador"
L["Target"] = "Objetivo"
L["Change Color"] = "Cambiar color"
L["Change Icon"] = "Cambiar icono"
L["Atlas"] = "Atlas"
L["Color"] = "Color"
L["Icon"] = "Icono"
L["Locked"] = "Bloqueado"
L["Map"] = "Mapa"
L["Name"] = "Nombre"
L["X"] = "X"
L["Y"] = "Y"
L["Show on Map"] = "Mostrar en el mapa"
L["Clear Pin"] = "Quitar marcador"
L["Delete Permanently"] = "Eliminar definitivamente"
L["Delete pin \"%s\"?"] = "¿Deseas eliminar el marcador «%s»?"
L["Share to Chat"] = "Compartir en el chat"
L["Failed to place pin on the map. Please check if the coordinates are correct!"] =
"No se ha podido colocar el marcador en el mapa. ¡Comprueba si las coordenadas son correctas!"
L["Can't Show on Map in Combat"] = "No se puede mostrar en el mapa estando en combate"
L["The world map cannot be opened automatically during combat. It will open after combat ends."] =
"El mapa del mundo no se puede abrir automáticamente estando en combate. Se abrirá una vez que éste haya finalizado."

------------------------------ Groups And Tracker ------------------------------
L["Group"] = "Grupo"
L["Hidden"] = "Oculto"
L["Show hidden group"] = "Mostrar grupo oculto"
L["No hidden groups"] = "No hay grupos ocultos"
L["Your pins (%d)"] = "Tus marcadores (%d)"
L["New Group %d"] = "Nuevo grupo %d"
L["Groups"] = "Grupos"
L["Create Group"] = "Crear grupo"
L["Select"] = "Seleccionar"
L["Select a group to start editing."] = "Selecciona un grupo para empezar a editarlo."
L["Show"] = "Mostrar"
L["Hide"] = "Ocultar"
L["Ungrouped Pins"] = "Marcadores sin agrupar"
L["My Way Back"] = "Camino de vuelta"
L["Import %d"] = "Importar %d"
L["%d |4pin:pins;"] = "%d |4marcador:marcadores;"
L["A group named \"%s\" already exists."] = "Ya existe un grupo llamado «%s»."
L["Rename Group"] = "Cambiar el nombre del grupo"
L["Add to New Group"] = "Añadir a un nuevo grupo"
L["Delete Group"] = "Eliminar grupo"
L["Clear Group"] = "Vaciar grupo"
L["Show Group"] = "Mostrar grupo"
L["Hide Group"] = "Ocultar grupo"
L["Restore Pins"] = "Restaurar marcadores"
L["Make pins restorable"] = "Hacer los marcadores recuperables"
L["Delete group \"%s\" and all of its pins?"] = "¿Deseas eliminar el grupo «%s» y todos sus marcadores?"
L["Clear all pins from \"%s\"?"] = "¿Borrar todos los marcadores de «%s»?"
L["Tracking Mode"] = "Modo de seguimiento"
L["Track by Distance"] = "Seguimiento por distancia"
L["Track by Order"] = "Seguimiento por orden"
L["Toggle the tracker visibility."] = "Activar o desactivar la visibilidad del rastreador."
L["Dungeon"] = "Mazmorra"
L["Raid"] = "Banda"
L["Scenario"] = "Escenario"
L["Battleground"] = "Campo de batalla"
L["Arena"] = "Arena"
L["None"] = "Ninguno"
L["No active pins"] = "No hay marcadores activos"
L["No coordinates available"] = "No hay coordenadas disponibles"
L["Miscellaneous.Coords.Visibility_LABEL"] = "Ocultar automáticamente"
L["Miscellaneous.Coords.Visibility_DESCRIPTION"] =
"Ocultar la visualización de coordenadas cuando esté activa cualquiera de las condiciones seleccionadas."
L["Miscellaneous.Tracker_GROUPLABEL"] = "Rastreador"
L["Miscellaneous.Tracker.Visibility_LABEL"] = "Ocultar automáticamente"
L["Miscellaneous.Tracker.Visibility_DESCRIPTION"] =
"Ocultar el rastreador cuando se cumpla cualquiera de las condiciones seleccionadas."
L["Toggle the group editor."] = "Activa o desactiva el editor de grupos."

------------------------------ Editor ------------------------------
L["Editor"] = "Editor"
L["Edit Group"] = "Editar grupo"
L["Search"] = "Buscar"
L["Rename Pin"] = "Cambiar el nombre del marcador"
L["Create a new pin group."] = "Crea un nuevo grupo de marcadores."
L["Choose an icon for this group."] = "Elige un icono para este grupo."
L["Delete this group and all of its pins. System groups are cleared instead."] =
"Elimina este grupo y todos sus marcadores. Los grupos del sistema se vacían en su lugar."
L["Hide or show this group."] = "Ocultar o mostrar este grupo."
L["Permanently delete this pin."] = "Elimina este marcador permanentemente."
L["Create a copy of this pin."] = "Crea una copia de este marcador."
L["copy of %s"] = "copia de %s"
L["Loading"] = "Cargando"

------------------------------ Dialogs ------------------------------
L["Version: %s (%s)"] = "Versión: %s (%s)"
L["Build: %s"] = "Versión: %s"
L["Special thanks to Byyrax and Pamoo for the help with translations"] =
"Un agradecimiento especial a Byyrax y Pamoo por su ayuda con las traducciones"
L["Thanks to Eminos for the countless hours creating textures, rubber-ducking and thinking about ideas with me. Thanks to all who helped me test new versions, gave feedback and reported bugs!"] =
"Gracias a Eminos por las incontables horas dedicadas a crear texturas, solución de fallos y creación de nuevas ideas. ¡Gracias a todos los que me ayudaron a probar nuevas versiones, aportaron comentarios e informaron de errores!"
L["Open the about dialog to view version information."] =
"Abre el cuadro de diálogo «Acerca de» para ver la información sobre la versión."

------------------------------ Transfer ------------------------------
L["Export"] = "Exportar"
L["Way commands"] = "Comandos \"/way\""
L["Serialized data"] = "Datos serializados"
L["Open the import dialog to import map pins from a string."] =
"Abre el cuadro de diálogo de importación para importar marcadores de mapa a partir de una cadena de caracteres."
L["You can import pins by pasting multiple slash commands or a Map Pin Enhanced export string (starting with %s)"] =
"Puedes importar marcadores pegando varios comandos de barra o una cadena de exportación de «Map Pin Enhanced» (que empiece por %s)."
L["Click to paste export string or slash commands here"] =
"Haz clic aquí para pegar cadenas de exportación o comandos "
L["Choose an export format, then copy the text below."] =
"Elige un formato de exportación y, a continuación, copia el texto que aparece a continuación."
L["Command prefix:"] = "Prefijo de comando:"
L["Exporting %d pins across %d maps"] = "Exportando %d |4marcador:marcadores; en %d |4mapa:mapas;"
L["%s: %d pins across %d maps"] = "%s: %d |4marcador:marcadores; en %d |4mapa:mapas;"
L["%d invalid entries will be skipped"] = "%d |4entrada no válida se omitirá:entradas no válidas se omitirán;"
L["Invalid or corrupted serialized data."] = "Datos serializados no válidos o dañados."
L["No valid pins were found to import."] = "No se han encontrado marcadores válidos para importar."
L["Importing %d pins; skipped %d invalid entries."] =
"Importando %d |4marcador:marcadores;; %d |4entrada no válida omitida:entradas no válidas omitidas;."
L["Import failed."] = "La importación ha fallado."
L["Warning: slash commands do not preserve descriptions, custom icons or colors. /mappin also omits pin titles."] =
"Advertencia: los comandos «/» no conservan las descripciones, los iconos personalizados ni los colores. El comando «/mappin» también omite los títulos de los marcadores."

------------------------------ Providers ------------------------------
L["%s added hidden group \"%s\"."] = "%s ha añadido el grupo oculto «%s»."
L["TomTom Pins"] = "Marcadores de TomTom"
L["TomTom Waypoint"] = "Punto de referencia de TomTom"
L["TomTom Is Loaded! You may experience some unexpected behavior."] =
"¡TomTom se ha cargado! Es posible que se produzcan algunos comportamientos inesperados."
L["\"%s\" reached at %s."] = "«%s» alcanzado en %s."
L["Location reached at %s."] = "Destino alcanzado en %s."
L["Equipped %s."] = "Equipado con %s."
L["Re-equipped %s."] = "%s equipado de nuevo."
L["Restored empty equipment slot."] = "Se ha restablecido la ranura de equipo vacía."
L["Could not restore %s."] = "No se ha podido restaurar %s."
L["Could not restore empty equipment slot."] = "No se ha podido restaurar una ranura de equipo vacía."
L["It is locked."] = "El marcador está bloqueado."
L["Turn in: %s"] = "Entregar: %s"
L["Corpse"] = "Cadáver"
L["Quest"] = "Misión"
L["Content"] = "Contenido"
L["Vignette"] = "Punto de interés"
L["House"] = "Casa"
L["%s's House"] = "La casa de %s"

------------------------------ Miscellaneous ------------------------------
L["Back"] = "Atrás"
L["Create a Pin at Your Current Location"] = "Crear un marcador en tu ubicación actual"
L["Unable to determine your current map location."] = "No se ha podido determinar tu ubicación actual en el mapa."
L["Unable to determine your current position on the map."] = "No se ha podido determinar tu posición actual en el mapa."
L["%s's Position"] = "Posición de %s"
L["You Are in an Instance or a Zone Where the Map Is Not Available"] =
"Te encuentras en una instancia o zona en la que el mapa no está disponible"
L["My Way Back is unavailable on the map you are on right now."] =
"«Mi camino de vuelta» no está disponible en el mapa actual."

------------------------------ Options ------------------------------
L["General"] = "General"
L["Pins"] = "Marcadores"
L["Miscellaneous"] = "Varios"
L["Wayfinder"] = "Indicador de dirección"
L["Search for option..."] = "Buscar una opción..."
L["Open the options frame"] = "Abre el cuadro de opciones"
L["Open options"] = "Abrir opciones"
L["Open editor"] = "Abrir el editor"

L["General.Minimap_GROUPLABEL"] = "Minimapa"
L["Clear all pins"] = "Quitar todos los marcadores"
L["Some pins are still being updated. Try clearing again when the current operation finishes."] =
"Algunos marcadores aún se están actualizando. Intenta borrar de nuevo cuando finalice la operación actual."
L["Hide minimap button"] = "Ocultar el botón del minimapa"
L["Toggle the minimap button visibility."] = "Activa o desactiva la visibilidad del botón del minimapa."
L["General.Minimap.ShowButton_LABEL"] = "Mostrar el botón del minimapa"
L["General.Minimap.ShowButton_DESCRIPTION"] = "Mostrar el botón del addon en el minimapa."
L["General.Minimap.CustomButton_LABEL"] = "Botón personalizado del minimapa"
L["General.Minimap.CustomButton_DESCRIPTION"] =
"Utiliza un logo más grande, sin el borde habitual de botón de minimapa"
L["General.Distance_GROUPLABEL"] = "Distancia"
L["General.Distance.ShowUnit_LABEL"] = "Mostrar unidad de distancia"
L["General.Distance.ShowUnit_DESCRIPTION"] = "Muestra la unidad de distancia junto a los valores de distancia."
L["General.Tracking_GROUPLABEL"] = "Seguimiento"
L["Reload UI"] = "Recargar interfaz"
L["This change requires a UI reload. Reload now?"] = "Este cambio requiere recargar la interfaz. ¿Recargar ahora?"

L["Pins.Miscellaneous_GROUPLABEL"] = "Varios"
L["Pins.Miscellaneous.ScaleOnHover_LABEL"] = "Ampliar marcadores al pasar el cursor"
L["Pins.Miscellaneous.ScaleOnHover_DESCRIPTION"] =
"Amplía los marcadores del mapa mundial al pasar el cursor por encima de ellos."

L["Miscellaneous.Coords_GROUPLABEL"] = "Visualización de coordenadas"
L["Miscellaneous.Coords.Enable_LABEL"] = "Activar la visualización de coordenadas"
L["Miscellaneous.Coords.Enable_DESCRIPTION"] =
"Activa o desactiva la visualización en pantalla de tus coordenadas actuales"
L["Miscellaneous.Coords.Lock_LABEL"] = "Bloquear la visualización de coordenadas"
L["Miscellaneous.Coords.Lock_DESCRIPTION"] =
"Activa o desactiva la posibilidad de mover la visualización de las coordenadas."

L["Wayfinder.General.HideBlizzardFloatingDiamond_LABEL"] = "Ocultar el rombo flotante de Blizzard"
L["Wayfinder.General.HideBlizzardFloatingDiamond_DESCRIPTION"] =
"Ocultar el rombo de navegación flotante de Blizzard cuando el indicador de ruta flotante «Map Pin Enhanced» esté desactivado."
L["Wayfinder.General.Selection_LABEL"] = "Indicador de dirección"
L["Wayfinder.General.Selection_DESCRIPTION"] = "Elige el único indicador de rumbo que se utilizará para la navegación."
L["Arrow"] = "Flecha"
L["Floating"] = "Flotante"
L["Wayfinder.Navigation_GROUPLABEL"] = "Navegación"
L["Wayfinder.Navigation.Enable_LABEL"] = "Activar la navegación de la ruta"
L["Wayfinder.Navigation.Enable_DESCRIPTION"] =
"Calcula las rutas de viaje utilizando los movimientos, portales, medios de transporte, hechizos, objetos y juguetes disponibles."
L["Wayfinder.Navigation.AutomaticTravelSelection_LABEL"] = "Selección automática del trayecto"
L["Wayfinder.Navigation.AutomaticTravelSelection_DESCRIPTION"] =
"Selecciona automáticamente las opciones de diálogo de los PNJ y los destinos de vuelo que requiere tu ruta actual. Mantén pulsada la tecla Mayús al abrir el mapa de vuelo para seleccionar un vuelo manualmente."
L["Wayfinder.Navigation.WorldMap_LABEL"] = "Mostrar la ruta en un mapa del mundo"
L["Wayfinder.Navigation.WorldMap_DESCRIPTION"] = "Mostrar la ruta calculada en el mapa del mundo."
L["Wayfinder.Navigation.Minimap_LABEL"] = "Mostrar ruta en el minimapa"
L["Wayfinder.Navigation.Minimap_DESCRIPTION"] = "Mostrar la ruta calculada en el minimapa."
L["Navigation Calculating"] = "Calculando la ruta..."
L["Navigation Direct Guidance"] = "No hay ninguna ruta disponible. Dirígete directamente al destino."
L["Navigation No Direction"] = "No hay indicaciones disponibles para este destino."
L["Navigation Step Waiting Combat"] =
"Es posible que este paso no esté actualizado. Se actualizará cuando termine el combate."
L["Navigation Action Shift Combat"] =
"Pulsa Mayús + clic izquierdo para utilizar la acción que se muestra durante el combate."
L["Navigation Action Unavailable Combat"] = "Esta acción estará disponible tras el combate."
L["Navigation Action Started"] = "A la espera de la confirmación de llegada."
L["Navigation Action Failed"] = "La acción no se ha completado. Inténtalo de nuevo o vuelve a calcular la ruta."
L["Navigation Finding Another Route"] = "Buscando otra ruta..."
L["Navigation Arrival Confirming"] = "Confirmando la llegada..."
L["Navigation Walk"] = "Dirígete al siguiente punto."
L["Navigation Fly"] = "Vuela hasta el siguiente punto."
L["Navigation Travel To Destination"] = "Viaja a %s."
L["Navigation Fly To Destination"] = "Vuela a %s."
L["Navigation Route To"] = "Ruta hacia: %s (%s)"
L["Navigation Chat Header"] = "Ruta hacia: %s (%s) — %s"
L["Navigation Chat Unavailable"] =
"Selecciona un canal de chat disponible o un destinatario de susurro antes de exportar la ruta."
L["Send"] = "Enviar"
L["Navigation Chat Choose Channel"] = "Elige a dónde enviar esta ruta:"
L["Navigation Chat Whisper To"] = "Susurrar a"
L["Navigation Chat Player Name"] = "Nombre del jugador o Nombre-Reino"
L["Navigation Chat Route Changed"] = "La ruta ha cambiado. Cierra este cuadro de diálogo y vuelve a exportarlo."
L["Party"] = "Grupo"
L["Say"] = "Decir"
L["Whisper"] = "Susurrar"
L["Navigation Step Number"] = "Paso %d: %s"
L["Navigation Cross Border"] = "Pasa a la siguiente zona."
L["Navigation Change Floor"] = "Ve a la planta indicada."
L["Navigation Talk To NPC"] = "Habla con el PNJ indicado."
L["Navigation Method Travel"] = "Viajes"
L["Navigation Method Walking"] = "A pie"
L["Navigation Method Flying"] = "Vuelo"
L["Navigation Method Portal"] = "Portal"
L["Navigation Method NPC Travel"] = "Viaje mediante PNJ"
L["Navigation Method Border"] = "Cruce de frontera"
L["Navigation Method Floor Change"] = "Cambio de planta"
L["Navigation Method Spell"] = "Hechizo"
L["Navigation Method Item"] = "Objeto"
L["Navigation Method Toy"] = "Juguete"
L["Navigation Method Boat"] = "Barco"
L["Navigation Method Hearthstone"] = "Piedra de hogar"
L["Navigation Method Flight Taxi"] = "Maestro de vuelo"
L["Navigation Method Phase Change"] = "Cambio de fase"
L["Navigation Method Ship"] = "Barco"
L["Navigation Method Tram"] = "Tranvía"
L["Navigation Method Transport"] = "Transporte"
L["Navigation Method Teleport"] = "Teletransporte"
L["Navigation Method Zeppelin"] = "Zeppelin"
L["Navigation Use Spell"] = "Utiliza el hechizo necesario."
L["Navigation Use Item"] = "Usa el objeto necesario."
L["Navigation Use Toy"] = "Utiliza el juguete necesario."
L["Navigation Use Hearthstone"] = "Usa tu piedra de hogar."
L["Navigation Use Teleport"] = "Utiliza el teletransporte indicado."
L["Navigation Take Portal"] = "Entra por el portal."
L["Navigation Take Portal To"] = "Atraviesa el portal hacia %s."
L["Navigation Take Portal From To"] = "Atraviesa el portal de %s a %s."
L["Navigation Cross Border To"] = "Entra en %s."
L["Navigation Change Floor To"] = "Cambia de planta para llegar a %s."
L["Navigation Talk To NPC To"] = "Habla con el PNJ indicado para llegar a %s."
L["Navigation Cast Named Spell"] = "Lanza %s."
L["Navigation Cast Named Spell To"] = "Lanza %s para teletransportarte a %s."
L["Navigation Cast Named Spell Return"] = "Lanza %s para volver a %s."
L["Navigation Use Toy And Select"] = "Utiliza %s, luego interactúa y selecciona %s."
L["Navigation Select Toy Destination"] = "Interactúa con el juguete y selecciona %s."
L["Navigation Use Named Item"] = "Utiliza %s."
L["Navigation Use Named Item To"] = "Utiliza %s para viajar a %s."
L["Navigation Use Named Item Return"] = "Utiliza %s para volver a %s."
L["Navigation Use Spell To"] = "Utiliza el hechizo necesario para teletransportarte a %s."
L["Navigation Use Teleport To"] = "Utiliza el teletransporte indicado para llegar a %s."
L["Navigation Use Item To"] = "Utiliza el objeto necesario para viajar a %s."
L["Navigation Use Toy To"] = "Utiliza el juguete necesario para viajar a %s."
L["Navigation Use Hearthstone To"] = "Usa tu piedra de hogar para volver a %s."
L["Navigation Take Boat"] = "Toma el barco."
L["Navigation Take Boat To"] = "Toma el barco hasta %s."
L["Navigation Traveling By Boat"] = "Viajando en barco."
L["Navigation Traveling By Boat To"] = "Viajando en barco a %s."
L["Navigation Take Ship"] = "Toma el barco."
L["Navigation Take Ship To"] = "Ve en barco a %s."
L["Navigation Traveling By Ship"] = "Navegando."
L["Navigation Traveling By Ship To"] = "Navegando a %s."
L["Navigation Take Zeppelin"] = "Toma el zepelín."
L["Navigation Take Zeppelin To"] = "Ve en el zepelín hasta %s."
L["Navigation Traveling By Zeppelin"] = "Viajando en zepelín."
L["Navigation Traveling By Zeppelin To"] = "Viajando en zepelín a %s."
L["Navigation Take Tram"] = "Toma el tranvía."
L["Navigation Take Tram To"] = "Toma el tranvía hasta %s."
L["Navigation Traveling By Tram"] = "Viajando en tranvía."
L["Navigation Traveling By Tram To"] = "Viajando en tranvía a %s."
L["Navigation Take Transport"] = "Usa el teletransporte."
L["Navigation Take Transport To"] = "Usa el teletransporte hacia %s."
L["Navigation Traveling By Transport"] = "Viajando en teletransporte."
L["Navigation Traveling By Transport To"] = "Viajando en teletransporte hacia %s."
L["Navigation Take Flight To"] = "Toma el vuelo a %s."
L["Navigation Take Flight"] = "Toma el vuelo."
L["Navigation Traveling By Flight"] = "Volando."
L["Navigation Traveling By Flight To"] = "Volando hacia %s."
L["Recalculate Route"] = "Volver a calcular la ruta"
L["%s - %s"] = "%s - %s"
L["System Groups"] = "Grupos del sistema"
L["System groups are managed by Map Pin Enhanced for special features. Their core settings cannot be changed."] =
"Los grupos del sistema se gestionan mediante Map Pin Enhanced para funciones especiales. No es posible modificar su configuración base."


L["Report"] = "Informe"
L["Report a navigation problem"] = "Informar de un problema de navegación"
L["Help improve navigation"] = "Ayúdanos a mejorar la navegación"
L["Describe the problem, then copy the report below and post it on either issue page. Copy a URL into your browser to get started."] =
"Describe el problema y, a continuación, copia el informe que aparece a continuación y publícalo en cualquiera de las páginas de incidencias. Pega la URL en tu navegador para empezar."
L["What went wrong?"] = "¿Qué ha salido mal?"
L["What happened, what did you expect, and how can we reproduce it?"] =
"¿Qué ha pasado, qué esperabas y cómo podemos reproducirlo?"
L["Your report (description and debug data)"] = "Tu informe (descripción y datos de depuración)"
L["Click the report or a URL to select it, then press Ctrl+C to copy."] =
"Haz clic en el informe o en una URL para seleccionarlo y, a continuación, pulsa Ctrl+C para copiarlo."
L["Navigation Debug Dump"] = "Volcado de depuración de navegación"


L["Description"] = "Descripción"
L["Edit Description"] = "Editar descripción"
L["Add notes for this pin. Descriptions appear in pin tooltips and below the wayfinder title."] =
"Añade notas a este marcador. Las descripciones aparecen en las descripciones emergentes de los marcadores y debajo del título del indicador de ruta."
L["This pin is no longer in this group."] = "Este marcador ya no está en este grupo."
L["Apply"] = "Aplicar"

L["Wayfinder.Floating.ScaleWithDistance_LABEL"] = "Escalar en función de la distancia"
L["Wayfinder.Floating.ScaleWithDistance_DESCRIPTION"] =
"El marcador flotante y el haz crecen del 75% al 100% a medida que te acercas. Los intervalos de distancia dependen de la habilidad de equitación o vuelo aprendida al cargar el complemento y permanecen fijos hasta recargar."
L["Wayfinder.Floating.ShowBeam_LABEL"] = "Mostrar haz"
L["Wayfinder.Floating.ShowBeam_DESCRIPTION"] = "Muestra un haz sobre el marcador flotante cuando esté en pantalla."
L["Wayfinder.Floating.ShowTextOutline_LABEL"] = "Mostrar contorno del texto"
L["Wayfinder.Floating.ShowTextOutline_DESCRIPTION"] =
"Añade un contorno al texto de distancia, tiempo estimado de llegada y título del marcador flotante, que aparece al mostrarse o al pasar el cursor."
L["Wayfinder.General.ShowETA_LABEL"] = "Mostrar la hora estimada de llegada"
L["Wayfinder.General.ShowObjectiveFrame_LABEL"] = "Mostrar el recuadro del objetivo de la misión"
L["Wayfinder.General.ShowObjectiveFrame_DESCRIPTION"] =
"Muestra los objetivos de misión al entrar en su zona. Si se desactiva, se oculta el indicador flotante y la flecha mantiene su estado de proximidad."
L["Wayfinder.General.ShowETA_DESCRIPTION"] =
"Mostrar la estimación del tiempo de desplazamiento hasta el destino actual junto con la distancia, cuando esté disponible."
L["Wayfinder.Navigation.TransportationGroups_LABEL"] = "Transporte"
L["Wayfinder.Navigation.TransportationGroups_DESCRIPTION"] =
"Elige entre las opciones de transporte que te sugiere el sistema de navegación. El transporte regular incluye barcos, zepelines y tranvías. Los teletransportes personales incluyen hechizos de viaje, objetos, juguetes y la Piedra de hogar de Dalaran."
L["Navigation Transportation Portals"] = "Portales"
L["Navigation Transportation Flight paths"] = "Rutas de vuelo"
L["Navigation Transportation Scheduled transport"] = "Transporte regular"
L["Navigation Transportation NPC travel"] = "Viaje mediante PNJ"
L["Navigation Transportation Phase changes"] = "Cambios de fase"
L["Navigation Transportation Personal teleports"] = "Teletransportes personales"
L["Navigation Transportation Dungeon teleports"] = "Teletransportes en mazmorras"

L["Wayfinder.Display_GROUPLABEL"] = "Pantalla"
L["Settings for Floating; Arrow is still selected."] = "Configuración de «Flotante»; la flecha sigue seleccionada."
L["Settings for Arrow; Floating is still selected."] = "Configuración de «Flecha»; «Flotante» sigue seleccionado."

L["Clear Tracking"] = "Limpiar el seguimiento."
L["In objective area"] = "En el área del objetivo."
L["Why do I see this navigation element?"] = "¿Por qué veo este elemento de navegación?"
L["Wayfinder.Floating.Fallback_DESCRIPTION"] =
"La interfaz de usuario de Blizzard no puede proporcionar una posición en el mundo válida para este objetivo en esta zona. Esta flecha solo se utiliza de forma temporal y desaparecerá en cuanto haya información válida del juego disponible."

L["Group sharing timed out. The sender must be online and the link must still be available."] =
"Se ha agotado el tiempo de espera para compartir en grupo. El remitente debe estar conectado y el enlace debe seguir estando disponible."
L["Requesting shared group..."] = "Solicitando un grupo compartido..."
L["Receiving shared group..."] = "Recibiendo grupo compartido..."
L["Shared group \"%s\" received."] = "Se ha recibido el grupo compartido «%s»."
L["This shared group is no longer available. Ask the sender for a new link."] =
"Este grupo compartido ya no está disponible. Pide al remitente que te envíe un nuevo enlace."

L["Pin operation stopped after %d of %d pins. Completed changes were kept."] =
"La operación de marcadores se detuvo tras %d de %d marcadores. Se han conservado los cambios realizados."

-- Category options (0041).
L["Miscellaneous.Coords.ShowZone_LABEL"] = "Mostrar zona"
L["Miscellaneous.Coords.ShowZone_DESCRIPTION"] = "Indica el nombre completo del mapa entre tus coordenadas X e Y."
L["Miscellaneous.Coords.ShowDecimals_LABEL"] = "Mostrar decimales"
L["Miscellaneous.Coords.ShowDecimals_DESCRIPTION"] =
"Mostrar dos decimales. Desactivar esta opción para mostrar coordenadas enteras truncadas."
L["Pins.Appearance.AlwaysPingTracked_LABEL"] = "Hacer ping siempre el marcador en seguimiento"
L["Pins.Appearance.AlwaysPingTracked_DESCRIPTION"] =
"Haz que el marcador del mapa del mundo en seguimiento haga ping cada dos segundos mientras esté visible."
L["Pins.Appearance.MinimapScale_LABEL"] = "Tamaño de los marcadores del minimapa"
L["Pins.Appearance.MinimapScale_DESCRIPTION"] = "Elige el tamaño de los marcadores habituales del minimapa."
L["Pins.Appearance.WorldMapScale_LABEL"] = "Tamaño de los marcadores del mapa mundial"
L["Pins.Appearance.WorldMapScale_DESCRIPTION"] =
"Elige el tamaño de los marcadores normales del mapa del mundo. La ampliación al pasar el cursor se aplica adicionalmente."
L["Pins.Appearance.DefaultColor_LABEL"] = "Color predeterminado del marcador"
L["Pins.Appearance.DefaultColor_DESCRIPTION"] =
"Color para los nuevos marcadores que no tengan un icono o un color específicos. Los marcadores existentes e importados conservan su aspecto."
L["Pins.Appearance.FadeUntracked_LABEL"] = "Atenuar marcadores que no están en seguimiento"
L["Pins.Appearance.FadeUntracked_DESCRIPTION"] =
"Atenúa los marcadores del mapa no rastreados al 40 % de opacidad. Al pasar el cursor por encima, se recupera la opacidad total."
L["Pins.Appearance.ShowMinimapPins_LABEL"] = "Mostrar marcadores en el minimapa"
L["Pins.Appearance.ShowMinimapPins_DESCRIPTION"] =
"Mostrar los marcadores normales de los Addons en el minimapa. Los marcadores del minimapa requieren actualizaciones de posición; los marcadores de orientación y de ruta siguen siendo independientes."
L["Pins.Miscellaneous.EnableLockedPins_LABEL"] = "Habilitar marcadores bloqueados"
L["Pins.Miscellaneous.EnableLockedPins_DESCRIPTION"] =
"Permitir nuevos bloqueos. Los marcadores bloqueados permanecen así hasta que los elimines; los marcadores existentes siempre se pueden desbloquear."
L["Pins.Tracking.ArrivalNotification_LABEL"] = "Notificación al alcanzar el marcador"
L["Pins.Tracking.ArrivalNotification_DESCRIPTION"] =
"Notificar una vez por sesión de seguimiento cuando se llegue físicamente al destino final del complemento."
L["Pins.Tracking.AutoUntrack_LABEL"] = "Dejar de seguir automáticamente"
L["Pins.Tracking.AutoUntrack_DESCRIPTION"] =
"Borra el seguimiento del complemento y de Blizzard al entrar en una mazmorra, banda, escenario, campo de batalla o arena."
L["Miscellaneous.Tracker.AutoShow_LABEL"] = "Mostrar automáticamente al crear un marcador"
L["Miscellaneous.Tracker.AutoShow_DESCRIPTION"] =
"Muestra y expande el rastreador tras crear un marcador o confirmar una importación. Seguir un elemento de Blizzard no activa esta función. Las reglas de ocultación automática siguen vigentes."
L["Miscellaneous.Tracker.CloseAction_LABEL"] = "Minimizar el rastreador en lugar de cerrarlo"
L["Miscellaneous.Tracker.CloseAction_DESCRIPTION"] =
"Al minimizar el rastreador, mantén visible únicamente el encabezado."
L["Miscellaneous.Tracker.ShowCoordinates_LABEL"] = "Mostrar coordenadas"
L["Miscellaneous.Tracker.ShowCoordinates_DESCRIPTION"] =
"Mostrar las coordenadas junto al nombre de la zona en las entradas de los marcadores del rastreador."
L["Miscellaneous.Tracker.MaximumRows_LABEL"] = "Número máximo de filas visibles"
L["Miscellaneous.Tracker.MaximumRows_DESCRIPTION"] =
"Número máximo de filas de grupos y marcadores antes del desplazamiento, sin contar la cabecera."
L["Miscellaneous.Tracker.BackgroundOpacity_LABEL"] = "Opacidad del fondo del rastreador"
L["Miscellaneous.Tracker.BackgroundOpacity_DESCRIPTION"] = "Opacidad detrás de la lista de marcadores, del 0 % al 100 %."
L["Miscellaneous.Tracker.Scale_LABEL"] = "Tamaño del rastreador"
L["Miscellaneous.Tracker.Scale_DESCRIPTION"] = "Elige el tamaño del rastreador."
L["Pins.Appearance_GROUPLABEL"] = "Aspecto"
L["Pins.Tracking_GROUPLABEL"] = "Seguimiento"
L["Coordinates"] = "Coordenadas"
L["Tracker"] = "Rastreador"
L["Small (90%)"] = "Pequeño (90 %)"
L["Default (100%)"] = "Por defecto (100 %)"
L["Large (125%)"] = "Grande (125 %)"
L["Huge (150%)"] = "Enorme (150 %)"
L["Red"] = "Rojo"
L["Orange"] = "Naranja"
L["Pale"] = "Pálido"
L["Yellow"] = "Amarillo"
L["Green"] = "Verde"
L["LightBlue"] = "Azul claro"
L["DarkBlue"] = "Azul oscuro"
L["Purple"] = "Morado"
L["Pink"] = "Rosa"
L["Only locked pins"] = "Solo marcadores bloqueados"
L["All pins"] = "Todos los marcadores"
L["Disabled"] = "Desactivado"
L["Minimize"] = "Minimizar"
L["Expand"] = "Ampliar"
L["Lock Pin"] = "Bloquear marcador"
L["Unlock Pin"] = "Desbloquear marcador"

------------------------------ Legacy migration ------------------------------
L["Legacy migration could not update groups. Original saved data was kept."] =
"La migración del sistema heredado no ha podido actualizar los grupos. Se han conservado los datos guardados originalmente."
L["Migrated %d legacy pins and %d saved sets. Original saved data was kept."] =
"Se han migrado %d marcadores heredados y %d conjuntos guardados. Se han conservado los datos guardados originales."
L["%d legacy entries could not be migrated. Original saved data was kept."] =
"No se han podido migrar %d entradas antiguas. Se han conservado los datos originales guardados."

L["Wayfinder.Navigation.RestoreEquipment_LABEL"] = "Restaurar equipo tras el viaje"
L["Wayfinder.Navigation.RestoreEquipment_DESCRIPTION"] =
"Restaurar el equipo sustituido por elementos de navegación y mostrar las notificaciones sobre el equipo. Aunque se desactive esta opción, el equipo que ya haya sido sustituido se seguirá restaurando."

L["Clear"] = "Borrar"
L["Options"] = "Opciones"
L["Minimap"] = "Minimapa"
L["Help"] = "Ayuda"
L["Clear all active pins in visible groups."] = "Borrar todos los marcadores activos de los grupos visibles."

-- Startup introduction
L["Example pin"] = "Marcador de ejemplo"
L["Introduction"] = "Introducción"
L["Step %d of %d"] = "Paso %d de %d"
L["Reset the startup introduction."] = "Restablecer la introducción de inicio."
L["This introduction covers some of the addon's core settings. You can change all of these choices later in settings."] =
"En esta introducción se explican algunos de los ajustes principales del complemento. Puedes modificar todas estas opciones más adelante en el menú de ajustes."
L["Floating shows a diamond in the world at your target. Arrow uses a simple pointer to show the direction."] =
"La opción «Flotante» muestra un rombo en el mundo, en el punto que elijas. La opción «Flecha» utiliza un sencillo puntero para indicar la dirección."
L["Navigation shows the best available route to your target location."] =
"La navegación muestra la mejor ruta disponible hasta tu destino."
L["Hold Ctrl and click the world map to place a pin. The button below creates a test pin near your character and finishes the introduction."] =
"Mantén pulsada la tecla Ctrl y haz clic en el mapa del mundo para colocar un marcador. El botón de abajo crea un marcador de prueba cerca de tu personaje y da por terminada la introducción."
L["Let's go!"] = "¡Vamos!"
L["Finish"] = "Finalizar"
L["Next"] = "Siguiente"
L["Place test pin and finish"] = "Colocar marcador de prueba y finalizar"
L["Welcome to Map Pin Enhanced!"] = "¡Bienvenido a Map Pin Enhanced!"
L["Select a wayfinder"] = "Selecciona un indicador de dirección"
L["Enable navigation"] = "Activar la navegación"
L["Place your first pin"] = "Coloca tu primer marcador"

------------------------------ Tooltip helper ------------------------------
L["Click"] = "Haz clic"
L["Alt + Click"] = "Alt + clic"
L["Left Click"] = "Clic con el botón izquierdo"
L["Right Click"] = "Clic con el botón derecho"
L["Middle Click"] = "Clic con el botón central"
L["Ctrl + Left Click"] = "Ctrl + clic con el botón izquierdo"
L["Shift + Left Click"] = "Mayús + clic con el botón izquierdo"
L["Alt + Left Click"] = "Alt + clic con el botón izquierdo"
L["Open menu"] = "Abrir menú"
L["Collapse"] = "Contraer"
L["Clear without confirmation"] = "Borrar sin confirmar"
L["Delete without confirmation"] = "Eliminar sin confirmación"
L["Change pin appearance"] = "Cambiar aspecto del marcador"
L["General.TooltipHelper_LABEL"] = "Activar la ayuda de las descripciones emergentes"
L["General.TooltipHelper_DESCRIPTION"] =
"Mostrar las acciones disponibles al hacer clic en las descripciones emergentes."

L["Common options"] = "Opciones habituales"
L["Choose which helpers you want to enable. You can change these choices later in settings."] =
"Elige qué funciones de ayuda quieres activar. Puedes modificar estas opciones más adelante en la configuración."

--@debug@
L["Profiler"] = "Analizador de rendimiento"
L["Profiler: restore"] = "Analizador de rendimiento: restaurar"
L["Profiler: recording - restore"] = "Analizador de rendimiento: grabación - restaurar"
L["Modules"] = "Módulos"
L["Modules: %d"] = "Módulos: %d"
L["All modules"] = "Todos los módulos"
L["Start"] = "Iniciar"
L["Stop"] = "Detener"
L["Reset"] = "Restablecer"
L["Recording. Closing this window stops capture."] = "Grabación. Al cerrar esta ventana se detiene la captura."
L["Capture stopped: %.2f seconds. Export to inspect results."] =
"Captura detenida: %.2f segundos. Exporta para revisar los resultados."
L["Select modules, then start a new capture."] = "Selecciona los módulos y, a continuación, inicia una nueva captura."
L["Open the profiler."] = "Abre el analizador de rendimiento."
--@end-debug@

L["General.FlightTimer.Enable_LABEL"] = "Activar el temporizador de vuelo"
L["General.FlightTimer.Enable_DESCRIPTION"] =
"Muestra una barra de progreso que se puede mover y el tiempo restante estimado durante los viajes con maestros de vuelo."
L["General.FlightTimer.Lock_LABEL"] = "Bloquear el temporizador de vuelo"
L["General.FlightTimer.Lock_DESCRIPTION"] = "Evita que se mueva el temporizador de vuelo."
L["General.FlightTimer.Scale_LABEL"] = "Tamaño del cronómetro de vuelo"
L["General.FlightTimer.Scale_DESCRIPTION"] = "Elige el tamaño del temporizador de vuelo."
L["Flight Timer"] = "Temporizador de vuelo"
L["Flight elapsed: %s"] = "Tiempo transcurrido: %s"
L["Flight remaining: %s"] = "%s restantes"

L["Mode: baseline"] = "Modo: básico"
L["Mode: detailed"] = "Modo: detallado"

L["Baseline measures whole-addon engine time. Detailed adds function scopes and preparation phases. Both include percentage impact and a timeline. Compare matching gameplay; profiling adds overhead and detailed times overlap."] =
"El modo básico mide el tiempo de procesamiento total del complemento. El detallado añade funciones individuales y fases de preparación. Ambos incluyen el impacto porcentual y una línea temporal. Compara situaciones de juego similares: el análisis añade carga y los tiempos detallados se solapan."

L["Share location"] = "Compartir ubicación"
L["Place a pin here"] = "Pon un marcador aquí"
L["Enter the Wizard's Sanctum."] = "Entra en el Sagrario del Mago."
