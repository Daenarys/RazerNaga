
local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga', 'esMX')
if not L then return end

--system messages
L.Updated = 'Actualizado de v%s'

--profiles
L.ProfileCreated = 'Nuevo perfil "%s" creado'
L.ProfileLoaded = 'Configurar perfil en "%s"'
L.ProfileDeleted = 'Perfil "%s" eliminado'
L.ProfileCopied = 'Configuraciones copiadas desde "%s"'
L.ProfileReset = 'Restablecer perfil "%s"'
L.CantDeleteCurrentProfile = 'No se puede eliminar el perfil actual'
L.InvalidProfile = 'Perfil "%s" no válido'

--slash command help
L.ConfigDesc = 'Alterna el modo de configuración'

L.SetScaleDesc = 'Ajusta la escala de <frameList>'
L.SetAlphaDesc = 'Ajusta la opacidad de <frameList>'
L.SetFadeDesc = 'Ajusta la opacidad desvanecida de <frameList>'

L.SetColsDesc = 'Ajusta la cantidad de columnas por <frameList>'
L.SetPadDesc = 'Ajusta el nivel de padding para <frameList>'
L.SetSpacingDesc = 'Ajusta el nivel de espaciado para <frameList>'

L.ShowFramesDesc = 'Muestra la <frameList> dada'
L.HideFramesDesc = 'Oculta la <frameList> dada'
L.ToggleFramesDesc = 'Alterna la <frameList> dada'

--slash commands for profiles
L.SetDesc = 'Cambia las configuraciones a <profile>'
L.SaveDesc = 'Guarda las configuraciones actuales y cambia a <profile>'
L.CopyDesc = 'Copia las configuraciones desde <profile>'
L.DeleteDesc = 'Elimina el <profile>'
L.ResetDesc = 'Regresa a las configuraciones predeterminadas'
L.ListDesc = 'Enumera todos los perfiles'
L.AvailableProfiles = 'Perfiles disponibles'
L.PrintVersionDesc = 'Imprime la versión actual'

--dragFrame tooltips
L.ShowConfig = '<Haz clic derecho> para configurar'
L.HideBar = '<Haz clic con el botón del medio o derecho> para ocultar'
L.ShowBar = '<Haz clic con el botón del medio o derecho> para mostrar'
L.SetAlpha = '<Utiliza la ruedecilla del mouse> para ajustar la opacidad (|cffffffff%d|r)'

--minimap button stuff
L.ConfigEnterTip = '<Haz clic izquierdo> para ingresar al modo de configuración'
L.ConfigExitTip = '<Haz clic izquierdo> para salir del modo de configuración'
L.BindingEnterTip = '<Pulsa Shift + clic izquierdo> para ingresar al modo de unión manual'
L.BindingExitTip = '<Pulsa Shift + clic izquierdo> para salir del modo de unión manual'
L.ShowOptionsTip = '<Haz clic con el botón derecho> para mostrar el menú de opciones'

--helper dialog stuff
L.ConfigMode = 'Modo de configuración'
L.ConfigModeHelp = '<Arrastra> cualquier barra para moverla.'

--lynn localization items
L.EnableAutomaticBindings = 'Utilizar siempre los botones de Razer Naga'
L.BindingSet = 'Interruptor 123/Num'
L.Simple = '123'
L.Advanced = 'Num'
L.EnforcingBindings = 'Configurando uniones de teclas para el diseño %s – teclas %s'
--L.AcceptBindingChangesPrompt ='¿Desea aceptar los cambios de unión?'
L.CannotAlterBindingsInCombat = 'No se puede alterar las uniones durante el combate'
L.EnableAutoBindingsPrompt = [[
Razer Naga puede asegurar que los botones del teclado están configurados para las barras de acción y mascotas, pero si activas esta función, puedes afectar las uniones de las teclas actuales.

¿Deseas activar esta función en este momento? Si no deseas activarla ahora, puedes hacerlo después desde el menú de configuración.]]
L.BindKeysManuallyPrompt = '¿Deseas dejar de utilizar solamente los botones de Razer Naga y configurar manualmente las teclas?'

