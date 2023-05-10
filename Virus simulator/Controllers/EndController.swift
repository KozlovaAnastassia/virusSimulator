//
//  EndController.swift
//  Virus simulator
//
//  Created by Анастасия on 10.05.2023.
//

import Foundation
import UIKit

class EndController: UIViewController {
    
//MARK: -> outlets
    
    private lazy var labelWin: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.text = "ТЫ ДОЛЖЕН БЫЛ БОРОТЬСЯ СО ЗЛОМ, А НЕ ПРИМКНУТЬ К НЕМУ"
        return label
    }()
    
    private lazy var buttonBack: UIButton = {
      let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("O, нет", for: .normal)
        button.setTitleColor( UIColor.brown, for: .normal)
        button.setTitleColor( UIColor.lightGray, for: .highlighted)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        
       return button
   }()
//MARK: -> viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackground(forImage: "bg1")
        view.addSubview(labelWin)
        view.addSubview(buttonBack)
       setConstraints()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
//MARK: -> selector
    @objc func back() {
        self.dismiss(animated: true)
    }
    
//MARK: -> constaints
    func setConstraints() {
        labelWin.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelWin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelWin.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            labelWin.widthAnchor.constraint(equalToConstant: 300),
            labelWin.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 750),
            buttonBack.widthAnchor.constraint(equalToConstant: 200),
            buttonBack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}


