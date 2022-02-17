# flutter_merchant

A simple project - merchant application that has:
- Firebase Authentication (Email)
- CRUD operations for Product objects

Tested for Android and Web.

 ## Pre-requisites
  
1. Flutter (Channel stable, 2.10.1, on Microsoft Windows [Version 10.0.19043.1526], locale en-PH)
    • Flutter version 2.10.1 at D:\Programs\flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision db747aa133 (8 days ago), 2022-02-09 13:57:35 -0600
    • Engine revision ab46186b24
    • Dart version 2.16.1
    • DevTools version 2.9.2  
    
 2. Android Studio (version 3.5) - to create AVD or emulator
	• [How to create AVDs](https://developer.android.com/studio/run/managing-avds)
	• Tested AVD : 
	- AVD Name: 4.65 720p (Galaxy Nexus) API 26
	- Android 26 SDK : Android 8.0
	- Min resolution: 720 x 1280
	

## Getting Started

  
1. Clone the repository
> git clone https://github.com/shdolores1/flutter-merchant.git
2. To install dependencies, open terminal inside  `flutter-merchant`  folder, and type
> flutter pub get
3. You need to also clone [merchant-api](https://github.com/shdolores1/merchant-api) and make sure it is running successfully before proceeding to the next step.
4. Build the project:
- Select your preferred AVD (*Example:  4.65 720p (Galaxy Nexus) API 26*) or,
- Select Web.