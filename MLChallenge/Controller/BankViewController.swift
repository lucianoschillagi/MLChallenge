
//
//  BancoViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit
import Alamofire

/* Abstract:
Tercer pantalla donde el usuario elige el banco asociado a su tarjeta.
*/

class BankViewController: UIViewController {

	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************

	var allBanks = [Bank]()
	var jsonArray: NSArray?
	var nameArray: Array<String> = []
	var thumbailURLArray: Array<String> = []
	
	var creditCardSelected: String!
	
	// un array que contiene los diversos 'installments' disponibles
	var installmentsArray = [Int]()
	
	// un array que contiene los diversos 'recommendMessage' disponibles
	var recommendMessageArray = [String]()
	
	// un array que contiene los diversos 'totalAmount' disponibles
	var totalAmountArray =  [Double]()

	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var amountLabel: UILabel!
	@IBOutlet weak var amountChoosenLabel: UILabel!
	@IBOutlet weak var creditCardLabel: UILabel!
	@IBOutlet weak var creditCardChoosenLabel: UILabel!
	@IBOutlet weak var nextButton: UIButton!
	
	@IBOutlet weak var banksTableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
			
				setUIEnabled(false)
			
        startRequest()
				startActivityIndicator()
			
			// imprime los valores parciales de la compra en las etiquetas correspondientes
			creditCardChoosenLabel.text = creditCardSelected
			amountChoosenLabel.text = "$ " + MasterViewController.montoSeleccionado
    }

	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: obtener un array de diccionarios que representan los datos de contacto de diferentes usuarios
	func startRequest(){

		MercadoPagoClient.getCardIssues { (success, banks, error) in
			DispatchQueue.main.async {
				if success {
					if let banks = banks {
						self.allBanks = banks // 🔌 👏
						debugPrint("Bancos disponibles: \(banks.count)")
						
						if banks.count == 0 {
						self.displayAlertView("Atención", "Esta tarjeta no tiene bancos asociados")
						
						}
						
						self.banksTableView.reloadData()
						self.stopActivityIndicator()
					}
				}
			} // end trailing closure
		}
	}
	
	//*****************************************************************
	// MARK: - Activity Indicator
	//*****************************************************************
	
	func startActivityIndicator() {
		activityIndicator.alpha = 1.0
		activityIndicator.startAnimating()
	}
	
	func stopActivityIndicator() {
		activityIndicator.alpha = 0.0
		activityIndicator.stopAnimating()
	}
	
	//*****************************************************************
	// MARK: - Alert View
	//*****************************************************************
	/**
	Muestra al usuario un mensaje acerca de cual ha sido el error en el su proceso de logueo.
	
	- Parameter title: El título del error.
	- Parameter message: El mensaje acerca del error.
	
	*/
	func displayAlertView(_ title: String?, _ message: String?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

} // end class


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

extension BankViewController: UITableViewDataSource {
	
	// task: devolver la cantidad de filas que tendrá la tabla
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return allBanks.count
	}
	
	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		let bank = allBanks[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		
		cell?.textLabel?.text = bank.name
		debugPrint("los nombres de los bancos son \(bank.name)")
		cell?.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
		
		if let thumbPath = bank.thumb {
			debugPrint("🗿\(thumbPath)")
			// realiza la solicitud para obtener la imágen
			let _ = MercadoPagoClient.taskForGETImage(thumbPath) { (imageData, error) in
				debugPrint("🎲\(imageData)")
				if let image = UIImage(data:imageData!) {
					debugPrint("😎\(image)")
					DispatchQueue.main.async {
						cell?.imageView?.image = image
					}
				} else {
					print(error ?? "empty error")
				}
			}
			
		} // end optional binding
		
		return cell!
		
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
	
}

//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

extension BankViewController: UITableViewDelegate {
	
	// task: almacenar el nombre del banco seleccionado para su posterior uso en la solicitud web
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// crea una variable para asignarle las propiedades del banco a la cada fila
		let bank = allBanks[(indexPath as NSIndexPath).row]
		
		// almancena el nombre y el id del banco en las propiedades 'BankName' y 'IssuerId'
		// la propiedad 'name'
		MercadoPagoClient.ParameterValues.BankName = bank.name
		// y la propiedad 'id' (que servirá como valor de un item de la solcitud web)
		MercadoPagoClient.ParameterValues.IssuerId = bank.id
		
		// MARK: networking: realizar la solicitud para obtener el ´recommend_message' 🚀
		MercadoPagoClient.getRecommendMessage { (success, installmentsObject, error) in
			
				// si la solicitud es exitosa
				if success {
					
					if let installmentsObject = installmentsObject {
						
						for item in installmentsObject {
							let payerCostsObjects = item.payerCosts
							
							for item in payerCostsObjects! {
								self.installmentsArray.append(item[MercadoPagoClient.Installments_JsonObject.JsonResponseKeys.Installments] as! Int)
							}

						} // end for-in
						
					} // end optional binding
					
					self.setUIEnabled(true)
					
				} // end if
				
		} // end network method
	
	} // end method
	
	
} // end ext


//*****************************************************************
// MARK: - Navigation (Segue)
//*****************************************************************

extension BankViewController {
	
	// task: enviar a 'DuesViewController' el valor del banco seleccionado, para imprimirlo luego en una etiqueta
	override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
		
		// si este vc tiene un segue con el identificador "toDuesVC"
		if segue.identifier == "toDuesVC" {
			
			let installmentsVC = segue.destination as! InstallmentViewController
			installmentsVC.creditCardSelected = creditCardSelected

		}
		
	}
	
}
