//
//  ViewController.swift
//  Virus simulator
//
//  Created by Анастасия on 10.05.2023.
//

import UIKit

class TakeDataController: UIViewController {

    weak var delegate: ViewDelegate?
    
    private lazy var groupSize: UITextField = {
         let textField = UITextField()
         textField.placeholder = "Введите кол-во людей в группе"
         textField.clearButtonMode = .always
         textField.backgroundColor = .white
         textField.layer.cornerRadius = 20
         textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
         
         return textField
     }()
     
     private lazy var infectionFactor: UITextField = {
         let textField = UITextField()
         textField.backgroundColor = .white
         textField.layer.cornerRadius = 20
         textField.placeholder = "Введите infection factor"
         textField.clearButtonMode = .always
         textField.clearButtonMode = .whileEditing
         textField.keyboardType = .numberPad
         
         return textField
     }()
    
    private lazy var timeToRecalculate: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 20
        textField.placeholder = "Введите кол-во секунд"
        textField.clearButtonMode = .always
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private lazy var buttonModelation: UIButton = {
        let button = UIButton()
        button.setTitle("Запустить моделирование", for: .normal)
        button.setTitleColor( UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(playModelation), for: .touchUpInside)
        button.backgroundColor = .blue
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .lightGray
        self.navigationItem.hidesBackButton = true
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(groupSize)
        view.addSubview(infectionFactor)
        view.addSubview(timeToRecalculate)
        view.addSubview(buttonModelation)
    }
    
   @objc func playModelation() {
       
       if let groupSize = Int(groupSize.text ?? ""), let infectionFactor = Int(infectionFactor.text ?? ""),  let timeToRecalculate = Int(timeToRecalculate.text ?? ""){
           delegate?.transit(groupSize, infectionFactor, timeToRecalculate)
           navigationController?.popViewController(animated: true)
       } else  {
           let alert = UIAlertController(title: "Внимание!", message: "Не можем начать симуляцию без числовых парметров", preferredStyle: .alert)
           let action = UIAlertAction(title: "Понял, cейчас введу данные", style: .cancel)
           alert.addAction(action)
           present(alert, animated: true)
       }
    }

   private func setConstraints() {
        
        groupSize.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupSize.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            groupSize.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            groupSize.widthAnchor.constraint(equalToConstant: 320),
            groupSize.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        infectionFactor.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infectionFactor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infectionFactor.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            infectionFactor.widthAnchor.constraint(equalToConstant: 320),
            infectionFactor.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        timeToRecalculate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeToRecalculate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeToRecalculate.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            timeToRecalculate.widthAnchor.constraint(equalToConstant: 320),
            timeToRecalculate.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        buttonModelation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonModelation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonModelation.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            buttonModelation.widthAnchor.constraint(equalToConstant: 250),
            buttonModelation.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

