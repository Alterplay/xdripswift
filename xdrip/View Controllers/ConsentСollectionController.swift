import UIKit

final class ConsentСollectionController: UIViewController {
    
    @IBOutlet weak var agreement: UILabel!
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var termsPolicyTextView: UITextView!
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var continueAction: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


private extension ConsentСollectionController {
    
    func setupUI() {
        setupCheckboxButton()
        setupContinueButton()
        setupTextView()
    }
    
    func setupCheckboxButton() {
        checkboxButton.setImage(UIImage(named: "rectangle"), for: .normal)
        checkboxButton.setImage(UIImage(named: "checkBox"), for: .selected)
        checkboxButton.tintColor = .clear
    }
    
    func setupContinueButton() {
        continueButton.setTitleColor(UIColor.gray, for: .disabled)
        continueButton.setTitleColor(UIColor.white, for: .normal)
        continueButton.isEnabled = false
        continueButton.layer.cornerRadius = 10
    }
    
    func setupTextView() {
        termsPolicyTextView.text = "By pressing Continue, you agree to our Terms and Conditions and Privacy Policy"
        termsPolicyTextView.addClickable(linkText: "Terms and Conditions", link: "https://docs.google.com/document/d/162FE2p-lwpMWY4gcsi4KSjN--CKicvTw_pYyj9GPjXM/edit")
        termsPolicyTextView.addClickable(linkText: "Privacy Policy", link: "https://docs.google.com/document/d/1rycbDx3nnpeutoYN0C3g990Ev0ZkVDnDvmAxc0KlpoE/edit")
    }
    
    // MARK: - Actions
    
    @IBAction func checkboxTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        continueButton.isEnabled = sender.isSelected
    }
    
    @IBAction func continueTap(_ sender: Any) {
        UserDefaults.standard.isUserAgreementConfirmed = true
        continueAction?()
    }
}





extension UITextView {
    func addClickable(linkText: String, link: String, linkColor: UIColor = .systemBlue) {
        guard let attributedText = attributedText.map({ NSMutableAttributedString(attributedString: $0) }),
              let linkRange = attributedText.string.range(of: linkText, options: .regularExpression) else { return }
        attributedText.addAttribute(.link, value: link, range: NSRange(linkRange, in: attributedText.string))
        linkTextAttributes = [.foregroundColor: linkColor]
        self.attributedText = attributedText
    }
}
