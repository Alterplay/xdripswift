//
//  OneLastThingViewController.swift
//  xdrip
//
//  Created by Volodymyr Abdrakhmanov on 18.05.2022.
//  Copyright © 2022 Johan Degraeve. All rights reserved.
//

import UIKit

final class OneLastThingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var switcher: UISwitch!
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
        switcher.isOn = false
        switcher.layer.cornerRadius = 16
        nextButton.isEnabled = false
        nextButton.layer.cornerRadius = 10
        
    }
    
    // MARK: - Actions
    
    @IBAction private func nextButtonTap(_ sender: Any) {
        UserDefaults.standard.isUserAgreementConfirmed = true
        nextAction?()
    }
    
    @IBAction private func switchValueChanged(_ sender: UISwitch) {
        nextButton.isEnabled = sender.isOn
    }
}
