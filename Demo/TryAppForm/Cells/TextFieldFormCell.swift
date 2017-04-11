//
//  TextFieldFormCell.swift
//  TryAppFormPod
//
//  Created by Wirawit Rueopas on 4/10/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit
import AppForm

class TextFieldFormCell: FormBaseCell, FormRowValueTypeAccessible {
    
    typealias ValueType = String

    @IBOutlet weak var textField: UITextField!
    
    override func configure() {
        textField.addTarget(self, action: #selector(self.valueChanged), for: .editingChanged)
    }
    
    override func update() {
        textField.text = self.rowValue
    }
    
    func valueChanged() {
        self.rowValue = textField.text
    }
}
