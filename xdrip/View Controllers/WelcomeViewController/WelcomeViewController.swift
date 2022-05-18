//
//  WelcomeViewController.swift
//  xdrip
//
//  Created by Volodymyr Abdrakhmanov on 18.05.2022.
//  Copyright © 2022 Johan Degraeve. All rights reserved.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var termsPolicyTextView: UITextView!
    @IBOutlet private weak var nextButton: UIButton!
    
    // MARK: - Public Properties
    
    var nextAction: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {        
        nextButton.layer.cornerRadius = 10
        
        termsPolicyTextView.text = "By pressing Next you with our Terms & Conditions and Privacy Policy"
        termsPolicyTextView.addClickable(linkText: "Terms & Conditions", link: "https://shuggahapp.com/terms-and-conditions")
        termsPolicyTextView.addClickable(linkText: "Privacy Policy", link: "https://shuggahapp.com/privacy-notice/")
    }
    
    // MARK: - Actions
    
    @IBAction private func seeDetailsTap(_ sender: Any) {
        guard let url = URL(string: "https://www.gnu.org/licenses/gpl-3.0.txt") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func nextTap(_ sender: Any) {
        nextAction?()
    }
}
