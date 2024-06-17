//
//  ViewController.swift
//  InterestingNumbers
//
//  Created by Екатерина Токарева on 10/03/2023.
//

import UIKit
import InterestingNumbersLibrary

final class NumbersViewController: UIViewController {    
    private let contentView = NumbersMainView()
    private var option: FactOption = .userNumber
    private var buttons = [UIButton]()
    private let numbersFactService = NumbersFactService()
    private var textToSearch = ""
    private var fact: NumberFact?
    private var factsDictionary: [String: String]?
    private lazy var textField = contentView.textField
    private lazy var enterLabel = contentView.enterLabel
    private lazy var userNumberButton = contentView.userNumberButton
    private lazy var randomNumberButton = contentView.randomNumberButton
    private lazy var numberRangeButton = contentView.numberRangeButton
    private lazy var multipleNumberButton = contentView.multipleNumberButton
    private lazy var displayFactButton = contentView.displayFactButton
    weak var delegate: FactDataDelegate?
    
    
    override func loadView() {
        textField.delegate = self
        userNumberButton.addTarget(self, action: #selector(userNumberButtonPressed), for: .touchUpInside)
        randomNumberButton.addTarget(self, action: #selector(randomNumberButtonPressed), for: .touchUpInside)
        numberRangeButton.addTarget(self, action: #selector(numberInRangeButtonPressed), for: .touchUpInside)
        multipleNumberButton.addTarget(self, action: #selector(multipleNumbersButtonPressed), for: .touchUpInside)
        displayFactButton.addTarget(self, action: #selector(displayFactButtonPressed), for: .touchUpInside)
        textField.addTarget(self, action: #selector(textFieldEditingCganged), for: .editingChanged)
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttons = [userNumberButton,
                   randomNumberButton,
                   numberRangeButton,
                   multipleNumberButton]
        userNumberButtonPressed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(NumbersViewController.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(NumbersViewController.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return
        }
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.bounds.origin.y == 0 {
            self.view.bounds.origin.y = keyboardFrame.height
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.bounds.origin.y != 0 {
            self.view.bounds.origin.y = 0
        }
    }
    
    @objc private func userNumberButtonPressed() {
        option = .userNumber
        optionChanged()
        buttonPressed(button: userNumberButton)
    }
    
    @objc private func randomNumberButtonPressed() {
        option = .randomNumber
        optionChanged()
        buttonPressed(button: randomNumberButton)
    }
    
    @objc private func numberInRangeButtonPressed() {
        option = .numberInRange
        optionChanged()
        buttonPressed(button: numberRangeButton)
    }
    
    @objc private func multipleNumbersButtonPressed() {
        option = .multipleNumbers
        optionChanged()
        buttonPressed(button: multipleNumberButton)
    }
    
    @objc private func displayFactButtonPressed() {
        guard textToSearch.corrected.isValidSearchRequest(option: option) else { return }
        updateData(number: textToSearch.corrected)
    }
    
    @objc private func textFieldEditingCganged() {
        guard let text = textField.text else { return }
        textField.text = text.masked(option: option)
        guard let text = textField.text else { return }
        textToSearch = text
    }
    
    private func buttonPressed(button: UIButton) {
        button.backgroundColor = Constants.buttonPressedColor
        button.layer.shadowOpacity = 0
        button.setTitleColor(.white, for: .normal)
        for otherButton in buttons {
            if otherButton != button {
                buttonNotPressed(button: otherButton)
            }
        }
        textField.text = ""
    }
    
    private func buttonNotPressed(button: UIButton) {
        button.backgroundColor = Constants.buttonNotPressedColor
        button.layer.shadowOpacity = 1
        button.setTitleColor(.black, for: .normal)
    }
    
    private func updateData(number: String) {
        numbersFactService.fetchFacts(number: number) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fact):
                if let unwrappedFact = fact {
                    self.fact = NumberFact(text: unwrappedFact.text, number: unwrappedFact.number)
                }
            case .dictionary(let dictionary):
                self.factsDictionary = dictionary
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                let factViewController = FactPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
                self.delegate = factViewController
                self.delegate?.didReceiveFacts(fact: self.fact, factsDictionary: self.factsDictionary)
                self.present(factViewController, animated: true)
            }
        }
    }

    
    private func optionChanged() {
        enterLabel.text = ""
        fact = nil
        factsDictionary = nil
        switch option {
        case .userNumber:
            textField.isHidden = false
            enterLabel.text = Constants.enterLabelTextUserNumber
            guard let text = textField.text else { return }
            textToSearch = text
        case .randomNumber:
            textField.isHidden = true
            textToSearch = "random"
        case .numberInRange:
            enterLabel.text = Constants.enterLabelTextNumberRange
            textField.isHidden = false
            guard let text = textField.text else { return }
            textToSearch = text
        case .multipleNumbers:
            enterLabel.text = Constants.enterLabelTextMultipleNumber
            textField.isHidden = false
            guard let text = textField.text else { return }
            textToSearch = text
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension NumbersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NumbersViewController {
    struct Constants {
        static let buttonPressedColor = UIColor(red: 128/255, green: 54/255, blue: 204/255, alpha: 1)
        static let buttonNotPressedColor = UIColor(red: 245/255, green: 239/255, blue: 251/255, alpha: 1)
        static let enterLabelTextUserNumber = "Enter here:"
        static let enterLabelTextNumberRange = "Enter here in a format \"a..b\", where a < b:"
        static let enterLabelTextMultipleNumber = "Enter here in a format \"a,b,c\":"
    }
}
