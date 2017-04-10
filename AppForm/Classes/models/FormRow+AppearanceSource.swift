//
//  FormRow+AppearanceSource.swift
//  AForm
//
//  Created by Wirawit Rueopas on 4/10/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

/// Configure cell styles. Conforms to this with enum.
public protocol FormRowAppearanceSource {
    func configure(cell: FormBaseCell) -> Void
}

// Belows are just syntatic sugar to set value
public extension FormRowAppearanceSource {
    /// Apply styles on FormRow.
    func on(row: FormRow) -> FormRow {
        row.cellAppearanceConfiguration.setupBlock = self.configure
        return row
    }
}

public extension FormRow {
    /// Apply styles on FormRow.
    public func styles(as style: FormRowAppearanceSource) -> FormRow {
        self.cellAppearanceConfiguration.setupBlock = style.configure
        return self
    }
    
    public func separator(style: CellAppearanceConfiguration.SeparatorStyle) -> FormRow {
        self.cellAppearanceConfiguration.separatorStyle = style
        return self
    }
}
