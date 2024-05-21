<p align="center">
  <img src="https://github.com/matt-novoselov/Arcy/blob/64d31ca0a91acd93689116854061c29bfb4f74ff/Media/ArcyLogoRounded.png" alt="Logo" width="80" height="80">
  <h2 align="center">
    Arcy
  </h2>
</p>

<img src="https://github.com/matt-novoselov/matt-novoselov/blob/99433a44acc6d87d1522985a618137810ef20839/Files/visionOS.svg" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/99433a44acc6d87d1522985a618137810ef20839/Files/RealityKit.svg" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/99433a44acc6d87d1522985a618137810ef20839/Files/CoreML.svg" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/d8b0929ffafacd78dad72a169c64e622af13a115/Files/CoreData.svg" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/d8b0929ffafacd78dad72a169c64e622af13a115/Files/Metal.svg" style="height: 30px">

{Arcy short description}

![](https://github.com/matt-novoselov/Arcy/blob/64d31ca0a91acd93689116854061c29bfb4f74ff/Media/ArcyHeader.png)

<a href="https://www.youtube.com/watch?v=oICA5GGamFs" target="_blank">
  <img src="https://github.com/MassimoPalosciaIT/iSOS/assets/59065228/3816afd0-ed60-4369-a039-d85ed58b7000" alt="GIF">
</a>

[![](https://github.com/matt-novoselov/matt-novoselov/blob/34555effedede5dd5aa24ae675218d989e976cf6/Files/YouTube_Badge.svg)](https://www.youtube.com/watch?v=oICA5GGamFs)
[![](https://github.com/matt-novoselov/matt-novoselov/blob/eb675928f9e5b3cd2a2db6cde2b6ecf5ab646b4c/Files/Available_on_the_Test_Flight.svg)](https://testflight.apple.com/join/l8JQokLW)


## Description
Welcome to Arcy - Your personal AI archaeological museum in Spatial Reality.

Many archaeological artifacts are housed in museums, private collections, or remain at archaeological sites. Access to these artifacts is often restricted due to preservation concerns, legal limitations, or limited public viewing opportunities. Arcy, a visionOS app, makes these archaeological artifacts accessible to a broader audience by bringing them into a virtual space.

With Arcy, users can view and interact with virtual archaeological artifacts in spatial reality, gaining detailed information about each one. Explore history like never before, right from the comfort of your own space.

Arcy is an educational AI app that makes rare artifacts accessible in a spatial reality environment, enabling experiences that would otherwise be impossible. The app is technically proficient, leveraging advanced frameworks, robust architecture, and comprehensive error handling.

## Features

### Interact with Virtual Artifacts
The app offers a library of over 30 unique artifacts for you to explore. The content within the app isn’t limited to two dimensions; you can open each artifact in volumetric space and explore high-quality 3D representations that look and feel real. Blending digital content with the real world unlocks experiences like never before, allowing you to explore artifacts from all angles by rotating them with your hands. The app utilizes spatial windows, volumes, and environment spaces to provide users with an immersive experience.
![](https://github.com/matt-novoselov/Arcy/blob/58782b6be422b2c950f625f4ad1f1125c429c303/Media/3Dmodel.png)

### Like Artifacts
Did you find an artifact that you like? Simply "like" it! The app automatically stores information about the artifacts you have marked as "favorite" between sessions, thanks to data persistence. Users can always review the artifacts they have marked as “liked”, add or remove them from their library. A vector-based Lottie animation is used to display a "liking" animation, enhancing the visual appeal of the button interaction.

### AI Recommendations
Based on the artifacts you have liked, the app’s AI can suggest artifacts tailored to your preferences, providing a personalized experience. The custom recommendation prediction model is based on various parameters of the artifacts and has been trained using Create ML. The model runs locally on the device via CoreML, eliminating the need for an internet connection.

### Setup Profile
Users can create a profile by entering their name, uploading a profile image, and bookmarking their favorite artifacts. The app remembers the user and their preferences across sessions, utilizing data persistence to create a continuous user experience, thanks to frameworks like CoreData.

### Adaptive Screen Size
In spatial reality, the canvas has no limits, allowing users to resize windows to their needs, making them as wide or as narrow as desired. The app automatically adapts to different screen sizes. This feature is particularly beneficial in a spatial reality environment.
![](https://github.com/matt-novoselov/Arcy/blob/58782b6be422b2c950f625f4ad1f1125c429c303/Media/adaptiveSize.png)

### Take a Quiz
Users can take quizzes to test their archaeological knowledge, making the app a valuable educational tool.
![](https://github.com/matt-novoselov/Arcy/blob/58782b6be422b2c950f625f4ad1f1125c429c303/Media/quiz.png)
At the end of the quiz, the user’s environment transforms into an immersive space to display a custom particle emitter effect (confetti), created using Reality Composer Pro — Apple’s tool for creating and assembling complex scenes with realistic 3D content for visionOS apps.
![](https://github.com/matt-novoselov/Arcy/blob/58782b6be422b2c950f625f4ad1f1125c429c303/Media/confetti.png)

### Frameworks used:
SwiftUI - A cross-platform framework for building user interfaces. Apple recommends using SwiftUI for developing user-friendly spatial computing apps.
RealityKit - An AR-based framework for high-performance 3D simulations and rendering. RealityKit is a core framework for building spatial computing apps. 
CoreML - A framework designed to run progressive Neural Network models. CoreML is used in the app to run a local AI recommendations model.
CoreData - A framework for managing complex data structures, storage, and persistence. CoreData is used in the app to store user data across sessions.
Metal - A low-level advanced 3D graphics and compute shader API. Metal shaders are used in the app to create visual effects.

### Code Structure
The code for the app is well-documented and thoroughly commented, making it easy for contributors to understand the architecture and code structure. This facilitates the implementation of new features and modifications to existing ones.
The app is built on the principles of the MVVM (Model-View-ViewModel) architecture, applied to SwiftUI design patterns. Its code architecture is designed to be scalable and flexible, ensuring ease of maintenance and usability within large teams. This approach is beneficial for long-term development and potential future expansions.
Additionally, the app incorporates multiple layers of error handling, which minimizes the risk of crashes and enhances overall reliability.

### Running the Project

> [!TIP]
> If you are using the visionOS Simulator, it’s easier to control the environment with a computer mouse rather than with a trackpad. Learn more about how to control and interact with visionOS simulator.

> [!WARNING]
> The visionOS Simulator might sometimes have issues with rendering proper lighting on 3D objects. The lighting in a spatial computing environment is calculated dynamically based on users’ physical surroundings. However, the visionOS Simulator sometimes fails to project the proper lighting on a 3D object. As of the release of visionOS 1.2, this bug is still not fixed. Please refer to this bug report for more information: https://forums.developer.apple.com/forums/thread/742222
If you encounter this bug, try restarting the visionOS Simulator several times, completely deleting the app from the simulator, and then reinstalling it.
![](https://github.com/matt-novoselov/Arcy/blob/58782b6be422b2c950f625f4ad1f1125c429c303/Media/brokenLight.png)

![](https://github.com/matt-novoselov/Arcy/blob/58782b6be422b2c950f625f4ad1f1125c429c303/Media/bento.png)


## Requirements
- visionOS 1.2+
- Xcode 15.4+

## Installation
1. Open Xcode.
2. Click on **"Clone Git Repository"**.
3. Paste the following URL: `https://github.com/matt-novoselov/Arcy.git`
4. Click **"Clone"**.
5. Build and run the project in Xcode.

## Dependencies
- [Lottie for Swift Package Manager](https://github.com/airbnb/lottie-spm) - a cross-platform library that natively renders vector-based animations.
<br>

## Credits
Distributed under the MIT license. See **LICENSE** for more information.

The 3D models featured within the application originate from the Bonn Center for Digital Humanities and are subject to the following licensing terms: Attribution-NonCommercial-NoDerivs (CC BY-NC-ND 4.0), © 2024 Bonn Center for Digital Humanities. These models remain unaltered from their original form and are intended solely for non-commercial purposes.

Developed with ❤️ by Matt Novoselov
