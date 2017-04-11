//
//  ViewController.swift
//  TryAppFormPod
//
//  Created by Wirawit Rueopas on 4/10/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit
import AppForm

class ViewController: FormViewController {

    override func viewDidLoad() {
        self.form = Form(rowsBuilder: { () -> [FormRow] in
            let lb = FormRow(tag: "lb", cellSource: CellSource.Label)
            lb.value = "AppForm Demo"
            
            let usr = FormRow(tag: "usr", cellSource: CellSource.TextField)
            let pwd = FormRow(tag: "pwd", cellSource: CellSource.TextField)
            
            let login = FormRow(tag: "login", cellSource: CellSource.CenteredButton)
            login.value = "Login"
            login.cellLayoutConfiguration.estimatedRowHeight = 44
            login.cellLayoutConfiguration.rowHeight = 44
            
            let register = FormRow(tag: "register", cellSource: CellSource.CenteredButton)
            register.value = "Register"
            
            let note = FormRow(tag: "lb", cellSource: CellSource.Label)
            note.value = "Hey! I'm aunnnn, developer of this library. This is just a rambling note to add something at the bottom.\nThis will be on the newline."
            
            let spc8 = FormRow.spacing(height: 8)
            let spc12 = FormRow.spacing(height: 12)
            let spc64 = FormRow.spacing(height: 64)
            
            let rows = [
                spc64,
                Styles.Logo.on(row: lb),
                spc64,
                Styles.UsernameTextField.on(row: usr),
                spc8,
                Styles.PasswordTextField.on(row: pwd),
                spc8,
                spc12,
                Styles.LoginButton.on(row: login),
                spc12,
                Styles.RegisterButton.on(row: register),
                FormRow.spacing(height: 8).separator(style: .default),
                spc64,
                Styles.Note.on(row: note),
            ]
            
            return rows
        })
        super.viewDidLoad()
        
        self.centersContentIfPossible = true
    }
}
