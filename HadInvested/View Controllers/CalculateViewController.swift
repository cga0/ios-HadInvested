//
//  CalculateViewController.swift
//  HadInvested
//
//  Created by Conner on 9/24/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CalculateViewController: UIViewController, NVActivityIndicatorViewable, UITextFieldDelegate {
    let activityData = ActivityData(size: nil,
                                    message: "Calculating...",
                                    messageFont: nil,
                                    messageSpacing: nil,
                                    type: .squareSpin,
                                    color: nil,
                                    padding: nil,
                                    displayTimeThreshold: nil,
                                    minimumDisplayTime: 2,
                                    backgroundColor: .gray,
                                    textColor: nil)

    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var isCrypto: UISwitch!
    
    override func viewDidLoad() {
        amountTextField.delegate = self
    }

    @IBAction func calculate(_ sender: Any) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let symbol = symbolTextField.text,
            let amount = amountTextField.text else { return }
        if segue.identifier == "ShowCalculationSegue" {
            if let calculatedVC = segue.destination as? CalculateResultViewController {
                calculatedVC.amount = amount
                calculatedVC.symbol = symbol
                calculatedVC.isCrypto = isCrypto.isOn
                calculatedVC.datePicker = datePicker
            }
        }
    }
}
