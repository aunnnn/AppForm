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
            lb.value = "App Form"
            
            let usr = FormRow(tag: "usr", cellSource: CellSource.TextField)
            let pwd = FormRow(tag: "pwd", cellSource: CellSource.TextField)
            
            let login = FormRow(tag: "login", cellSource: CellSource.CenteredButton)
            login.value = "Login"
            
            let register = FormRow(tag: "register", cellSource: CellSource.CenteredButton)
            register.value = "Register"
            
            let spc8 = FormRow(tag: "spc8", cellSource: CellSource.Spacing)
            spc8.cellLayoutConfiguration.estimatedRowHeight = 8
            spc8.cellLayoutConfiguration.rowHeight = 8
            
            let rows = [
                Styles.CenteredTextLabel.on(row: lb),
                spc8,
                Styles.UsernameTextField.on(row: usr),
                spc8,
                Styles.PasswordTextField.on(row: pwd),
                spc8,
                spc8,
                Styles.LoginButton.on(row: login),
                spc8,
                Styles.RegisterButton.on(row: register),
                spc8,
                Styles.RegisterButton.on(row: register),
                spc8,
                Styles.UsernameTextField.on(row: usr),
            ]
            
            return rows
        })
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.tableFooterView = UIView(frame: .zero)
//        self.tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.centerTableView(viewSize: self.view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.centerTableView(viewSize: size)
    }
    
    private func centerTableView(viewSize: CGSize) {
        let tableInset = (viewSize.height - self.tableView.contentSize.height)/2
        if tableInset < 0 { return }
        return
        let inset = UIEdgeInsets(top: tableInset, left: 0, bottom: tableInset, right: 0)
        self.tableView.contentInset = inset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

fileprivate enum CellSource: FormRowCellSource {
    
    case Label
    case CenteredButton
    case TextField
    
    case Spacing
    
    var with: (cellClass: FormBaseCell.Type, nibName: String?) {
        switch self {
        case .Label: return (LabelFormCell.self, "LabelFormCell")
        case .CenteredButton: return (CenteredButtonFormCell.self, "CenteredButtonFormCell")
        case .Spacing: return (FormBaseCell.self, nil)
        case .TextField: return (TextFieldFormCell.self, "TextFieldFormCell")
        }
    }
}

fileprivate enum Styles: FormRowAppearanceSource {
    
    case LoginButton, RegisterButton
    case CenteredTextLabel
    case UsernameTextField, PasswordTextField
    
    fileprivate func configure(cell: FormBaseCell) {
        switch cell {
        case let cell as CenteredButtonFormCell:
            cell.button.setTitleColor(UIColor.white, for: .normal)
            cell.button.setTitleColor(UIColor.lightGray, for: .highlighted)
            
            switch self {
            case .LoginButton:
                cell.button.backgroundColor = .blue
            case .RegisterButton:
                cell.button.backgroundColor = .green
            default:
                break
            }
        case let cell as LabelFormCell:
            switch self {
            case .CenteredTextLabel:
                cell.label.textAlignment = .center
            default:
                break
            }
        case let cell as TextFieldFormCell:
            switch self {
            case .UsernameTextField:
                cell.textField.placeholder = "Username"
            case .PasswordTextField:
                cell.textField.placeholder = "Password"
            default:
                break
            }
        
        default:
            assertionFailure("Invalid cell type.")
        }
    }
}
