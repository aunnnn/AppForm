//
//  FormViewController.swift
//  AppForm
//
//  Created by Wirawit Rueopas on 4/8/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

open class FormViewController: UIViewController {
    
    public let tableView: UITableView
    
    fileprivate var registeredNibs: [String] = []
    
    public var form = Form()
    
    /// If true (default), each FormRow's estimatedRowHeight will be updated with actual value after displaying the cell.
    public var updateEstimatedRowHeights = true
    
    /// If true, the keyboard will be hidden on table view scroll. Default is false.
    public var hidesKeyboardOnScroll = false
    
    /// If true (default), tableview will hides keyboard on tap.
    public var hidesKeyboardOnTap = true
    
    /// If true (default), tableview will hide trailing empty cells separators.
    public var hidesTrailingEmptyRowSeparators = true
    
    /// If true, will adjust tableview insets to make its content at the center.
    /// Note that if contentSize is more than tableview's bound, it will reset to insets with all zeros.
    /// Default is false.
    public var centersContentIfPossible = false
    
    private var previousTableViewContentInset: UIEdgeInsets?
    private weak var previousActiveResponder: UIResponder?
    
    public func getRow(indexPath: IndexPath) -> FormRow {
        return form.sections[indexPath.section].rows[indexPath.row]
    }
    
    public init(style: UITableViewStyle) {
        self.tableView = UITableView(frame: .zero, style: style)
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.tableView = UITableView(frame: .zero, style: .plain)
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
        
        do {
            let tableView = self.tableView
            
            self.view.addSubview(tableView)
            tableView.frame = self.view.bounds
            tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnTableView))
            tapGesture.numberOfTapsRequired = 1
            tableView.addGestureRecognizer(tapGesture)
            tableView.dataSource = self
            tableView.delegate = self
            
            if hidesTrailingEmptyRowSeparators {
                tableView.tableFooterView = UIView(frame: .zero)
            }
        }
    }
    
    func didTapOnTableView() {
        guard hidesKeyboardOnTap else { return }
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Centering Content
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard centersContentIfPossible else { return }
        self.centerTableView(with: self.view.bounds.size)
    }
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard centersContentIfPossible else { return }
        self.centerTableView(with: size)
    }
    
    private func centerTableView(with tableSize: CGSize) {
        let tableVerticalInset = (tableSize.height - self.tableView.contentSize.height)/2
        if tableVerticalInset < 0 {
            self.tableView.contentInset = .zero
            return
        }
        let inset = UIEdgeInsets(top: tableVerticalInset,
                                 left: 0,
                                 bottom: tableVerticalInset,
                                 right: 0)
        self.tableView.contentInset = inset
    }
    
    // MARK: Keyboard Notifications
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        // if keyboard is up for the first time
        // E.g., tapping other textfields while keyboard was shown will also trigger this notification.
        guard previousActiveResponder == nil else { return }
        guard let info = notification.userInfo else { return }
        guard let kbFrame = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let responderView = UIResponder.firstResponder() else { return }
        
        /* Adjust tableview's inset */
        previousActiveResponder = responderView
        let keyboardFrame = tableView.convert(kbFrame, from: nil)
        let intersection = keyboardFrame.intersection(tableView.bounds)
        guard !intersection.isNull else { return }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: intersection.height + 8, right: 0)
        self.previousTableViewContentInset = self.tableView.contentInset
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        self.previousActiveResponder = nil
        UIView.animate(withDuration: 0.2) {
            self.tableView.contentInset = self.previousTableViewContentInset ?? .zero
            self.tableView.scrollIndicatorInsets = .zero
        }
    }
}

extension FormViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDatasource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return form.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = getRow(indexPath: indexPath)
        let cell: FormBaseCell
        
        do /* Retrieving Cell */ {
            
            let cellClass = row.cellSource.with.cellClass
            let nibName = row.cellSource.with.nibName
            let reuseId = "\(cellClass)"
            
            // Register nib if not yet
            if let nibName = nibName, !registeredNibs.contains(nibName) {
                // first time register nib
                let nib = UINib(nibName: nibName, bundle: Bundle.main)
                tableView.register(nib, forCellReuseIdentifier: reuseId)
                registeredNibs.append(nibName)
            }
            
            // Initialisation
            if let reusedCell = tableView.dequeueReusableCell(withIdentifier: reuseId) as? FormBaseCell {
                cell = reusedCell
            } else {
                let newCell = cellClass.init(style: .default, reuseIdentifier: reuseId)
                newCell.configure()
                cell = newCell
            }
        }
        
        do /* Appearances */ {
            row.cellAppearanceConfiguration.setupBlock?(cell, row)
        }
        cell.formViewController = self
        cell.row = row
        return cell
    }
    
    // MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = getRow(indexPath: indexPath)
        return row.cellLayoutConfiguration.estimatedRowHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = getRow(indexPath: indexPath)
        return row.cellLayoutConfiguration.rowHeight
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard updateEstimatedRowHeights else { return }
        let row = getRow(indexPath: indexPath)
        let newEstimatedHeight = cell.bounds.height
        row.cellLayoutConfiguration.estimatedRowHeight = newEstimatedHeight
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard hidesKeyboardOnScroll else { return }
        self.view.endEditing(true)
    }
}

private weak var currentFirstResponder: UIResponder?

extension UIResponder {
    
    static func firstResponder() -> UIResponder? {
        currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(self.findFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return currentFirstResponder
    }
    
    func findFirstResponder(sender: AnyObject) {
        currentFirstResponder = self
    }
    
}
