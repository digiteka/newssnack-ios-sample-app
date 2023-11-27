# Digiteka NewsSnack Framework

[![en](https://img.shields.io/badge/lang-en-red.svg)](ReadMe.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](ReadMe.fr.md)

Digiteka News Snack library provides an interactive view to display lists of media content, sorted by categories.

# Installation

Simply add the dependency to your project using one of this solution:

## CocoaPods

You can use [CocoaPods](https://cocoapods.org/) to install `NewsSnackSDK` by adding it to your `Podfile`:

`pod 'NewsSnackSDK', '~> 1.0.0'`

## Swift Package Manager

You can integrate `NewsSnackSDK` as a Swift package by adding the following URL to the public package repository that you can add in Xcode:

`https://bitbucket.org/beappers/digiteka.newssnack.ios/`

# Usage

Then in the `application(_:, didFinishLaunchingWithOptions:)` of your `ApplicationDelegate` class, add the following code to initialize the sdk:

	do {
		try NewsSnack.shared.initialize(config: DTKNSConfig(apiKey: "01472001"))
	} catch {
		print("Can't init NewsSnack with error \(error.localizedDescription)")
	}

## Logger

Optionally, you can set a custom logger in order to retrieve logs from the sdk. The logger must implement the `DTKNSLoggerDelegate` protocol:

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

Then pass the logger:

	NewsSnack.shared.setLoggerDelegate(self)

## Tracking

Optionally, you can set a custom tracker in order to track events from the sdk. The tracker must implement the `DTKNSTrackingDelegate` interface.

	extension AppDelegate: DTKNSTrackingDelegate {
    	func trackEvent(_ event: TrackingEvent, sessionId: String?) {
        	print("Tracking event received \(event) for sessionId \(sessionId ?? "nil")")
    	}
	}

Then pass the tracker:

	NewsSnack.shared.setTrackingDelegate(self)

## Displaying the NewsSnack UIViewController

The `NewsSnackSDK` provide a UIViewController that you can use as you want
Here in the example, the UIViewController is show as a modal:

	do {
		let vc = try NewsSnack.shared.newsSnackViewController()
		present(vc, animated: true)
	} catch {
		print(error)
	}

### Customizing the UI

By default, NewsSnack UIViewController will use system configuration.
The UI can be customized by passing a `DTKNSUIConfig` instance to the `NewsSnackSDK`:

	let vc = try NewsSnack.shared.newsSnackViewController(
        uiConfig: DTKNSUIConfig(
            titleFont: UIFont.boldSystemFont(ofSize: 42),
            descriptionFont: UIFont.italicSystemFont(ofSize: 12),
            playImageName: "Play",
            pauseImageName: "Pause",
            emptyStateImageName: "EmptyState"
        )
    )

## Errors and Logs

| Type          | Error Code   | Level    | Message                                                                                                                                    | Cause                                                                                                                       |
|---------------|--------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| Configuration | DTKNS_CONF_1 | Critical | MDTK must not be null, empty or blank. Please provide a valid Api Key.                                                                     | mdtk is null or empty                                                                                                       |  
| Configuration | DTKNS_CONF_2 | Error    | No data were provided for your Api key (mdtk), please check your Api Key is valid, and you do provide data for it in the digiteka console. | The mdtk is not valid, or no video has been configured in the digiteka console                                              |  
| Configuration | DTKNS_CONF_3 | Error    | NewsSnack sdk has not yet been initialized. Please call `NewsSnack.shared.initialize` first.                                                      | `NewsSnack.shared.initialize` has not been called yet                                                                              |  
| Configuration | DTKNS_CONF_4 | Warning  | No video available in zone                                                                                                                 | No video is available for this zone                                                                                         |  
| Network       |              | Info     | Network connection re-established                                                                                                          | Network connection was lost and has been re-established                                                                     |  
| Network       | DTKNS_NET_1  | Warning  | Network connection lost.                                                                                                                   | Lost network connection                                                                                                     |  
| Network       | DTKNS_NET_2  | Warning  | Network connection unavailable.                                                                                                            | Failed to connect to network                                                                                                |  
| Data          | DTKNS_DATA_1 | Warning  | DataIntegrity error \<ClassName>: \<short message describing why>                                                                          | Required data was not provided by the server.                                                                               |  
| Data          |              | Info     | Can't load image from url \<url>                                                                                                            | The placeholder image url wasn't valid or failed to load                                                                    |
| SDK           | DTKNS_SDK_1  | Critical | Can't convert URL from string \<string>                                                                                                   | Built server url was not valid. Please contact support.                                                                     |
| SDK           | DTKNS_SDK_2  | Error    | Failed to communicate with server                                                                                                          | Server response was invalid, or connection failed (timeout). Contact support if it occurs too frequently or systematically. |

# Sample app

You can test the Sample app using the mdtk : `01472001`.
