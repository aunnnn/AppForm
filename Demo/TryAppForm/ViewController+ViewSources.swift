//
//  ViewController+ViewSources.swift
//  TryAppForm
//
//  Created by Wirawit Rueopas on 4/12/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit
import AppForm

extension ViewController {
    enum CellSource: FormRowCellSource {
        
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
    
    enum Styles: FormRowAppearanceSource {
        
        case Logo
        case LoginButton, RegisterButton
        case UsernameTextField, PasswordTextField
        case Note
        
        func configure(cell: FormBaseCell, row: FormRow) {
            
            switch cell {
            case let cell as CenteredButtonFormCell:
                cell.button.setTitleColor(UIColor.white, for: .normal)
                cell.button.setTitleColor(UIColor.lightGray, for: .highlighted)
                
                switch self {
                case .LoginButton:
                    cell.button.backgroundColor = UIColor(red: 0.129, green: 0.431, blue: 0.831, alpha: 1)
                case .RegisterButton:
                    let attrs: [String: Any] = [
                        NSFontAttributeName: UIFont.systemFont(ofSize: 18),
                        NSForegroundColorAttributeName: UIColor.gray,
                        NSUnderlineStyleAttributeName: 1
                    ]
                    
                    let attrsH: [String: Any] = [
                        NSFontAttributeName: UIFont.systemFont(ofSize: 18),
                        NSForegroundColorAttributeName: UIColor.darkGray,
                        NSUnderlineStyleAttributeName: 1
                    ]
                    let title = (row.value as? String) ?? "-"
                    let attrString = NSMutableAttributedString(string: title, attributes: attrs)
                    let attrStringH = NSMutableAttributedString(string: title, attributes: attrsH)
                    cell.button.setAttributedTitle(attrString, for: .normal)
                    cell.button.setAttributedTitle(attrStringH, for: .highlighted)
                    cell.button.backgroundColor = .clear
                default:
                    assertionFailure("Invalid cell type.")
                }
                
            case let cell as LabelFormCell:
                switch self {
                case .Logo:
                    cell.label.font = UIFont.systemFont(ofSize: 30)
                    cell.label.textAlignment = .center
                case .Note:
                    cell.label.font = UIFont.systemFont(ofSize: 12)
                    cell.label.textAlignment = .center
                    cell.label.numberOfLines = 0
                default:
                    assertionFailure("Invalid cell type.")
                }
                
            case let cell as TextFieldFormCell:
                switch self {
                case .UsernameTextField:
                    cell.textField.placeholder = "Username"
                case .PasswordTextField:
                    cell.textField.placeholder = "Password"
                default:
                    assertionFailure("Invalid cell type.")
                }
                
            default:
                assertionFailure("Invalid cell type.")
            }
        }
    }
}
