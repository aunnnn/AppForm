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
            
            let register = FormRow(tag: "register", cellSource: CellSource.CenteredButton)
            register.value = "Register"
            
            let spc8 = FormRow.spacing(height: 8)
            let spc12 = FormRow.spacing(height: 12)
            let spc64 = FormRow.spacing(height: 64)
            
            let rows = [
                Styles.Logo.on(row: lb),
                spc64,
                Styles.UsernameTextField.on(row: usr),
                spc8,
                Styles.PasswordTextField.on(row: pwd),
                spc8,
                spc8,
                Styles.LoginButton.on(row: login),
                spc12,
                Styles.RegisterButton.on(row: register),
                spc8,
            ]
            
            return rows
        })
        super.viewDidLoad()
        
        self.centersContentIfPossible = true
    }
}
