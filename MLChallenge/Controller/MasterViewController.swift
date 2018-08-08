//
//  MasterViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */


import UIKit
import Alamofire

class MasterViewController: UIViewController {

	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	@IBOutlet weak var okButton: UIButton!
	@IBOutlet weak var amountTextField: UITextField!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//downloadDataFromAPI()
	}

	override func viewWillAppear(_ animated: Bool) {
		// TODO: una vez que vuelve de 'CuotasVc' llamar el método
		// https://api.mercadopago.com/v1/payment_methods/installments?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&amount=15&payment_method_id=visa&issuer.id=288
		// para mostrar en un 'alert view' el 'recoomended_message'
	}
	
	//*****************************************************************
	// MARK: - IBActions
	//*****************************************************************
	
	// task:
	@IBAction func okButtonPressed(_ sender: UIButton) {
		// TODO: comprobar si el valor ingresado en el text field es correcto
		// si es así, navegar hacia la siguiente pantalla
	}
	
	
	// task: capturar el monto ingresado por el usuario
	@IBAction func addAmount(_ sender: UITextField) {}

	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
//	func downloadDataFromAPI(){
//		//1.
//		Alamofire.request("https://api.mercadopago.com/v1/payment_methods/installments?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&amount=15&payment_method_id=visa&issuer.id=288") .responseJSON { response in
//
//			// response status code
//			if let status = response.response?.statusCode {
//				switch(status){
//				case 200:
//					print("👏example success")
//				default:
//					let errorMessage = "error with response status: \(status)"
//				}
//			}
//
//			//2.
//			if let JSON = response.result.value{
//				debugPrint(JSON)
//				}
//				//6.
//				//self.tableView.reloadData()
//
//
//
//			} // end closure
//		} // end method


} // end class
	
	
	


