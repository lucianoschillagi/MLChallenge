//
//  MLObject.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 03/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/* Abstract:
Un objeto que contiene los datos de pago introducidos por el usuario y una clave pública para interactuar con la API de Mercado Pago.
Estos datos son necesario para pasarlos luego como valores de la peticiones de los 'API methods'
*/

struct UserDataPay {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// la clave pública
	let publicKey: String = "444a9ef5-8a6b-429f-abdf-587639155d88"
	// almacena el monto ingresado por el usuario
	let amount: Double
	// almacena la tarjeta seleccionada por el usuario
	let creditCard: String
	// almacena el banco asociado a la tarjeta seleccionada por el usuario
	let bank: String
	// almacena la cantidad de cuotas para el pago elegida por el usuario
	let fees: String
	

	
}



/*
API
selección medio de pago (tarjeta)
https://api.mercadopago.com/v1/payment_methods?public_key=PUBLIC_KEY

selección banco
https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=PUBLIC_KEY

recommend_message
// https://api.mercadopago.com/v1/payment_methods/installments?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&amount=15&payment_method_id=visa&issuer.id=288
// para mostrar en un 'alert view' de la pantalla inicial el 'recoomended_message'
*/

	
	

