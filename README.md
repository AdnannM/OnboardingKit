# OnboardingKit

OnboardingKit provides an onboarding flow that is simple and easy to implement.

![alt text](https://github.com/AdnannM/OnboardingKit/raw/main/Screenshot%202022-09-15%20at%2015.08.28.png)


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

class ViewController: UIViewController {
    
    private var onboardingKit: OnboardingKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.onboardingKit = OnboardingKit(slides: [
                .init(image: UIImage(named: "image1")!, title: "Livestreams und Videos - Immer Up-to-Date!"),
                .init(image: UIImage(named: "image2")!, title: "Alles über den FC Kufstein - auf einen Blick!"),
                .init(image: UIImage(named: "image3")!, title: "Kaufe dein Equipment online!"),
                .init(image: UIImage(named: "image4")!, title: "Random Text"),
            ],
            tintColor: UIColor(red: 0.00, green: 0.42, blue: 0.69, alpha: 1.00))
            self.onboardingKit?.delegate = self
            self.onboardingKit?.launchOnboarding(rootVC: self)
        }
    }
}

extension ViewController: OnboardingKitDelegate {
    func nextButtonDidTap(atIndex index: Int) {
        print("NEXT BUTTON IS TAPED AT INDEX \(index)")
    }
    
    func getStartedButtonDidTap() {
        onboardingKit?.dismissOnboarding()
        onboardingKit = nil
        transit(viewController: MainViewController())
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
        uWindow.rootViewController = MainViewController()
        UIView.transition(with: uWindow,
                          duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }
}


class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "Main View Controller"
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        view.backgroundColor = .systemBackground
    }
}

```

## Credits

- Adnan Muratovic

