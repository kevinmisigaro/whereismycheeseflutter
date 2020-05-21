# WhereIsMyCheese Flutter Challenge

 WhereIsMyCheese is a urban treasure hunt app that empowers people to leave cheesy notes in any location on a map! Previously this challenge was always being done in Android. But now its in Flutter!
 
## What the app does

- User can collect cheesey notes on the map.
- User can add cheesey notes on the map.
- App continues to run/persist in the background
- App notifies user if they are close to a cheese


## Requirements to run this app on target machine

Need to have the the following in user computer to run this application:
 - Flutter installed
 - Android SDK
 - Android Studio
 - Visual Studio Code editor (optional)
 
## How to run this application
- Make sure flutter is installed in the target computer
- Clone repository
- Get packpages/dependencies by running ```flutter packages get``` in terminal (or on pubspec.yaml file)
- Connect physical device with computer and run the application (or run flutter run)

## Code structure

The main code is found in the lib folder. It contains:
- models
- services (to handle State management and location service)
- views (screen(s) which the user sees)
- widgets (independent widgets)
- main.dart (file from where the whole app starts to run)

Assets are found in the asset folder. This mainly contains image assets for icons.

pubspec.yaml file contains all the added dependencies and packages.
 
## Plugins used in this application

Plugins are essential in flutter applications. Here are some of the plugins used in this application: 
 - google_maps_flutter: ^0.5.26+4 (To display Google Maps)
 - flutter_launcher_icons: ^0.7.5 (To display custom launch icon in the home screen of the phone)
 - location: ^3.0.2 (To track live phone location)
 - provider: ^3.0.0 (State Management)
 - flutter_local_notifications: ^1.4.3 (App Notifications)
 - latlong: ^0.6.1 (Geolocation Calculations)
 
## How the app works
The app gets user location from the LocationService located in services/location_service. This sends a stream the app, continuously updating the user location.

Cheese data is handled by CheeseModel in services/cheese_service. This sends data to the app asychronously if cheese stored locally in the app; if a new cheese is added, removed(picked up) and the data contained(messages).

Google Map covers the body of the Scaffold in the main home page widget/view. Thanks to the google_maps_flutter plugin and adding some settings on the android folders, it is possible to display a map and add markers.
