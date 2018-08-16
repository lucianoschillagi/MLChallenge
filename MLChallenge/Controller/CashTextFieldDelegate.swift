//
//  CashTextFieldDelegate.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 13/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

import UIKit

// MARK: - CashTextFieldDelegate: NSObject, UITextFieldDelegate

class CashTextFieldDelegate: NSObject, UITextFieldDelegate {
	
	static var montoSeleccionado: String = ""
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		let oldText = textField.text! as NSString
		var newText = oldText.replacingCharacters(in: range, with: string)
		var newTextString = String(newText)
		
		let digits = CharacterSet.decimalDigits
		var digitText = ""
		for c in (newTextString.unicodeScalars) {
			if digits.contains(UnicodeScalar(c.value)!) {
				digitText.append("\(c)")
			}
		}
		
		
		
		// Format the new string
		if let numOfPennies = Int(digitText) {
			newText = "$" + self.dollarStringFromInt(numOfPennies) + "." + self.centsStringFromInt(numOfPennies)
		} else {
			newText = "$0.00"
		}
		
		textField.text = newText
		
		debugPrint("el monto ingresdo es de \(newText)")
	
		newText.removeFirst()
		debugPrint(newText)
		CashTextFieldDelegate.montoSeleccionado = newText
		debugPrint("el monto seleccionado a pasar en la solictiud es \(CashTextFieldDelegate.montoSeleccionado)")
		MercadoPagoClient.ParameterValues.Amount = CashTextFieldDelegate.montoSeleccionado // 🔌👏
		debugPrint("🍎el monto seleccionado a pasar en la solictiud es \(MercadoPagoClient.ParameterValues.Amount)")
		

		
		return false
	}
	
	
	
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if textField.text!.isEmpty {
			textField.text = "$0.00"
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		
		return true;
	}
	
	func dollarStringFromInt(_ value: Int) -> String {
		return String(value / 100)
	}
	
	func centsStringFromInt(_ value: Int) -> String {
		
		let cents = value % 100
		var centsString = String(cents)
		
		if cents < 10 {
			centsString = "0" + centsString
		}
		
		return centsString
	}
	
	
	
	
	
	
	

}
