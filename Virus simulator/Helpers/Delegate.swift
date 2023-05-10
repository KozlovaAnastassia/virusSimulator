//
//  Delegate.swift
//  Virus simulator
//
//  Created by Анастасия on 10.05.2023.
//

import Foundation

protocol ViewDelegate: AnyObject {
    func transit(_ groupSize: Int, _ infectionFactor: Int, _ time: Int)
}
