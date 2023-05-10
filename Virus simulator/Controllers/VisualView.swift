//
//  VisualView.swift
//  Virus simulator
//
//  Created by Анастасия on 10.05.2023.
//

import Foundation
import UIKit

class VisualView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var groupSizeOnView: Int?
    var timeOnView: Double?
    var infectionFactorOnView: Int?
    var infactionedCount = 0
    
    var  arraySelected = [IndexPath]()
    var timer = Timer()
    
    private lazy var buttonStart: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.setTitleColor( UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(enterData), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var labelinfection: UILabel = {
        let label = UILabel()
        label.text = "Кол-во зараженных: \(infactionedCount)"
        label.isHidden = true
        return label
    }()
    
    @objc func enterData() {
        
        let vc = TakeDataController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
        buttonStart.isHidden = true
        collectionView.isHidden = false
        labelinfection.isHidden = false
    }
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 30, y: 170, width: 320, height: 600), collectionViewLayout: flowLayout)
        collectionView.isHidden = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setCollectionView()
        view.addSubview(buttonStart)
        view.addSubview(labelinfection)
        setConstraints()
        timeRefresh()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupSizeOnView ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if cell?.backgroundColor != .red {
                cell?.backgroundColor = .red
            arraySelected.append(indexPath)
            infactionedCount += 1
            cell?.isUserInteractionEnabled = true
        }
    }
    
    private func timeRefresh(){
        timer = Timer.scheduledTimer(timeInterval: timeOnView ?? 1, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)

    }
    
    @objc func refreshData() {
        convertHealthyToSick(selectedItems: arraySelected, infectionFactor: infectionFactorOnView ?? 0, collectionView: collectionView)
        labelinfection.text  = "Кол-во зараженных: \(infactionedCount)"
        
        if infactionedCount == groupSizeOnView {
            theEnd()
        }
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }
    
    
    private func convertHealthyToSick(selectedItems: [IndexPath], infectionFactor: Int, collectionView: UICollectionView) {
        let newSickItems = selectedItems
        // Update neighboring healthy cells to become sick based on infection factor
        for indexPath in newSickItems {
            let row = indexPath.row
            let column = indexPath.section
            var infectedCount = 0
        // Check if neighboring cells are healthy or already infected
        for i in max(0, row - 1)...min(row + 1, collectionView.numberOfItems(inSection: column) - 1) {
            for j in max(0, column - 1)...min(column + 1, collectionView.numberOfSections - 1) {
                if i == row && j == column { continue }
                let indexPath = IndexPath(item: i, section: j)
                if selectedItems.contains(indexPath) { continue }
                let cell = collectionView.cellForItem(at: indexPath)
                
                if cell?.backgroundColor != UIColor.red {
                    let random = Int.random(in: 1...(infectionFactorOnView ?? 0))
                    if random <= infectionFactor {
                        cell?.backgroundColor = UIColor.red
                        infactionedCount += 1
                        infectedCount += 1
                    }
                }
                if infectedCount >= infectionFactor { break }
            }
            if infectedCount >= infectionFactor { break }
        }}}
    
    private func theEnd() {
        DispatchQueue.main.async {
            let newController = EndController()
            newController.modalPresentationStyle = .fullScreen
            self.present(newController, animated: true, completion: nil)
            
                for cell in self.collectionView.visibleCells {
                cell.backgroundColor = .green
                cell.isUserInteractionEnabled = true
                    self.arraySelected = [IndexPath]()
            }
                self.infactionedCount = 0
            
        }
    }
    
    private func setConstraints() {
         
        buttonStart.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            buttonStart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStart.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            buttonStart.widthAnchor.constraint(equalToConstant: 200),
            buttonStart.heightAnchor.constraint(equalToConstant: 50)
         ])
         
        labelinfection.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            labelinfection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelinfection.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            labelinfection.widthAnchor.constraint(equalToConstant: 300),
            labelinfection.heightAnchor.constraint(equalToConstant: 100)
         ])
         
     }
}

extension VisualView: ViewDelegate {
    func transit(_ groupSize: Int, _ infectionFactor: Int, _ time: Int) {
        groupSizeOnView = groupSize
        timeOnView = Double(time)
        infectionFactorOnView = infectionFactor
        collectionView.reloadData()
    }
}
