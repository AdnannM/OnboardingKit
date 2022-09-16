//
//  File.swift
//  
//
//  Created by Adnann Muratovic on 14.09.22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var nextButtonDidTap: ((Int) -> Void)?
    var getStartedButtonDidTap: (() -> Void)?
    
    private let slides: [Slide]
    private let tintColor: UIColor
    private let themeFont: UIFont
    
    private lazy var transtionView: TransitionView = {
        let view = TransitionView(slides: slides, viewTintColor: tintColor, themeFont: themeFont)
        return view
    }()
    
    private lazy var buttonContainerView: ButtonContainerView = {
        let view = ButtonContainerView(tintColor: tintColor)
        view.nextButtonDidTap = { [weak self] in
            guard let this = self else { return }
            this.nextButtonDidTap?(this.transtionView.slideIndex)
            this.transtionView.handleTap(direction: .right)
        }
        view.getStartedDidTap = getStartedButtonDidTap
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [transtionView, buttonContainerView])
        view.axis = .vertical
        return view
    }()
    
    public init(slides: [Slide], tintColor: UIColor, themeFont: UIFont) {
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = themeFont
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transtionView.start()
    }
    
    public func stopAnimation() {
        transtionView.stop()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        buttonContainerView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
        transtionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewDidTap(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: view)
        let midPoint = view.frame.size.width / 2
        if point.x > midPoint {
            transtionView.handleTap(direction: .right)
        } else {
            transtionView.handleTap(direction: .left)
        }
    }
}
