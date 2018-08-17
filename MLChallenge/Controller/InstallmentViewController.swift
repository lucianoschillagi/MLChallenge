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
		
		// rellena el formulario de compra con los valores anteriormente ingresados por el usuario
		printPartialValuesOfThePurchase()
		
		// networking
		startRequest()
		
		
		
		// test
		
		
		debugPrint("el array de cuotas disponibles es este: \(Installments.installmentsArray)")
		debugPrint("el array de recomend messages disponibles es este: \(Installments.recommendMessageArray)")
		debugPrint("el array de los total amount disponibles es este: \(Installments.totalAmountArray)")
		
		debugPrint("el segundo elementos de los recommend message es: \(Installments.recommendMessageArray[1])")
	
		
	}
	
	//print partial values of the purchase
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	// task: imprimir los valores parciales de la compra en las etiquetas correspondientes
	func printPartialValuesOfThePurchase() {
		tarjetaValorLabel.text = creditCardSelected
		montoValorLabel.text = CashTextFieldDelegate.montoSeleccionado
		bancoValorLabel.text = MercadoPagoClient.ParameterValues.BankName
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
		
//		MercadoPagoClient.getRecommendMessage { (success, installmentsObject, error) in
//			
//			DispatchQueue.main.async {
//				// si la solicitud fue exitosa...
//				
//				if success {
//					
//					if let installmentsObject = installmentsObject {
//						
//						// asigna los resultados del 'installment object' a la propiedad 'installmentsObject: [Installments]'
//						self.installmentsArrayObject = installmentsObject // 🔌
//						
//						
//						
//						for item in self.installmentsArrayObject  {
//							
//							
//							
//							
//							
//						}
//						
//						
//						
//						
//						
//
//					}
//					
//					
//					// si el valor de la etiqueta donde el usuario pone la cantidad de cuotas es igual a 3
//					// entonces mostrar el  'recommend message' y 'total amount' correspondientes (idem para las otras cantidad de cuotas)
//					
//					if self.cuotasValorLabel.text == "3" {
//						
//						debugPrint("el usuario está eligiendo 3 cuotas")
//						//debugPrint("⚽️\(self.installmentsObject.installmentsArray[2])")
//						
//					}
//				
//				
//				
//				
//				
//				
//				
//				
//				
//				
//				
////				if success {
////					// comprueba si hay valor dentro de 'installmentsObject'
////					if let installmentsObject = installmentsObject {
////						// asigna los resultados del 'installment object' al array 'payerCostsObject'
////						self.installmentsObject = installmentsObject // 🔌
////
////						debugPrint("👹\(self.installmentsObject)")
////					} // end optional binding
//				
//						
//					} // end if
//				
//			} // end trailing closure
//		} // end network method
	} // end func
	
	
	
	
	

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
		cuotasValorLabel.text = amountOfFeesModel[row]
		//userDataPay.fees = amountOfFeesModel[row]
		debugPrint("😅El usuario seleccionó \(amountOfFeesModel[row]) cuotas.")
		// una vez que el usuario eligió la cantidad de cuotas, realizar una solicitud ('recommend_message') para calcular:
		// 1- el monto de cada cuota (de acuerdo a la cantidad de cuotas elegidas)
		// 2- el monto total a pagar
		
		// si el usuario seleccionó 0 cuotas
		if amountOfFeesModel[row] == "0" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[0]
			totalValorLabel.text = String(Installments.totalAmountArray[0])
			
		}
		
		// si el usuario seleccionó 3 cuotas
		if amountOfFeesModel[row] == "3" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[1]
			totalValorLabel.text = String(Installments.totalAmountArray[1])
		}
		
		// si el usuario seleccionó 6 cuotas
		if amountOfFeesModel[row] == "6" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[2]
			totalValorLabel.text = String(Installments.totalAmountArray[2])

			
		}
		
		// si el usuario seleccionó 9 cuotas
		if amountOfFeesModel[row] == "9" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[3]
			totalValorLabel.text = String(Installments.totalAmountArray[3])

			
		}
		
		// si el usuario seleccionó 12 cuotas
		if amountOfFeesModel[row] == "12" {
			
			// imprimir en la etiqueta 'cuotasValorLabel' el monto correspondiente de cada cuota
			valorCuotaValorLabel.text = Installments.recommendMessageArray[4]
			totalValorLabel.text = String(Installments.totalAmountArray[4])

			
		}
		
		
		
		
		
		
	}
	
	
	
	
	
	
} // end ext

