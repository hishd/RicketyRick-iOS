
# Rick and Morty

<p>
<img src="https://img.shields.io/badge/Swift-5.9-violet">
<img src="https://img.shields.io/badge/iOS-14-green">
<img src="https://img.shields.io/badge/XCode-15-blue">
</p>

### Overview

The application uses the [Rick and Morty API](https://rickandmortyapi.com/) API to fetch character, episode and location data.

- This iOS appliaction is built using UiKit + Programatic UI
- Suports minimum target iOS 14
- Developed using **Clean Architecture** (Data, Domain, Presentation)
- MVVM is used for presentation layer to enhance readability and flexibility
- Navigation is handled through **Coordinators**
- A seperate networking layer is developed to handle RestAPI calls which supports modern concurrrency through Async API
- Networking layer supports handling multiple API calls using TaskGroup and DispatchGroup
- A seperate dependency injection library is created to decouple dependencies. The approach uses property wrappers and subscripts
- A seperate image caching library to cache and retrieve images for table views
- App contains fluid animations and transitions

### Visual Designs
<p>
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/1.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/2.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/3.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/4.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/5.png?raw=true" height="300">
</p>
<p>
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/6.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/7.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/8.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/9.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/10.png?raw=true" height="300">
</p>
