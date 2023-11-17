# TesiAlmaMap

# Introduzione
Sviluppo di un'applicazione per sistema operativo iOS, con l'obiettivo di fornire valore aggiunto agli studenti che accedono al campus Navile dell’Università di Bologna. L'app aiuta gli utenti ad orientarsi, fornendo una mappa del campus e di tutti i suoi edifici e spazi, inclusi classi, laboratori, aule studio e uffici. Inoltre, ove applicabile, l'app permette di monitorare in tempo reale i parametri ambientali rilevati da una serie di sensori all'interno di classi e laboratori. Tali valori vengono utilizzati per calcolare e visualizzare il livello di comfort, in modo da aiutare gli studenti nel decidere quali zone del campus frequentare.


## Getting Started

Nel progettpo troveremo diverse cartelle, ognuna con una propria fuzione.
- AlmaMap in cui troviamo l'implementazione del progetto
- Server dove sono presenti tutti i dati di Building, Floors, Spaces, Legend, Sensors.
- Reports contenente l'abstract del progetto e la relazione di tesi
- Mockup in cui possiamo trovare i mockup del progetto fatti precedentemente all'i plemnetazione

### Prerequisites

Per avviare il simulatore dell'applicazione AlmaMap, necessitiamo di aver installato sul nostro computer:
-XCode
- ed eventualmente Visual Studio Code per l'attivazione del server, procedura che si può fare anche tramite terminale

### Installation

- Aprire la cartella Server su Visual Studio Code o su Terminale e avviare il server con "node index.js", se questa operazione non viene eseguita l'applicazione prenderà tutti i dati che ha in locale

- Eseguire il file AlmaMap.xcodeproj per eseguire il progetto. Si può passare da xcode e far partire il run del simulatore in locale sul proprio computer, oppure collegado il proprio telefono con sistema operativo iOS, scaricarsi l'applicazione direttamete sul proprio portatile.


#### Immagini SVG
La gestione delle immagini SVG funziona in gran parte, è stato implementato lo zoom dell'immagine e la pssobilità di cliccare su uno spazio per visualizzare delle informazioni.
Unico problema, la libreria SVGView non geztisce onTapGesture sui polygon, e non ho trovato altre librerie che lo facciano. Non ci sono problemi sui rect e path. Infatti si potrebbero riscontrare problemi su determinati spazi.

#### Richieste API al server di AlmaMap per la richiesta dei valori raccolti dai sensori
Le richieste dei valore raccolti dai sensori, in questa versione di AlmaMap mobile, è simulata. Non è stata implementata in modo efficente il collegamento per la richiesta di quelle informazioni sulla versione dei chioschi. Tutte gli altri dati che venogno visualizzati utilizzano richieste API su un server in cui sono prenseti i dati di Building, Floor, Space e così via.
