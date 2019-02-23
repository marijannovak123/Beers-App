//
//  UIState.swift
//  ios learning
//
//  Created by UHP Digital Mac 3 on 01.02.19.
//  Copyright © 2019 Marijan. All rights reserved.
//

import Foundation
import UIKit

enum ViewState {
    case loading
    case content
    case error(_ message: String)
    case info(_ message: String)
    case navigate(to: Screen)
    case customEvent(_ event: Event)
}

enum Event {
    
}