--lynn tooltips
L.SwitchTo4x3 = 'Reacomoda las barras de acción y mascotas con un diseño de 4x3.'
L.SwitchTo3x4 = 'Reacomoda las barras de acción y mascotas con un diseño de 3x4.'
L.AutomaticBindingsToggle = 'Marca esta casilla para asegurarte de que los botones de Razer Naga estén siempre unidos a las barras de acción y mascotas.'
L.ConfigModeExit = 'Haz clic aquí para salir del modo de configuración.'
L.ConfigModeShowOptions = 'Haga clic aquí para salir del modo de configuración y visualizar el menú de opciones.'
L.ConfigModeSwitchToBindingMode = 'Haz clic aquí dejar de utilizar solamente los botones de Razer Naga y configurar manualmente las uniones de las teclas.'
L.BindingSetHelp = 'Se debe ajustar esta configuración para que el interruptor coincida con el ratón.\n\nDetermina qué teclas están unidas cuando marcas "Utilizar siempre los botones de Razer Naga".\n\n"123" significa que las teclas 1,2,3,4,5,6,7,8,9,-,= están unidas.\n\n"Núm" significa que Núm1, Núm2, Núm3, Núm4, Núm5, Núm6, Núm7, Núm8, Núm9, Núm0, Núm-, Núm+ están unidas.\n\nLas teclas del modificador se ajustarán según lo determinen tus configuraciones.'
L.SimpleBindingHelp = 'Teclas 1, 2, 3, 4, 5, 6, 7, 8, 9, -, ='
L.AvancedBindingSetHelp = 'Teclas Núm1, Núm2, Núm3, Núm4, Núm5, Núm6, Núm7, Núm8, Núm9, Núm0, Núm-, Núm+'

--bar tooltips
L.PetBarHelp = 'Muestra las acciones de las mascotas, cuando estás en control de una mascota.'

L.ClassBarHelp_DRUID = 'Muestra todos los cambios de formas de los druidas aprendidos.'
L.ClassBarHelp_ROGUE = 'Muestra el sigilo del Pícaro si está disponible.'
L.ClassBarHelp_PALADIN = 'Muestra las auras disponibles de los Paladines.'
L.ClassBarHelp_WARRIOR = 'Muestra las posturas disponibles de los Guerreros.'
L.ClassBarHelp_PRIEST = 'Muestra el Sacerdote de las sombras si está disponible.'
L.ClassBarHelp_WARLOCK = 'Muestra el Brujo Metamorfosis si está disponible.'
L.ClassBarHelp_DEATHKNIGHT = 'Muestra las presencias de Caballeros de la muerte disponibles.'
L.ClassBarHelp_HUNTER = 'Muestra los aspectos disponibles del cazador.'

L.CastBarHelp = 'Muestra una barra de progreso cuando diriges un hechizo[\n]o ejecutas una habilidad de comercio.'
L.RollBarHelp = 'Muestra los elementos para seguir tirando los dados cuando estás en un grupo.'
L.VehicleBarHelp = 'Muestra los botones de lanzamiento hacia arriba, lanzamiento hacia abajo en el vehículo y de salida. Los elementos que se muestran dependen del tipo de vehículo que tengas. Todas las demás acciones para el vehículo se muestran en la barra de posesiones.'
L.ExtraBarHelp = 'Muestra acciones especificas para combates y ataques determinados.'

--hover menu tooltips
L.ConfigureBarHelp = 'Configurar esta barra.'
L.ToggleVisibilityHelpHide = 'Ocultar esta barra.'
L.ToggleVisibilityHelpShow = 'Mostrar esta barra.'

--binding set modifiers
L.AltKey = 'ALT'

--incompatible addon prompt
L.IncompatibleAddonLoaded = 'Razer Naga no pudo cargar adecuadamente porque está cargado %s, que no es compatible con Razer Naga. Desactive los complementos de la barra de acción que estés ejecutando para cargar Razer Naga.'
