
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
- Navigation is handled through **Coordinators**
- A seperate networking layer is developed to handle RestAPI calls which supports modern concurrrency through Async API
- Networking layer supports handling multiple API calls using TaskGroup and DispatchGroup
- A seperate dependency injection library is created to handle dependencies. The approach uses property wrappers and subscripts
- App contains fluid animations and transitions

### Visual Designs
<p>
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/1.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/2.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/3.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/4.png?raw=true" height="300">
  <img src="https://github.com/hishd/RickAndMorty/blob/master/Images/5.png?raw=true" height="300">
</p>
