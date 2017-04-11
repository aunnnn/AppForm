//
//  FormRow.swift
//  Form
//
//  Created by Wirawit Rueopas on 4/7/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

public final class FormRow {
    
    // MARK: Core
    public let tag: String
    public let cellSource: FormRowCellSource
    public var value: Any?
    
    public init(tag: String, cellSource: FormRowCellSource, value: Any?=nil) {
        self.tag = tag
        self.cellSource = cellSource
        self.value = value
        
        // Can configure later as needed
        self.cellLayoutConfiguration = CellLayoutConfiguration()
        self.cellAppearanceConfiguration = CellAppearanceConfiguration()
    }
    
    // MARK: Cell Configurations
    public var cellLayoutConfiguration: CellLayoutConfiguration
    public var cellAppearanceConfiguration: CellAppearanceConfiguration
}

// MARK:- RowCellType
/// Type of FormBaseCell (UITableViewCell) for Row. Conforms to this with enum.
public protocol FormRowCellSource {
    var with: (cellClass: FormBaseCell.Type, nibName: String?) { get }
}

// MARK:- Configurations
public extension FormRow {
    
    public struct CellLayoutConfiguration {
        public var estimatedRowHeight: CGFloat
        public var rowHeight: CGFloat
        
        public init() {
            self.estimatedRowHeight = 44
            self.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    public struct CellAppearanceConfiguration {
        
        public enum SeparatorStyle {
            case none
            case fullWidth
        }
        
        public var separatorStyle: SeparatorStyle
        public var setupBlock: ((FormBaseCell, FormRow) -> Void)? = nil
        
        public init() {
            self.separatorStyle = .none
        }
    }
}

// MARK:- Utilities

fileprivate struct SpacingRowCellSource: FormRowCellSource {
    var with: (cellClass: FormBaseCell.Type, nibName: String?) {
        return (FormBaseCell.self, nil)
    }
}

fileprivate let spacingRowCellSource = SpacingRowCellSource()

public extension FormRow {
    
    /// Return empty FormRow with specified rowHeight (plain FormBaseCell). Ideal for vertical spacing.
    static func spacing(height: CGFloat) -> FormRow {
        let row = FormRow(tag: "_spacing\(height)", cellSource: spacingRowCellSource)
        row.cellLayoutConfiguration.rowHeight = height
        row.cellLayoutConfiguration.estimatedRowHeight = height
        return row
    }
}
