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
Una clase que encapsula los métodos para realizar las solicitudes web (API Calls).
*/

class MercadoPagoClient: NSObject {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// crea un singleton
	static let sharedInstance = MercadoPagoClient()
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	override init() {
		super.init()
	}
	
	//*****************************************************************
	// MARK: - API Calls Methods
	//*****************************************************************
	
	// task: realiza una solicitud web para obtener los métodos de pago disponibles (tarjetas de crédito disponibles)
	static func getPayMethods(_ completionHandlerForCreditCardsObject: @escaping ( _ success: Bool, _ creditCards: [CreditCard]?, _  errorString: String?) -> Void) {
		
		//1.
		Alamofire.request("\(MercadoPagoClient.Constants.FirstCallUrl)") .responseJSON { response in

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
				let resultsCreditCards = CreditCard.creditCardsFromResults(jsonObjectResult as! [[String : AnyObject]])
				completionHandlerForCreditCardsObject(true, resultsCreditCards, nil)

			} // end if-let

		} // end closure
		
	}
	
	// task: realiza una solicitud web para obtener los BANCOS asociados a la tarjeta de crédito seleccionada por el usuario
	static func getCardIssues(_ completionHandlerForCardIssuesObject: @escaping ( _ success: Bool, _ cardIssues: [Bank]?, _  errorString: String?) -> Void) {
		
		let tarjetaElegidaPorUsuario = ["payment_method_id": PayMethodViewController.creditCardChoosen]
		
		// TODO: acá es necesario pasarle la tarjeta de crédito elegida por el usuario 👈
		Alamofire.request("https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&payment_method_id=visa") .responseJSON { response in
			
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
				//let resultBanks = CreditCard.creditCardsFromResults(jsonObjectResult as! [[String : AnyObject]])
				let resultBanks = Bank.banksFromResults(jsonObjectResult as! [[String : AnyObject]])
				completionHandlerForCardIssuesObject(true, resultBanks, nil)
				
			} // end if-let
			
		} // end closure
		
		
		
		
	}
	
	// task: realiza una solicitud web para obtener el 'recommend_message', objeto necesario para extraer los datos a mostrar en el 'alert view' de la pantalla inicial
	static func getRecommendMessage(_ completionHandlerForRecommendMessageObject: @escaping ( _ success: Bool, _ recommendMessage: [String:AnyObject]?, _  errorString: String?) -> Void) {
		
		/*
		se realiza la solicitud para extraer los siguientes valores deseados:
		-la cantidad de cuotas
		-el valor de cada cuota
		-el monto final
		*/
	
	}
	

	
	
	//*****************************************************************
	// MARK: - Create URLs
	//*****************************************************************
	
	//https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
	
	// create a URL from parameters
	private func mercadoPagoURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
		
		var components = URLComponents()
		components.scheme = MercadoPagoClient.Constants.ApiScheme // 'https'
		components.host = MercadoPagoClient.Constants.ApiScheme // 'api.mercadopago.com'
		components.path = MercadoPagoClient.Constants.ApiPath + (withPathExtension ?? "") // 'v1/payment_methods'
		components.queryItems = [URLQueryItem]()
		
		for (key, value) in parameters {
			let queryItem = URLQueryItem(name: key, value: "\(value)")
			components.queryItems!.append(queryItem)
		}
		
		return components.url!
	}
	
}
