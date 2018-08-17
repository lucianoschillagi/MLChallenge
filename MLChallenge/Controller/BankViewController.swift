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

class BankViewController: UIViewController {
	
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************


	var allBanks = [Bank]()
	var jsonArray: NSArray?
	var nameArray: Array<String> = []
	var thumbailURLArray: Array<String> = []
	
	var creditCardSelected: String! // el valor de la tarjeta seleccionada enviado por 'PayMathodVC'
	
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
	// MARK: - Methods
	//*****************************************************************

	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
			
        startRequest()
				startActivityIndicator()
			
			// imprime los valores parciales de la compra en las etiquetas correspondientes
			creditCardChoosenLabel.text = creditCardSelected
			amountChoosenLabel.text = "$ " + CashTextFieldDelegate.montoSeleccionado
			debugPrint("la tarjeta seleccionada fue \(creditCardSelected)")
			
			
			
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
						self.banksTableView.reloadData()
						self.stopActivityIndicator()
						
						// itera el array de [Bank] con los valores ya almacenados obtenidos
						for bank in self.allBanks {
							
							//debugPrint("😛Los objetos de las tarjetas son: \(card)")
							debugPrint("📦Los nombres de las bancos asocidados a la tarjeta elegida son: \(bank.name)")
							//debugPrint("🏄🏻‍♂️Los thumb de las tarjetas aceptadas son: \(card.thumb)")
							
						}
						debugPrint("La tarjeta elegida tiene \(banks.count) bancos asociados.")
					}
					
					// detener el indicador de actividad en red
					//self.stopActivityIndicator()
				} else {
					//self.displayAlertView(nil, error)
				} // end if-else
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
			
		} // end conditional binding
		
		return cell!
		
	}
}

extension BankViewController: UITableViewDelegate {
	
	// task: almacenar el nombre del banco seleccionado para su posterior uso en la solicitud web
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// crea una variable para asignarle las propiedades del banco a la cada fila
		let bank = allBanks[(indexPath as NSIndexPath).row]
		// la propiedad 'name'
		MercadoPagoClient.ParameterValues.BankName = bank.name
		// y la propiedad 'id' (que servirá como valor de un item de la solcitud web)
		MercadoPagoClient.ParameterValues.IssuerId = bank.id
		
		// MARK: networking: realizar la solicitud para obtener el  ´recommend_message' 🚀
		MercadoPagoClient.getRecommendMessage { (success, installmentsObject, error) in
				
				if success {
					
					debugPrint("La solicitud del 'recommend_message' fue exitosa")
					
					if let installmentsObject = installmentsObject {
						
						debugPrint("🏦\(installmentsObject)")
						
						for item in installmentsObject {
							
							debugPrint("🤾🏼‍♂️\(item.payerCosts)")
							
							let payerCostsObjects = item.payerCosts
							
							for item in payerCostsObjects! {
								
								debugPrint("uuuuu\(item)")
								
								self.installmentsArray.append(item["installments"] as! Int)
								debugPrint("🥁\(self.installmentsArray)")
								
							}
						
							
							
						}
						
						
					}
					
				} // end if
				
		} // end network method
		
	}
	
	
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
			
			// 1- el valor de la tarjeta elegida
			installmentsVC.creditCardSelected = creditCardSelected
			// 2- el array
//			installmentsVC.installmentsArray = installmentsArray
//			
//			print("🥅\(installmentsVC.installmentsArray = installmentsArray)")
			
			
		}
		
	}
	
}
