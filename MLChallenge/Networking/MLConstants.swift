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

	// URL components
	static let ApiScheme = "https"
	static let ApiHost = "api.mercadopago.com"
	static let ApiPath_PaymentMethods = "/v1/payment_methods"
	static let ApiPath_CardIssues = "/v1/payment_methods/card_issuers"
	static let ApiPath_Installments = "/v1/payment_methods/installments"
	}
	
	//*****************************************************************
	// MARK: - API Methods (Calls)
	//*****************************************************************

	
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
		// el nombre del banco elegido
		static var BankName = ""
		// el id del banco elegido asociado a su tarjeta de crédito
		static var IssuerId = ""
	}
	
	//*****************************************************************
	// MARK: - JSON Response Keys (Response)
	//*****************************************************************
	
	// las claves para extraer los valores deseados de los objetos JSON recibidos
	
	
	// 1st ApiCall response
	struct CreditCard_JsonObject {
		
		struct  JsonResponseKeys {
			static let CreditCardId = "id"
			static let CreditCardName = "name"
			static let Thumb = "secure_thumbnail"
		}
	
	}
	
	// 2nd ApiCall response
	struct Bank_JsonObject {
		
		struct  JsonResponseKeys {
			static let BankId = "id"
			static let BankName = "name"
			static let Thumb = "secure_thumbnail"
		}
		
	}
	
	// 3rd ApiCall response
	struct Installments_JsonObject {
		
		struct  JsonResponseKeys {
			static let PayerCosts = "payer_costs"
			static let RecommendMessage = "narecommended_messageme"
		}
		
	}
	

} // end


