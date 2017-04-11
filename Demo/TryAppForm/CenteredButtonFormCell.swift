//
//  CenteredButtonFormCell.swift
//  TryAppFormPod
//
//  Created by Wirawit Rueopas on 4/10/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit
import AppForm

class CenteredButtonFormCell: FormBaseCell, FormRowValueTypeAccessible {

    typealias ValueType = String
    
    @IBOutlet weak var button: UIButton!
    
    override func update() {
        button.setTitle(self.rowValue, for: .normal)
    }
}
