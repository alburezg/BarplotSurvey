# Prepare

# Load data
load(url("https://github.com/javob/BarplotSurvey/raw/master/data/SurveyData.RData"))

# Define question titles 
dataVars       = names(lapop[,8:22])
dataQuestions  = c("¿Dónde se encontraría usted en esta escala (ideológica)?",
                    "En su opinión ¿cuál es el problema más grave que está enfrentando el país?",
                    "El Estado guatemalteco, en lugar del sector privado, debería ser el dueño de las empresas e industrias más importantes del país. ¿Hasta qué punto está de acuerdo o en desacuerdo con esta frase?",
                    "El Estado guatemalteco debe implementar políticas firmes para reducir la desigualdad de ingresos entre ricos y pobres. ¿Hasta qué punto está de acuerdo o en desacuerdo con esta frase?",
                    "Para reducir la criminalidad en un país como el nuestro hay que aumentar los castigos a los delincuentes. ¿Hasta qué punto está de acuerdo o en desacuerdo con esta frase?",
                    "Pensando en los políticos de Guatemala, ¿cuántos de ellos cree usted que están involucrados en corrupción?",
                    "¿Usted está a favor o en contra de la pena de muerte para personas culpables de asesinato?",
                    "¿Estaría dispuesto(a) a pagar más impuestos de los que actualmente paga para que el gobierno pueda gastar más en educación primaria y secundaria?",
                    "¿Estaría dispuesto(a) a pagar más impuestos de los que actualmente paga para que el gobierno pueda gastar más en el servicio público de salud?",
                    "¿La influencia que Estados Unidos tiene en nuestro país es muy positiva, positiva, negativa, o muy negativa?",
                    "¿En qué medida cree usted que las reformas a la Ley Electoral y de Partidos Políticos mejoran el proceso electoral?",
                    "¿En qué medida cree usted que las reformas constitucionales al sector justicia mejorarán el sistema judicial?",
                    "¿Cree usted que se debe incluir el sistema de justicia indígena en la Constitución de Guatemala?",
                    "¿Quién cree que es el culpable de la mayoría de la violencia que ocurrió durante el conflicto armado, el Ejército o la guerrilla, o los dos igualmente?",
                    "En su opinión, ¿cree que Ríos Montt debería ser condenado por genocidio en contra de los Ixiles?")
dataQuestions2 = sapply(dataQuestions, function(x) paste(strwrap(x, 50), collapse = "\n"))
names(dataQuestions2) = NULL
dataQuestions3 = paste(c(1:length(dataQuestions)), dataQuestions, sep = ". ")

# Demographic subsets
lapop$q2  = cut(lapop$q2, breaks = c(0,25,35,47,91), 
                labels = c("De 18 a 25","De 26 a 35","De 36 a 47","De 48 a 91"))

# Reduced top priority list
lapop$prioridadTop <- as.character(lapop$prioridad)
lapop$prioridadTop[!(lapop$prioridadTop %in% levels(lapop$prioridad)[21:33])] <- "Otro"
prioridadTopLevels <- names(table(lapop$prioridadTop)[order(table(lapop$prioridadTop))])
lapop$prioridadTop <- factor(lapop$prioridadTop, levels = prioridadTopLevels)
dataVars[dataVars == "prioridad"] <- "prioridadTop"
