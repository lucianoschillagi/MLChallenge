//
//  MercadoPagoClient.swift
//  MLChallenge
//
//  Created by Luciano Schillagi on 03/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Networking */

import Foundation
import Alamofire

/* Abstract:
Una clase que encapsula los métodos para realizar la solicitud web.
*/

class MercadoLibreClient {
	
	// task: realiza una solicitud web para obtener los métodos de pago disponibles (tarjetas de crédito disponibles)
	static func getPayMethods(_ completionHandlerForCreditCardsObject: @escaping ( _ success: Bool, _ creditCards: [CreditCard]?, _  errorString: String?) -> Void) {
		
		//1.
		Alamofire.request("https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88") .responseJSON { response in
			
			// check response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("👏example success")
				default:
					let errorMessage = "error with response status: \(status)"
				}
			}
			
			// si se obtuvo el JSON exitosamente
			if let jsonObjectResult = response.result.value {
				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
				let resultsContacts = CreditCard.creditCardsFromResults(jsonObjectResult as! [[String : AnyObject]])
				completionHandlerForCreditCardsObject(true, resultsContacts, nil)

			} // end if-let
			
		} // end closure
		
	}
	
	// task: realiza una solicitud web para obtener los bancos asociados a la tarjeta de crédito seleccionada por el usuario
	static func getCardIssues(_ completionHandlerForCardIssuesObject: @escaping ( _ success: Bool, _ cardIssues: [Bank]?, _  errorString: String?) -> Void) {}
	
	
	// task: ...
	static func getRecommendMessage(_ completionHandlerForRecommendMessageObject: @escaping ( _ success: Bool, _ recommendMessage: [String:AnyObject]?, _  errorString: String?) -> Void) {}
	

	
}
