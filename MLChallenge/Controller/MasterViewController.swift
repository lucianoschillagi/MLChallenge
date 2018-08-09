//
//  MasterViewController.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 02/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit


class MasterViewController: UIViewController {

	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// el monto ingresado por el usuario, capturado a través del text field
	let amount: Double = Double()
	
	//*****************************************************************
	// MARK: - IBOutlets
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
	
	//TODO: una vez que el usuario ingresa todos los datos de pago, realizar una solicitud web para obtener, con esos datos, el 'recommend_message' adecuado. Usar los valores buscados en ese objeto, para contruir el 'alert view'


} // end class
	
	
	


