# AppForm
A framework to easily reuse and compose UITableViewCells across an app.

## Why
To reuse views across the app, you need to do all setups and apply styles all over the places. This framework forces you to make views as UITableViewCells instead, and it will populate them into UITableView for you.
With UITableView, you easily get:
- Reusable views
- Scrollable by default
- Keyboard handling

## Overview
Inspired by [SwiftForms](https://github.com/ortuman/SwiftForms), AppForm allows you to build forms in declarative manner. 
In contrast to [SwiftForms](https://github.com/ortuman/SwiftForms), AppForm is designed to be more general, not just for making forms, but most views in the app.
For that purpose, the library doesn't come with any ready-made UITableViewCells for you, as every apps have their own custom views.

The framework consists of 3 main models: Form, FormSection, FormRow.
The most important model is FormRow. It contains everything from data to layout configuration, which will be used and interpreted by FormBaseCell (a subclass of UITableViewCell).

FormRowCellSource: a protocol that knows how to create cells, either by Nibs or custom classes.
FormRowAppearanceSource: a protocol that knows how to configure FormBaseCell.

## Demo
See a demo project "TryAppForm" inside the repo for recommended usages.

## Requirements
- iOS 8.0+
- Xcode 8+
- Swift 3

## Contact
Any suggestions and improvements are very welcome.
aun.rueopas@gmail.com, Wirawit Rueopas
