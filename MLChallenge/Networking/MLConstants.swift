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

extension MercadoLibreClient {
	
	//*****************************************************************
	// MARK: - Resquest
	//*****************************************************************
//	static let ApiURL = "https://private-d0cc1-iguanafixtest.apiary-mock.com/contacts"
//	static let ApiScheme = "https"
//	static let ApiHost = "private-d0cc1-iguanafixtest.apiary-mock.com"
//	static let ApiPath = "/contacts"
	static let PublicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
	
	//*****************************************************************
	// MARK: - Response
	//*****************************************************************
	struct JSONResponseKeys {
		static let Name = "name"
		static let ThumbURL = "thumbnail"
	}
	
}
