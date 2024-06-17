//
//  FactViewController.swift
//  InterestingNumbers
//
//  Created by Екатерина Токарева on 11/03/2023.
//

import UIKit
import InterestingNumbersLibrary

final class FactViewController: UIViewController {
    private var number: Double = 0
    private var text: String = ""
    weak var delegate: FactViewControllerDelegate?
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var factLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(number: number, fact: text)
        layout()
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    private func setup(number: Double, fact: String) {
        self.numberLabel.text = String(format: "%.0f", number)
        self.factLabel.text = fact
        view.backgroundColor = Constants.backgroundColor
    }
    
    private func layout() {
        view.addSubview(numberLabel)
        view.addSubview(factLabel)
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.heightAnchor.constraint(equalToConstant: 38),
            factLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            factLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            factLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func closeButtonAction() {
        delegate?.closeButtonTapped()
    }
}

extension FactViewController {
    struct Constants {
        static let backgroundColor = UIColor(red: 128/255, green: 54/255, blue: 204/255, alpha: 1)
    }
}

extension FactViewController: FactDataDelegate {
    func didReceiveFacts(fact: NumberFact?, factsDictionary: [String : String]?) {
        guard let fact = fact else { return }
        self.number = fact.number
        self.text = fact.text
    }
}

extension FactViewController {
    func getNumber() -> Double {
        number
    }
}
