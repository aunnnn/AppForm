//
//  FormSection.swift
//  Form
//
//  Created by Wirawit Rueopas on 4/8/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

public final class FormSection {
    
    public var rows: [FormRow] = []
    
    public init(rowsBuilder: (() -> [FormRow])?=nil) {
        self.rows = rowsBuilder?() ?? []
    }
}
