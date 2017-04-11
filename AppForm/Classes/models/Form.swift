//
//  Form.swift
//  AppForm
//
//  Created by Wirawit Rueopas on 4/8/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

public class Form {
    
    public var sections: [FormSection] = []
    
    public init(sectionsBuilder: (() -> [FormSection])?=nil) {
        self.sections = sectionsBuilder?() ?? []
    }
    
    /// Convenience for single section form.
    public convenience init(rowsBuilder: () -> [FormRow]) {
        self.init()
        let section = FormSection()
        section.rows = rowsBuilder()
        self.sections = [section]
    }
    
    /// Returns dictionary of [tag: value]
    public func formValues() -> [String : Any] {
        var formValues: [String : Any] = [:]
        for section in sections {
            for row in section.rows {
                if let value = row.value {
                    formValues[row.tag] = value
                }
            }
        }
        return formValues
    }
    
    public func row(withTag tag: String) -> FormRow? {
        for s in sections {
            for r in s.rows {
                if r.tag == tag {
                    return r
                }
            }
        }
        return nil
    }
}
