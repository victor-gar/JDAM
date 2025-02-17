//
//  CategoryScreenView.swift
//  JDAM
//
//  Created by Вячеслав on 11.02.2025.
//

import UIKit

fileprivate enum Constants {
    static let buttonHeightAndWith: Int = Int(UIScreen.main.bounds.width * 0.4)
    static let upY: Int = Int(UIScreen.main.bounds.height * 0.20)
    static let middleY: Int = Int(UIScreen.main.bounds.height * 0.45)
    static let downY: Int = Int(UIScreen.main.bounds.height * 0.70)
    static let firstX: Int = Int(UIScreen.main.bounds.width * 0.07)
    static let secondX: Int = Int(UIScreen.main.bounds.width * 0.55)
}

enum QuestionCategory1 {
    case ОРазном
    case СпортИХобби
    case ПроЖизнь
    case Знаменитости
    case ИскусствоИКино
    case Природа
}



final class CategoryScreen: UIViewController {
    
    var choosenCategory: [QuestionCategory1] = []
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9568627451, blue: 0.9333333333, alpha: 1)
        setupUI()
    }
    
    private func setupUI() {
        addBackgroundImage()
        addButtons()
    }
    
    private func addBackgroundImage() {
        let backgroundImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "Topographic 3"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.bounds
    }
    
    private func addButtons() {
        let button1 = CategoryButton(frame: CGRect(x: Constants.firstX, y: Constants.upY, width: Constants.buttonHeightAndWith, height: Constants.buttonHeightAndWith), text: "О Разном", imageName: "Smile Square", isActive: true, questionCategory: .ОРазном)
        let button2 = CategoryButton(frame: CGRect(x: Constants.secondX, y: Constants.upY, width: Constants.buttonHeightAndWith, height: Constants.buttonHeightAndWith), text: "Спорт и Хобби", imageName: "image 2", isActive: false, questionCategory: .СпортИХобби)
        let button3 = CategoryButton(frame: CGRect(x: Constants.firstX, y: Constants.middleY, width: Constants.buttonHeightAndWith, height: Constants.buttonHeightAndWith), text: "Про Жизнь", imageName: "image 11", isActive: true, questionCategory: .ПроЖизнь)
        let button4 = CategoryButton(frame: CGRect(x: Constants.secondX, y: Constants.middleY, width: Constants.buttonHeightAndWith, height: Constants.buttonHeightAndWith), text: "Знаменитости", imageName: "image 4", isActive: true, questionCategory: .Знаменитости)
        let button5 = CategoryButton(frame: CGRect(x: Constants.firstX, y: Constants.downY, width: Constants.buttonHeightAndWith, height: Constants.buttonHeightAndWith), text: "Искусство и Кино", imageName: "image 5", isActive: false, questionCategory: .ИскусствоИКино)
        let button6 = CategoryButton(frame: CGRect(x: Constants.secondX, y: Constants.downY, width: Constants.buttonHeightAndWith, height: Constants.buttonHeightAndWith), text: "Природа", imageName: "image 6", isActive: false, questionCategory: .Природа)
        button1.addTarget(self, action: #selector(didTapCategoryButton), for: .touchUpInside)
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(button5)
        view.addSubview(button6)
    }
    
    @objc func didTapCategoryButton(_ sender: CategoryButton) {
        sender.toggle()
        if sender.isActive {
            choosenCategory.append(sender.questionCategory)
        } else {
            
        }
        
    }
}



final class CategoryButton: UIButton {
    
    let text: String
    let imageName: String
    let questionCategory: QuestionCategory1
    var isActive: Bool
    let checkImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
    
    
    init(frame: CGRect, text: String, imageName: String, isActive: Bool, questionCategory: QuestionCategory1) {
        self.text = text
        self.imageName = imageName
        self.isActive = isActive
        self.questionCategory = questionCategory
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        self.text = ""
        self.imageName = ""
        self.isActive = false
        self.questionCategory = .Знаменитости
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        // Устанавливаем цвет фона
        backgroundColor = isActive ? #colorLiteral(red: 0.7495060563, green: 0.9881523252, blue: 0.7054964304, alpha: 1) : #colorLiteral(red: 0.9176470588, green: 0.9058823529, blue: 0.8588235294, alpha: 1)
        // Закругляем углы
        layer.cornerRadius = 20
        //возможно для тени нужно будет выставить в фолс
        clipsToBounds = true

        // Добавляем иконку
        let iconImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.tintColor = .black
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем чекбокс
        
        checkImageView.tintColor = .black
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        if isActive {
            checkImageView.isHidden = false
        } else {
            checkImageView.isHidden = true
        }
        
        // Создаём заголовок
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем элементы на кнопку
        self.addSubview(iconImageView)
        self.addSubview(checkImageView)
        self.addSubview(titleLabel)

        // Добавляем констрейнты
        NSLayoutConstraint.activate([
            // Чекбокс в верхнем левом углу
            checkImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            checkImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            checkImageView.widthAnchor.constraint(equalToConstant: 30),
            checkImageView.heightAnchor.constraint(equalToConstant: 30),
            
            // Иконка в центре
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            
            // Текст внизу
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func toggle() {
        isActive.toggle()
        backgroundColor = isActive ? #colorLiteral(red: 0.7495060563, green: 0.9881523252, blue: 0.7054964304, alpha: 1) : #colorLiteral(red: 0.9176470588, green: 0.9058823529, blue: 0.8588235294, alpha: 1)
        checkImageView.isHidden = !isActive
    }
}
