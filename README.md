# ClearScoreInterview

Demo app for ClearScore iOS Developer interview.

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

Model entities.

### <a name="environment"></a>Environment

Environment management.

### Errors

Application errors.

### Extensions

UIKit & Foundations extensions.

### Modules

All MVP modules.

### Protocols

Global reusable protocols.

### Resources

Application resources (i.e. Assets).

### Storyboards

Application storyboards (Main & LaunchScreen).
