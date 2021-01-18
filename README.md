# Navigator

`Navigator` is a navigation process implemented using generics and protocols

## Navigator helps

- Use protocols and generics to abstract the navigation process
- Remove navigation code from  `UIViewController`
- Parameter passing is type safe
- Support the interrupt

## Installation

[Swift Package Manager](https://swift.org/package-manager/) is Apple's decentralized dependency manager to integrate libraries to your Swift projects. It is now fully integrated with Xcode 11

To integrate `Navigator` into your project using SPM, specify it in your `Package.swift` file:

```swift
let package = Package(
    …
    dependencies: [
        .package(url: "https://github.com/GodL/Navigator.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "YourTarget", dependencies: ["Navigator", …])
        …
    ]
)
```

Check out the Example app included, as it covers most of the general use cases.


## Usage

`Navigator` uses 3 main entities (`Create`, `Finder`, `Action`) that should be defined by a host application to support it.


## Implementation

#### 1. Create

Create is responsible for **building view controllers**, that the router has to navigate to upon request.
Every Create instance must implement the `Creatable` protocol:

```swift
public protocol Creatable {
    associatedtype ViewController
    
    associatedtype Context
    
    func build(with context: Context) -> ViewController
}
```

The ViewController is the controller to navigate.
The context is the argument that needs to be passed.

*Example: Basic implementation of the creatable for some custom `NavigatorController` view controller might look like:*

```swift
struct NavigatorCreate: Creatable {
    func build(with context: String) -> NavigatorController {
        let vc = storyBoard.instantiateViewController(identifier: "Navigator") as! NavigatorController
        vc.buttonTitle = context
        return vc
    }
}
```
You can look at some  default `create`  in DefaultCreate.swift

#### 2. Finder

Finder helps find which controller to start navigation from.
All the finder instances should conform to `Findable` protocol.

```swift 
public protocol Findable {
    
    associatedtype ViewController
    
    func find() -> ViewController
}
```
The root controller for the application  is using `RootFinder`

```swift 
public struct RootFinder<Controller: UIViewController>: Findable {
    public init() {}
    
    public func find() -> Controller {
        guard let vc = UIApplication.shared.windows.first?.rootViewController as? Controller else { fatalError("Generic parameter error") }
        return vc
    }
}
```

#### 3. Action

The `Action` instance explains to the router **how the view controller is created by a `Creatable` should be integrated into a view controller stack**.

All the Action instances should conform to `Action` protocol.

```swift 
public protocol Action {
    associatedtype From
    
    associatedtype To
    
    associatedtype Context
    
    func perform(from: From, to: To, context: Context)
}
```
*Example: A Controller show might look like:*

```swift 
public struct SystemAction<From: UIViewController, To: UIViewController, Context>: Action {
    
    public init() {}
    
    public func perform(from: From, to: To, context: Context) {
        from.show(to, sender: nil)
    }
}
```

`Navigator` provides some default actions in DefaultAction.swift 

#### 4. Navigator Interceptor

Navigator interceptor will be **used by the navigator before it will start navigating to the target view controller.** For example, to navigate tosome particular view controller, the user might need to be logged in.
You may create a struct that implements the `Interceptable` protocol.
and if the user is not logged in, it will present a login view controller where the user can log in. If this process finishes successfully,
the interceptor should inform the `Navigator` and it will continue navigating or otherwise stop navigating. See example app for details.

*Example: If the user is logged in, Navigator can continue navigating. If the user is not logged in, the Navigator should not continue*

```swift
var isLogin = false


struct LoginInterceptor: Interceptable {
    func perform(with context: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if isLogin {
            completion(.success(()))
        }else {
            Navigators.login.navigate {
                completion(.success(()))
            }
        }
    }
}
```

### Navigator
A navigation process is abstracted into a navigator ,like this:

```swift

struct Navigators {
    static let push = Navigator(create: NavigatorCreate(), finder: RootFinder<UIViewController>(), action: SystemAction())
    
    static let present = Navigator(create: NavigatorCreate(), finder: RootFinder<UIViewController>(), action: PresentAction())
    
    static let pop = Navigator(create: VoidCreate(), finder: CurrentFinder<UIViewController>(), action: PopAction())
    
    static let dismiss = Navigator(create: VoidCreate(), finder: RootFinder<UIViewController>(), action: DismissAction())
    
    static let login = Navigator(create: LoginCreate(), finder: RootFinder<UIViewController>(), action: PresentAction())
    
    static let pushWithInterceptor = Navigator(create: NavigatorCreate(), finder: RootFinder<UIViewController>(), action: SystemAction(), interceptor: LoginInterceptor())
}
```

The NavigatorRouter uses a Navigator to complete a navigation process

```swift 
NavigatorRouter.router.navigate(Navigators.push, context: title)
```

## More thing
Universal links are under development

## Author

GodL, 547188371@qq.com. Github [GodL](https://github.com/GodL)

*I am happy to answer any questions you may have. Just create a [new issue](https://github.com/GodL/Navigator/issues/new).*

## License

MIT License

Copyright (c) 2021 GodL

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.





