//
//  UserDataPay.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 03/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/* Abstract:
Un objeto que contiene los datos de pago introducidos por el usuario.
*/

struct UserDataPay {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// DATOS PROVISTOS POR EL USUARIO 👈
	
	// almacena el MONTO ingresado por el usuario
	let amount: Double // 'amount'
	// almacena la TARJETA seleccionada por el usuario
	let creditCard: String // 'payment_method'
	// almacena el BANCO elegido por el usuario
	let bank: String // 'issuer.id'
	// almacena la cantidad de CUOTAS para el pago elegida por el usuario
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

	
	

