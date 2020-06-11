# COVID19

Questa consegna punta su lavorare sulle API. Con annesso uso dei file JSON con dart.

&nbsp;

## Getting Started

Prima di tutto sono andato a vedermi il risultato delle api (aprendo il link: 'https://corona.lmao.ninja/v2/countries/').
Dopo aver visto la struttura di queste ho copiato tutto il contenuto ed utilizzato per creare una classe dart per la che le potesse rappresentrare (attraverso l'ausilio del convertitore online: 'https://javiercbk.github.io/json_to_dart/')

### Decisioni progetto

Ho deciso di creare un drawer per una facile navigazione tra le pagine.

### General consideration

Ho voluto utilizzare oltre a delle immagini personalizzate (asset), anche dei font e delle icone.
Il procedimento le ultime è stato molto lungo in quanto ho dovuto importarle (trovare e scaricare l'svg convertire il tutto) e provarle.

___

&nbsp;

## Code explanation by pages

### Pagina di caricamento(main)

___

Questa schermata oltre a mostrare il titolo dell'applicazione funge anche da buffer, grazie al caricamento(attraverso un timer), per ricevere i dati con la chiamata al metodo `getWorldData()` della classe worldApi.
In caso la connessione ad internet non dovesse essere presente, verra visualizzato un alert dove chiesto di controllare la propria connessione.

### Pagina iniziale(CovidMenu)

___

In questa si ha un'anteprima mondiale, con i casi e le morti.
E' la prima pagina in cui si trovano l'appbar e il drawer, questi sono sempre gli stessi per tutte.

- Drawer: Strutturato in maniera molto semplice permette, attraverso vari "pulsanti" di aprire le seguenti pagine: Country list, Search for country.
Inoltre permette sia di uscire dall'app, che visualizzare le informazioni.

### Pagina lista paesi(CountryList)

___

Per consentire una visualizzazione compatta di tutti i paesi del mondo ho creato una lista di tutti i paesi con i relativi dati su morti e casi.
Ho dovuto aggiungere uno "slider" per i nomi dei paesi più lunghi.
Per ogni paese viene creato un container "sensibile al tocco" attraverso un `GestureController(...)`.

### Pagina Paese(CountryStats)

___

Nonostante tutto per completare la visualizzazione dei dati, dalla schermata precendente (Pagina lista paesi) c'è la possibilità di interagire con le varie "card" ed entrare nella visualizzazione dei singoli paesi. In questa si ha una visione più specifica e approfondita.
E' possibile interragire con le immagini presenti:

- Bandiera: con tocco apre google maps, con tocco prolungato apre delle tips.
- Country image: con tocco prolungato mostra il nome del continente, metre con tocco semplice apre la pagina riguardante le news del continente dal sito dell'ansa.

### Pagina Ricerca(SearchForCountry)

___

Per una semplificazione nel trovare i dati di un singolo paese ho creato una pagina per la ricerca.
Il textfiel presente da dei suggerimenti sul completamento.
Inoltre una volta selezionato viene portato all'inizio della pagina.

&nbsp;

## Links

___

Principali:

- [FlutterIcon](https://fluttericon.com/) - Sito per la conversione delle icone da .svg a ttf e .dart:
- [ICONFINDER](https://www.iconfinder.com/) - Sito dove ho trovato varie icone
- [AppIcon](http://appicon.co/) - Sito per la generazione delle icone dell'applicazione
- [GF Alert](https://docs.getflutter.dev/gf-alert) - Sito della dependency: `getflutter: ^1.0.11`.
- [GF Alert](https://docs.getflutter.dev/gf-alert) - Sito della dependency: `getflutter: ^1.0.11`.
- [GF Alert](https://docs.getflutter.dev/gf-alert) - Sito della dependency: `getflutter: ^1.0.11`.

Altri:

- [Sito](https://pub.dev/packages?q=getflutter) della dependency: `getflutter: ^1.0.11`.
- [Sito](https://pub.dev/packages?q=http) della dependency: `http: 0.12.0+4`.
- [Sito](https://pub.dev/packages?q=path_provider) della dependency: `path_provider: ^1.6.5`.
- [Sito](https://pub.dartlang.org/packages?q=custom_navigation_drawer) della dependency: `custom_navigation_drawer: 0.0.1`.
- [Sito](https://pub.dartlang.org/packages?q=gradient_app_bar) della dependency: `gradient_app_bar: ^0.0.1`.
- [Sito](https://pub.dartlang.org/packages?q=url_launcher) della dependency: `url_launcher: 5.4.7`.
- [Sito](https://pub.dartlang.org/packages?q=dropdownfield) della dependency: `dropdownfield`.
- [Sito](https://pub.dartlang.org/packages?q=autocomplete_textfield) della dependency: `autocomplete_textfield: 1.7.3`.
- [Sito](https://pub.dartlang.org/packages?q=permission_handler) della dependency: `permission_handler: ^5.0.0+hotfix.5`.
- [Sito](https://pub.dartlang.org/packages?q=flutter_launcher_icons) della dependency: `flutter_launcher_icons: 0.7.5`.
- [Sito](https://pub.dartlang.org/packages?q=connectivity) della dependency: `connectivity: ^0.4.8+6`.
- [Sito](https://pub.dartlang.org/packages?q=link) della dependency: `link: ^1.1.0`.
  
### Video vari

___

- "https://www.youtube.com/watch?v=zx6uMCoW2gQ"
- "https://www.youtube.com/watch?v=JWuXj0BY_s4"
- "https://www.youtube.com/watch?v=oExw0U4U_UI&t=847s"
- "https://www.youtube.com/watch?v=zyhPamYS3BU&t=506s"
- "https://www.youtube.com/watch?v=VzuHfHyJcuI&t=273s"
- "https://www.youtube.com/watch?v=K1uH_SN4X0w&t=478s"
- ecc.

&nbsp;

## Built With

___

- [Dart](https://dart.dev/guides) - Programming language
- [Flutter](https://flutter.dev/docs) - UI toolkit

&nbsp;

## Author

___

- **Enrico Kogoj** - [GitLab account](https://gitlab.com/enrico0101)
