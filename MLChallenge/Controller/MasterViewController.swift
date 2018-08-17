//
//  MasterViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
Primer pantalla donde el usuario ingresa el monto de compra.
*/

class MasterViewController: UIViewController {

	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// el monto ingresado por el usuario, capturado a través del text field
	let amount: Double = Double()
	
	static var montoSeleccionado: String = ""
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var amountTextField: UITextField!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// en principio el botón ´siguiente´ está deshabilitado
		setUIEnabled(false)
	}

	override func viewWillAppear(_ animated: Bool) {
		displayRecommendedMessage("Resumen del pago:",configurarElAlertView() )
	}
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	// task: configurar los datos a mostrar como resumen de la compra en el alert view
	func configurarElAlertView() -> String {
		
		// monto
		let monto = "MONTO: $" + MasterViewController.montoSeleccionado
		// tarjeta
		let tarjeta = "TARJETA: " + PayMethodViewController.creditCardChoosen
		// banco
		let banco = "BANCO: " + MercadoPagoClient.ParameterValues.BankName
		// cuotas
		let cuotas = "CUOTAS: " + InstallmentViewController.amountOfFees
		// valor de cada cuota
		let valorCuota = "VALOR CUOTA: " + InstallmentViewController.feeValue
		// total
		let total  = "TOTAL: " + InstallmentViewController.total
		
		let listaResumen = "\(monto) \n \(tarjeta) \n \(banco) \n \(cuotas) \n \(valorCuota) \n \(total)"
		
		return listaResumen
	}
	
	//*****************************************************************
	// MARK: - Alert View
	//*****************************************************************
	/**
	Muestra al usuario un mensaje acerca de cual ha sido el error en el su proceso de logueo.
	
	- Parameter title: El título del error.
	- Parameter message: El mensaje acerca del error.
	
	*/
	func displayRecommendedMessage(_ title: String?, _ message: String?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	//*****************************************************************
	// MARK: - UI Enabled-Disabled
	//*****************************************************************
	
	// task: habilitar o deshabilitar la UI de acuerdo a la lógica de la aplicación
	func setUIEnabled(_ enabled: Bool) {
		nextButton.isEnabled = enabled
		
		// adjust login button alpha
		if enabled {
			nextButton.alpha = 1.0
		} else {
			nextButton.alpha = 0.5
		}
	}

} // end class


//*****************************************************************
// MARK: - Text Field Delegate Methods
//*****************************************************************

extension MasterViewController: UITextFieldDelegate {
	
	// task: preguntar al delegado si el texto especificado debe cambiarse.
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
		if let numOfPesos = Int(digitText) {
			newText = "$" + self.pesoStringFromInt(numOfPesos) + "." + self.centsStringFromInt(numOfPesos)
		} else {
			newText = "$0.00"
		}
		textField.text = newText
		
		
		newText.removeFirst()
		// almacena el monto introducido por el usuario en la propiedad 'montoSeleccionado'
		MasterViewController.montoSeleccionado = newText // 🔌👏
		debugPrint("el monto seleccionado a pasar en la solictiud es \(MasterViewController.montoSeleccionado)")
		
		// y le pasa este valor a 'Amount'
		MercadoPagoClient.ParameterValues.Amount = MasterViewController.montoSeleccionado // 🔌👏
		debugPrint("🍎el monto seleccionado a pasar en la solictiud es \(MercadoPagoClient.ParameterValues.Amount)")
		
		// una vez que el usuario ingresa un valor, el botón de ´siguiente´ se habilita
		setUIEnabled(true)
		
		// si el usuario no ingresó ningún valor, bloquear el paso a la siguiente pantalla
		if textField.text! == "$0.00" {
			setUIEnabled(false)
		}
		
		return false
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		if textField.text!.isEmpty {
			textField.text = "$0.00"

		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	//*****************************************************************
	// MARK: - Text Field Helpers
	//*****************************************************************
	
	func pesoStringFromInt(_ value: Int) -> String {
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

} // end ext
	


