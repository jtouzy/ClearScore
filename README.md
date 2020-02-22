# ClearScore

Demo app for ClearScore iOS Developer interview.

## Quick overview

In the technical test specs, the application should be production ready. Based on that, this demo app :
* has an AppIcon, and a LaunchScreen icon
* is localization ready (available for 🇬🇧 & 🇫🇷)
* is dark-mode ready (colors & images are available in each user interface style)
* is [multiple-environment ready](#environment)
* is unit-tested with 99% coverage

## Project architecture details

### Data

This folder contains all the data layer. A protocol named `DataProvider` is an abstraction of the data query methods. A single implementation of this protocol is present, the `HTTPDataProvider`, which fetches the data from the AWS HTTP endpoint.

The protocol allows you to easily create mocks, and also implements a different source of data if needed.

*Note: In a reactive environment, the protocol should expose an Rx function returning a Single element, without any completion. It should be something like the example below. For this demo, Rx is not used.*

```swift
// Example of protocol in a reactive environment
protocol ReactiveDataProvider {
    func fetchCreditScore() -> Single<CreditScore>
}
```

The `HTTPInvoker` protocol is here to easily unit test the `HTTPDataProvider` implementation without calling an URLSession task. It's injected as a lazy var in the `HTTPDataProvider` implementation, for being replaced during unit tests. `EnvironmentProvider` is also injected for [environment management](#environment).

### Entities

This folder contains model entities, which are all `Codable` instances for handling JSON serialization/deserialization. Based on the given specs, this is not needed to deserialize the full JSON received from the backend API. We only need some informations about the current and maximum credit score.

### <a name="environment"></a>Environment

This folder contains resources and classes for environment management (such as backend endpoint URL). 

The `API_URL` variable is defined in each `Development.xcconfig` and `Production.xcconfig` file. Based on the given specs, only one URL is provided, so the same URL is set in each file. It's only for the structure demo.

The `$(API_URL)` variable is set in the Info.plist main-target file, for being retrieved in the `AppEnvironmentProvider`. Same as the DataLayer, a protocol is also available (`EnvironmentProvider`) for easy mocking.

### Errors

Application errors.

### Extensions

UIKit & Foundations extensions.

### Modules

All MVP modules.

### Protocols

Global reusable protocols.

### Resources

This folder contains application resources (i.e. Assets).

### Storyboards

This folder contains application storyboards (Main & LaunchScreen).
