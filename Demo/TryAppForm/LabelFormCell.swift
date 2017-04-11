//
//  LabelFormCell.swift
//  TryAppFormPod
//
//  Created by Wirawit Rueopas on 4/10/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit
import AppForm

class LabelFormCell: FormBaseCell, FormRowValueTypeAccessible {
    
    typealias ValueType = String
    
    @IBOutlet weak var label: UILabel!
    
    override func update() {
        self.label.text = self.rowValue
    }
}
