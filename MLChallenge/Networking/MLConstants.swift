//
//  MLConstants.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 07/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//


/* Networking */

import Foundation

/* Abstract:
Almacena...
*/

extension MercadoPagoClient {
	
	
	struct Constants {
	
	//*****************************************************************
	// MARK: - Constants
	//*****************************************************************
	
	// datos necesarios para realizar las diversas 'API calls'
	
	// provistos por el CLIENTE:
	// https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&payment_method_id=visa
//	static let ApiURL = "https://private-d0cc1-iguanafixtest.apiary-mock.com/contacts"
	
	// URL components
	static let ApiScheme = "https"
	static let ApiHost = "api.mercadopago.com"
	static let ApiPath = "/v1/payment_methods"
	
		// TODO: luego refactorizar
	static let FirstCallUrl = "https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
		
	}
	
	//*****************************************************************
	// MARK: - API Methods (Calls)
	//*****************************************************************
	
	struct Methods {
		

	}
	
	
	// MARK: URL Keys
	struct URLKeys {
		static let UserID = "id"
	}
	
	//*****************************************************************
	// MARK: - Parameter Keys (Request)
	//*****************************************************************
	
	struct ParameterKeys {
		
		static let PublicKey = "public_key"
		static let PaymentMethod = "payment_method_id"
		static let Amount = "amount"
		static let IssuerId = "issuer.id"
	}
	
	//*****************************************************************
	// MARK: - Parameter Values (Request)
	//*****************************************************************
	
	struct ParameterValues {
		// la clave pública para interactuar con la API de Mercado Pago
		static let PublicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
		// el método de pago (tarjeta de crédito) elegida por el usuario
		static var PaymentMethod = ""
		// el monto a pagar por el usuario
		static var Amount = ""
		// el banco elegido asociado a su tarjeta de crédito
		static var IssuerId = ""
		
	}
	
	
	//*****************************************************************
	// MARK: - JSON Response Keys (Response)
	//*****************************************************************
	
	// las claves para extraer los valores deseados de los objetos JSON recibidos
	struct JSONResponseKeys {
		
		// para 'medio de pago' y 'banco'
		static let Name = "name"
		static let ThumbURL = "thumbnail"
		
		// valores a extraer de 'recommend_message'
		
		// cantidad de cuotas
		
		// valor de cada cuota
		
		// monto final
		
		
		
	}
}


