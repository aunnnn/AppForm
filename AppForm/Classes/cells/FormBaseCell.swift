//
//  FormBaseCell.swift
//  AppForm
//
//  Created by Wirawit Rueopas on 4/9/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

open class FormBaseCell: UITableViewCell {
    
    /// Associated Row of the cell. Setting this will trigger update() automatically.
    public var row: FormRow? {
        didSet {
            self.update()
            self.layoutIfNeeded()
        }
    }
    
    public weak var formViewController: FormViewController?
    
    required public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard let row = self.row else { return }
        switch row.cellAppearanceConfiguration.separatorStyle {
        case .none:
            self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
        case .fullWidth:
            self.separatorInset = UIEdgeInsets.zero
        }
    }
    
    /// Setup views, called only once.
    open func configure() {

    }
    
    /// Update cell with a new row descriptor.
    open func update() {
        
    }

    /// Element to become active on cell tap.
    open func firstResponderElement() -> UIResponder? {
        return nil
    }
}

/// Specifying type of value of Row to access it conveniently through 'rowValue'
public protocol FormRowValueTypeAccessible {
    associatedtype ValueType
}

public extension FormRowValueTypeAccessible where Self: FormBaseCell {
    
    /// Value casted with type specified in the protocol
    var rowValue: ValueType? {
        if let value = self.row?.value {
            if let typedValue = value as? ValueType {
                return typedValue
            } else {
                assertionFailure("Wrong ValueType. Expect '\(ValueType.self)', but found '\(type(of: value))'.")
                return nil
            }
        } else {
            return nil
        }
    }
}
