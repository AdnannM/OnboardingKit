# OnboardingKit

OnboardingKit provides an onboarding flow that is simple and easy to implement.

![alt text]()


## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)

## Requirements

- iOS 15.0 or later
- Xcode 13.0 or later
- Swift 5.0 or later

## Installation

There are two ways to use OnboardingKit in your project:

- using Swift Package Manager
- manual install (build frameworks or embed Xcode Project)

### Swift Package Manager

To integrate OnboardingKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/AdnannM/OnboardingKit.git", .upToNextMajor(from: "1.0.0"))
]
```

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

### Manually

If you prefer not to use Swift Package Manager, you can integrate OnboardingKit into your project manually.

---

## Usage

### Quick Start

```swift
import UIKit
import OnboardingKit

class ViewController: UIViewController, OnboardingKitDelegate {

  private var onboardingKit: OnboardingKit?

  override func viewDidLoad() {
    super.viewDidLoad()
    DispatchQueue.main.async {
      self.onboardingKit = OnboardingKit(
        slides: [
          .init(image: UIImage(named: "image1")!,
                title: "Livestreams und Videos - Immer Up-to-Date!"),
          .init(image: UIImage(named: "image2")!,
                title: "Alles über den FC Kufstein - auf einen Blick!"),
          .init(image: UIImage(named: "image3")!,
                title: "Kaufe dein Equipment online!"),
          .init(image: UIImage(named: "image4")!,
                title: "Random Text"),
        ],
        tintColor: UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1.0))
      self.onboardingKit?.delegate = self
      self.onboardingKit?.launchOnboarding(rootVC: self)
    }
  }

  // MARK: - OnboardingKitDelegate {
  func nextButtonDidTap(atIndex index: Int) {
    print("next button is tapped at index: \(index)")
  }

  func getStartedButtonDidTap() {
    onboardingKit?.dismissOnboarding()
    onboardingKit = nil
    transit(viewController: AnotherViewController())
  }

  private func transit(viewController: UIViewController) {
    let foregroundScenes = UIApplication.shared.connectedScenes.filter({
      $0.activationState == .foregroundActive
    })

    let window = foregroundScenes
      .map({ $0 as? UIWindowScene })
      .compactMap({ $0 })
      .first?
      .windows
      .filter({ $0.isKeyWindow })
      .first

    guard let uWindow = window else { return }
    uWindow.rootViewController = viewController

    UIView.transition(
      with: uWindow,
      duration: 0.3,
      options: [.transitionCrossDissolve],
      animations: nil,
      completion: nil)
  }
}
```

## Credits

- Adnan Muratovic

