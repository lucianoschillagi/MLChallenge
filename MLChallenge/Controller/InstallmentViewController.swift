//
//  CuotasViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 03/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

class InstallmentViewController: UIViewController {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	var amountOfFeesModel = ["0", "3", "6", "9", "12"]
	
	// la tarjeta de crédito seleccionada en la pantalla anterior
	var creditCardSelected: String!
	
	static var installmentsArray : [Int] = []
	
	static var amountOfFees: String = ""
	
	static var feeValue: String = ""
	
	static var total: String = ""
	
	// esconde la barra de estado
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************

	@IBOutlet weak var summaryButton: UIButton!
	@IBOutlet weak var montoLabel: UILabel!
	@IBOutlet weak var montoValorLabel: UILabel!
	@IBOutlet weak var tarjetaLabel: UILabel!
	@IBOutlet weak var tarjetaValorLabel: UILabel!
	@IBOutlet weak var bancoLabel: UILabel!
	@IBOutlet weak var bancoValorLabel: UILabel!
	@IBOutlet weak var cuotasLabel: UILabel!
	@IBOutlet weak var cuotasValorLabel: UILabel!
	@IBOutlet weak var valorCuotaLabel: UILabel!
	@IBOutlet weak var valorCuotaValorLabel: UILabel!
	@IBOutlet weak var totalLabel: UILabel!
	@IBOutlet weak var totalValorLabel: UILabel!
	
	// el picker view para que el usuario seleccione en cuantas cuotas quiere realizar su pago
	@IBOutlet var amountOfFees: UIPickerView!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setUIEnabled(false)

		// rellena el formulario de compra con los valores anteriormente ingresados por el usuario
		printPartialValuesOfThePurchase()
	}
	

	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	// task: imprimir los valores parciales de la compra en las etiquetas correspondientes
	func printPartialValuesOfThePurchase() {
		tarjetaValorLabel.text = creditCardSelected
		montoValorLabel.text = MasterViewController.montoSeleccionado
		bancoValorLabel.text = MercadoPagoClient.ParameterValues.BankName
	}
	
	//*****************************************************************
	// MARK: - UI Enabled-Disabled
	//*****************************************************************
	
	// task: habilitar o deshabilitar la UI de acuerdo a la lógica de la aplicación
	func setUIEnabled(_ enabled: Bool) {
		summaryButton.isEnabled = enabled
		
		// adjust login button alpha
		if enabled {
			summaryButton.alpha = 1.0
		} else {
			summaryButton.alpha = 0.5
		}
	}


} // end class


//*****************************************************************
// MARK: - Picker View Methods (Data Source & Delegate)
//****************************************************************

extension InstallmentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return amountOfFeesModel.count
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return amountOfFeesModel[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		cuotasValorLabel.text = amountOfFeesModel[row]
		// almacena el valor de la cuota elegida
		InstallmentViewController.amountOfFees = amountOfFeesModel[row]
		
		// si el usuario seleccionó 0 cuotas
		if amountOfFeesModel[row] == "0" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[0]
			totalValorLabel.text = String(Installments.totalAmountArray[0])
			InstallmentViewController.feeValue = valorCuotaValorLabel.text!
			InstallmentViewController.total = totalValorLabel.text!
			
		}
		
		// si el usuario seleccionó 3 cuotas
		if amountOfFeesModel[row] == "3" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[1]
			totalValorLabel.text = String(Installments.totalAmountArray[1])
			InstallmentViewController.feeValue = valorCuotaValorLabel.text!
			InstallmentViewController.total = totalValorLabel.text!
		}
		
		// si el usuario seleccionó 6 cuotas
		if amountOfFeesModel[row] == "6" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[2]
			totalValorLabel.text = String(Installments.totalAmountArray[2])
			InstallmentViewController.feeValue = valorCuotaValorLabel.text!
			InstallmentViewController.total = totalValorLabel.text!
		}
		
		// si el usuario seleccionó 9 cuotas
		if amountOfFeesModel[row] == "9" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[3]
			totalValorLabel.text = String(Installments.totalAmountArray[3])
			InstallmentViewController.feeValue = valorCuotaValorLabel.text!
			InstallmentViewController.total = totalValorLabel.text!
		}
		
		// si el usuario seleccionó 12 cuotas
		if amountOfFeesModel[row] == "12" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[4]
			totalValorLabel.text = String(Installments.totalAmountArray[4])
			InstallmentViewController.feeValue = valorCuotaValorLabel.text!
			InstallmentViewController.total = totalValorLabel.text!
		}
		
		setUIEnabled(true)

	}
	
	
} // end ext

