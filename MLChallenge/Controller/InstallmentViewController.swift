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
	
	let amountOfFeesModel = ["0", "3", "6", "9", "12"]
	
	// la tarjeta de crédito seleccionada en la pantalla anterior
	var creditCardSelected: String!
	
	// un array que contiene 1 elmenento con la información acerca del pago en cuotas
	var payerCostsObject = [Installments]()
	
	var losMensajesParaLasDiferentesCuotas = [Installments]()

	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************

	@IBOutlet weak var summaryButton: UIButton!
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var userAmountLabel: UILabel!
	@IBOutlet weak var creditCardLabel: UILabel!
	@IBOutlet weak var userCreditCardLabel: UILabel!
	@IBOutlet weak var bankLabel: UILabel!
	@IBOutlet weak var userBankLabel: UILabel!
	@IBOutlet weak var installmentLabel: UILabel!
	@IBOutlet weak var userInstallmentLabel: UILabel!
	@IBOutlet weak var installmentValueLabel: UILabel!
	@IBOutlet weak var userInstallmentValueLabel: UILabel!
	@IBOutlet weak var totalLabel: UILabel!
	@IBOutlet weak var userTotalAmount: UILabel!
	
	// el picker view para que el usuario seleccione en cuantas cuotas quiere realizar su pago
	@IBOutlet var amountOfFees: UIPickerView!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		// rellena el formulario de compra con los valores anteriormente ingresados por el usuario
		printPartialValuesOfThePurchase()
		
	}
	
	//print partial values of the purchase
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	// task: imprimir los valores parciales de la compra en las etiquetas correspondientes
	func printPartialValuesOfThePurchase() {
		userCreditCardLabel.text = creditCardSelected
		userAmountLabel.text = CashTextFieldDelegate.montoSeleccionado
		userBankLabel.text = MercadoPagoClient.ParameterValues.BankName
	}
	
	//*****************************************************************
	// MARK: - IBActions
	//*****************************************************************
	
	// task: una vez tapeado al botón ´summary´, llamar al método que muestra un alert view con un resúmen de los valores de la compra
	@IBAction func summaryButtonPressed(_ sender: UIButton) {
		
		// network request 🚀
		
		// valores requeridos para pasar en la query de la solicitud web
		// clave pública, LA TENGO
		// monto, LO TENGO
		// medio de pago, LO TENGO
		// banco, LO TENGO
		
		
		
		
		
		
		
		
	}
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	func startRequest(){
		
		MercadoPagoClient.getRecommendMessage { (success, installmentsObject, error) in
			
			DispatchQueue.main.async {
				// si la solicitud fue exitosa...
				if success {
					// comprueba si hay valor dentro de 'installmentsObject'
					if let installmentsObject = installmentsObject {
						// asigna los resultados del 'installment object' al array 'payerCostsObject'
						self.payerCostsObject = installmentsObject // 🔌
						
						// itera ahora el array que contiene 1 elemento 'payerCostsObject'
						for recommendedMessage in self.payerCostsObject {
							
						
							
							self.losMensajesParaLasDiferentesCuotas.append(recommendedMessage)
							print("aaa\(self.losMensajesParaLasDiferentesCuotas.count)")
							
							
							

							
							
							
//							// el recommend message 👏
//							self.userInstallmentValueLabel.text = recommendedMessage.recommendMessage
//							// el costo total 👏
//							self.userTotalAmount.text = "$" + String(recommendedMessage.totalAmount)
						
							
							
							}
						
						
						for item in self.losMensajesParaLasDiferentesCuotas {
							
							debugPrint("888\(item.installments)")
						}

						
						}
						
						
					}
				
			} // end trailing closure
		}
	}
	
	
	
	
	

} // end class


//*****************************************************************
// MARK: - Picker View Methods
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
		userInstallmentLabel.text = amountOfFeesModel[row]
		//userDataPay.fees = amountOfFeesModel[row]
		debugPrint("😅El usuario seleccionó \(amountOfFeesModel[row]) cuotas.")
		// una vez que el usuario eligió la cantidad de cuotas, realizar una solicitud ('recommend_message') para calcular:
		// 1- el monto de cada cuota (de acuerdo a la cantidad de cuotas elegidas)
		// 2- el monto total a pagar
		startRequest()
		
	}
	
	
	
	
	
	
} // end ext

