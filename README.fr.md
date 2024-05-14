# Librairie VideoFeed de Digiteka

[![en](https://img.shields.io/badge/lang-en-red.svg)](ReadMe.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](ReadMe.fr.md)

La librairie VideoFeed de Digiteka fourni un composant interactif pour afficher des listes de contenus médias, organisés par catégories.

# Installation

Ajouter la dépendance à votre projet avec l'une de ces solutions :

## CocoaPods

Vous pouvez utiliser [CocoaPods](https://cocoapods.org/) pour installer `VideoFeedSDK` en ajoutant ce code à votre fichier `Podfile` :

`pod 'VideoFeedSDK', '~> 1.0.0'`

## Swift Package Manager

Vous pouvez intégrer `VideoFeedSDK` en tant que package Swift en ajoutant l'URL suivante du repository public dans Xcode :

`https://bitbucket.org/beappers/digiteka.newssnack.ios/`

# Utilisation

Dans la méthode `application(_:, didFinishLaunchingWithOptions:)` de votre class `ApplicationDelegate`, ajoutez le code suivant pour initialiser la librairie :

	do {
		try VideoFeed.shared.initialize(config: DTKNSConfig(apiKey: "01472001"))
	} catch {
		print("Can't init VideoFeed with error \(error.localizedDescription)")
	}

## Logger

Il est possible de définir un logger personnalisé pour récupérer les logs de la librairie. Le logger doit implémenter le protocol `DTKNSLoggerDelegate` :

	extension AppDelegate: DTKNSLoggerDelegate {
		func debug(message: String) {
			print("debug " + message)
		}
		
		func info(message: String) {
			print("info " + message)
		}
		
		func warn(message: String) {
			print("warn " + message)
		}
		
		func error(message: String, error: Error?) {
			print("error " + message, error as Any)
		}
	}

Puis passez le logger à la librairie :

	VideoFeed.shared.setLoggerDelegate(self)

## Tracking

Pour traquer les évènements provenant de la librairie, il est possible de passer un tracker personnalisé. Le tracker doit implémenter le protocol `DTKNSTrackingDelegate` :

	extension AppDelegate: DTKNSTrackingDelegate {
    	func trackEvent(_ event: TrackingEvent, sessionId: String?) {
        	print("Tracking event received \(event) for sessionId \(sessionId ?? "nil")")
    	}
	}

Puis passez le tracker à la librairie :

	VideoFeed.shared.setTrackingDelegate(self)

## Afficher le VideoFeed UIViewController

Le `VideoFeedSDK` fournis un UIViewController que vous pouvez utiliser comme vous le souhaitez.
Dans l'exemple suivant, le UIViewController est présenté en tant que modale :

	do {
		let vc = try VideoFeed.shared.videoFeedViewController()
		present(vc, animated: true)
	} catch {
		print(error)
	}

### Personnalisation de l'UI

Par défaut, le VideoFeed UIViewController utilisera la configuration système.
L'interface peut être personnalisée en passant une instance de `DTKNSUIConfig` au `VideoFeedSDK` :

	let vc = try VideoFeed.shared.videoFeedViewController(
        uiConfig: DTKNSUIConfig(
            titleFont: UIFont.boldSystemFont(ofSize: 42),
            descriptionFont: UIFont.italicSystemFont(ofSize: 12),
            playImageName: "Play",
            pauseImageName: "Pause",
            emptyStateImageName: "EmptyState"
        )
    )

## Errors and Logs

| Type          | Code d'erreur | Niveau   | Message                                                                                                                                    | Cause                                                                                                                                             |
|---------------|---------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| Configuration | DTKNS_CONF_1  | Critical | MDTK must not be null, empty or blank. Please provide a valid Api Key.                                                                     | mdtk nul ou vide                                                                                                                                  |  
| Configuration | DTKNS_CONF_2  | Error    | No data were provided for your Api key (mdtk), please check your Api Key is valid, and you do provide data for it in the digiteka console. | Le tableau data est vide ou aucune zone ne contient de vidéo                                                                                      |  
| Configuration | DTKNS_CONF_3  | Error    | VideoFeed sdk has not yet been initialized. Please call `VideoFeed.initialize` first.                                                      | NewSnack.shared.initialize ou VideoFeed.initialize n'ont pas encore été appelé                                                                    |  
| Configuration | DTKNS_CONF_4  | Warning  | No video available in zone                                                                                                                 | Aucune vidéo disponible dans la zone                                                                                                              |  
| Network       |               | Info     | Network connection re-established                                                                                                          | La connexion au réseau a été \(r\)établie                                                                                                         |  
| Network       | DTKNS_NET_1   | Warning  | Network connection lost.                                                                                                                   | La connexion au réseau a été perdue                                                                                                               |  
| Network       | DTKNS_NET_2   | Warning  | Network connection unavailable.                                                                                                            | La connexion au réseau est indisponible lors d'une requête réseau                                                                                 |  
| Data          | DTKNS_DATA_1  | Warning  | DataIntegrity error \<ClassName>: \<short message describing why>                                                                          | L'une des données requises du modèle envoyé par le serveur est invalide.                                                                          |  
| Data          |               | Info     | Can't load image from url <url>                                                                                                            | L'image placeholder n'a pas pu être chargée                                                                                                       |
| SDK           | DTKNS_SDK_1   | Critical | Can't convert URL from string \<string\>                                                                                                   | La conversion de l'url string en URL remonte une erreur. Veuillez contacter le support si cela arrive                                             |
| SDK           | DTKNS_SDK_2   | Error    | Failed to communicate with server                                                                                                          | La réponse du serveur était invalide, ou la connexion au serveur à échouée (p.e. timeout). Veuillez contacter le support si le problème persiste. |

# Application de démonstration

Vous pouvez tester l'application de démonstration en utilisant le mdtk : `01472001`.
