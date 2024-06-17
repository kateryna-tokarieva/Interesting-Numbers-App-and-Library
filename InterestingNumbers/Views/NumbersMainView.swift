//
//  NumbersMainView.swift
//  InterestingNumbers
//
//  Created by Екатерина Токарева on 10/03/2023.
//

import UIKit

final class NumbersMainView: UIView {    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    private lazy var diceImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dice.pdf"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var userNumberButton: UIButton = {
        let button = UIButton(type: .system)
        setupButton(button)
        addShadow(button)
        return button
    }()
    lazy var randomNumberButton: UIButton = {
        let button = UIButton(type: .system)
        setupButton(button)
        addShadow(button)
        return button
    }()
    lazy var numberRangeButton: UIButton = {
        let button = UIButton(type: .system)
        setupButton(button)
        addShadow(button)
        return button
    }()
    lazy var multipleNumberButton: UIButton = {
        let button = UIButton(type: .system)
        setupButton(button)
        addShadow(button)
        return button
    }()
    private lazy var buttons: UIView = {
        let view = UIView()
        view.addSubview(userNumberButton)
        view.addSubview(randomNumberButton)
        view.addSubview(numberRangeButton)
        view.addSubview(multipleNumberButton)
        return view
    }()
    lazy var enterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.returnKeyType = UIReturnKeyType.done
        textField.keyboardType = .numbersAndPunctuation
        textField.autocorrectionType = .no
        return textField
    }()
    lazy var displayFactButton: UIButton = {
        let button = UIButton(type: .system)
        setupButton(button)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.tintColor
        return button
    }()
    
    override init(frame: CGRect = UIScreen.main.bounds) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        nameLabel.text = "Interesting Numbers"
        descriptionLabel.text = "This App about facts of Numbers\nand Dates"
        userNumberButton.setTitle("User\nnumber", for: .normal)
        randomNumberButton.setTitle("Random\nnumber", for: .normal)
        numberRangeButton.setTitle("Numbers\nin a range", for: .normal)
        multipleNumberButton.setTitle("Multiple\nnumbers", for: .normal)
        enterLabel.text = "Enter here:"
        displayFactButton.setTitle("Display Fact", for: .normal)
        textField.accessibilityIdentifier = "TEXT_FIELD"
    }
    
    private func layout() {
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(diceImage)
        self.addSubview(buttons)
        self.addSubview(enterLabel)
        self.addSubview(textField)
        self.addSubview(displayFactButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        diceImage.translatesAutoresizingMaskIntoConstraints = false
        buttons.translatesAutoresizingMaskIntoConstraints = false
        userNumberButton.translatesAutoresizingMaskIntoConstraints = false
        randomNumberButton.translatesAutoresizingMaskIntoConstraints = false
        numberRangeButton.translatesAutoresizingMaskIntoConstraints = false
        multipleNumberButton.translatesAutoresizingMaskIntoConstraints = false
        enterLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        displayFactButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Layout name Label
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 88),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            // Layout description
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 53),
            
            // Layout diceImage
            diceImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            diceImage.bottomAnchor.constraint(equalTo: buttons.topAnchor, constant: -10),
            diceImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            diceImage.widthAnchor.constraint(equalTo: diceImage.heightAnchor),
            
            // Layout buttons
            buttons.bottomAnchor.constraint(equalTo: enterLabel.topAnchor, constant: -20),
            buttons.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            buttons.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttons.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            // Layout userNumberButton
            userNumberButton.leftAnchor.constraint(equalTo: buttons.leftAnchor),
            userNumberButton.topAnchor.constraint(equalTo: buttons.topAnchor),
            userNumberButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            userNumberButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            // Layout randomNumberButton
            randomNumberButton.leftAnchor.constraint(equalTo: userNumberButton.rightAnchor, constant: 9),
            randomNumberButton.topAnchor.constraint(equalTo: buttons.topAnchor),
            randomNumberButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            randomNumberButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            // Layout numberRangeButton
            numberRangeButton.leftAnchor.constraint(equalTo: randomNumberButton.rightAnchor, constant: 9),
            numberRangeButton.topAnchor.constraint(equalTo: buttons.topAnchor),
            numberRangeButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            numberRangeButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            // Layout multipleNumberButton
            multipleNumberButton.leftAnchor.constraint(equalTo: numberRangeButton.rightAnchor, constant: 9),
            multipleNumberButton.topAnchor.constraint(equalTo: buttons.topAnchor),
            multipleNumberButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            multipleNumberButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            // Layout displayFactButton
            displayFactButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            displayFactButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            displayFactButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            displayFactButton.heightAnchor.constraint(equalToConstant: 52),
            
            // Layout textField
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: displayFactButton.topAnchor, constant: -20),
            
            // Layout enterLabel
            enterLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            enterLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10),
            enterLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
    
    private func setupButton(_ button: UIButton) {
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .clear
        button.backgroundColor = Constants.buttonColor
        button.layer.cornerRadius = 9
        button.layer.masksToBounds = true
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.clipsToBounds = false
    }
    
    private func addShadow(_ view: UIButton) {
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = Constants.shadowColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
    }
}

extension NumbersMainView {
    struct Constants {
        static let tintColor = UIColor(red: 128/255, green: 54/255, blue: 204/255, alpha: 1)
        static let buttonColor = UIColor(red: 245/255, green: 239/255, blue: 251/255, alpha: 1)
        static let buttonSize: CGFloat = ((UIScreen.main.bounds.width - 40) - 27) / 4
        static let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
    }
}
