//
//  PrivateApi.swift
//  Sales
//
//  Created by Vladimir Vasilyev on 03.11.2022.
//

import Foundation

public enum PrivateApi {
    case companyCreate(agentName: String,
                       agentSurname: String,
                       agentImage: String,
                       companyName: String,
                       address: String,
                       region: String,
                       area: String)

    case agentCreate(name: String,
                     surname: String,
                     role: String)

    case agentJoin(name: String,
                   surname: String,
                   image: String,
                   inviteCode: String)

    case profileUpdate(name: String,
                       description: String,
                       profileImage: String,
                       backgroundImage: String,
                       tags: [String])
    case profileGet
    case agentsGet
    
    case agentGetById(agentId: String?)
    case agentGetByCode(inviteCode: String)

    case contractGetById(contractId: String)
    case contractGetByCode(inviteCode: String)
    case contractAccept(inviteCode: String)
    case contractInvite
    case contractsGet(isActive: Bool?)

    case getMeSeller
    case getMeBuyer
    case postMeSeller
    case postMeBuyer
    
    case getMyOrders
    case getMyItems
    case getMyCategories
    
    case upload(file: Data)
}

extension PrivateApi: EndPointType {

    var path: String {
        switch self {
        case .postMeBuyer, .getMeBuyer:
            return "me/buyer"
        case .postMeSeller, .getMeSeller:
            return "me/seller"
        case .getMyItems:
            return "me/seller/items"
        case .getMyCategories:
            return "me/seller/categories"
        case .getMyOrders:
            return "me/seller/orders"
        

        case .agentGetById, .agentGetByCode:
            return "agent"
        case .agentsGet:
            return "agents"
        case .agentCreate:
            return "agent/create"
        case .agentJoin:
            return "agent/join"

        case .companyCreate:
            return "company/create"
            
        case .profileGet, .profileUpdate:
            return "profile"
            
        case .contractGetById, .contractGetByCode:
            return "contract"
        case .contractsGet:
            return "contracts"
        case .contractInvite:
            return "contract/invite"
        case .contractAccept:
            return "contract/accept"

        case .upload:
            return "upload"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMeSeller,
                .getMeBuyer,
                .getMyItems,
                .getMyCategories,
                .getMyOrders,
            
                .agentGetById,
                .agentGetByCode,
                .agentsGet,
                .profileGet,
                .contractInvite,
                .contractGetById,
                .contractGetByCode,
                .contractsGet:
            return .get
        case .postMeSeller,
                .postMeBuyer,
                .companyCreate,
                .agentCreate,
                .agentJoin,
                .profileUpdate,
                .contractAccept,
                .upload:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .companyCreate(
            agentName,
            agentSurname,
            agentImage,
            companyName,
            address,
            region,
            area):
            
            return .requestParametersAndHeaders(
                bodyParameters:
                    ["agentName": agentName,
                     "agentSurname": agentSurname,
                     "agentImage": agentImage,
                     "companyName": companyName,
                     "address": address,
                     "region": region,
                     "area": area
                    ],
                bodyEncoding: .jsonEncoding,
                urlParameters: nil,
                additionHeaders: headers)
        case let .agentCreate(name, surname, role):
            return .requestParametersAndHeaders(
                bodyParameters:
                    ["agentName": name,
                     "agentSurname": surname,
                     "agentRole": role],
                bodyEncoding: .jsonEncoding,
                urlParameters: nil,
                additionHeaders: headers)
        case let .agentJoin(name, surname, image, inviteCode):
            return .requestParametersAndHeaders(
                bodyParameters:
                    ["agentName": name,
                     "agentSurname": surname,
                     "agentImage": image,
                     "inviteCode": inviteCode],
                bodyEncoding: .jsonEncoding,
                urlParameters: nil,
                additionHeaders: headers)
        case let .profileUpdate(name,
                                description,
                                profileImage,
                                backgroundImage,
                                tags):
            return .requestParametersAndHeaders(
                bodyParameters:
                    ["name": name,
                     "description": description,
                     "profileImage": profileImage,
                     "backgroundImage": backgroundImage,
                     "tags": tags],
                bodyEncoding: .jsonEncoding,
                urlParameters: nil,
                additionHeaders: headers)
        case let .agentGetByCode(code):
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters:
                    ["inviteCode": code],
                additionHeaders: headers)
        case let .agentGetById(agentId):
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters:
                    agentId != nil ? ["agentId": agentId ?? ""] : nil,
                additionHeaders: headers)
        case let .contractGetByCode(inviteCode):
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters:
                    ["inviteCode": inviteCode],
                additionHeaders: headers)
        case let .contractGetById(contractId):
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters:
                    ["contractId": contractId],
                additionHeaders: headers)
        case let .contractAccept(inviteCode):
            return .requestParametersAndHeaders(
                bodyParameters:
                    ["inviteCode": inviteCode],
                bodyEncoding: .jsonEncoding,
                urlParameters: nil,
                additionHeaders: headers)
        case let .contractsGet(isActive):
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: isActive != nil ? ["isActive": isActive ?? ""] : nil,
                additionHeaders: headers)
        case let .upload(file):
            return .requestParameters(
                bodyParameters: ["file": file],
                bodyEncoding: .multipartFormData,
                urlParameters: nil)
        case .agentsGet:
            fallthrough
        case .profileGet:
            fallthrough
        case .getMeSeller:
            fallthrough
        case .getMeBuyer:
            fallthrough
        case .postMeSeller:
            fallthrough
        case .postMeBuyer:
            fallthrough
        case .getMyOrders:
            fallthrough
        case .getMyItems:
            fallthrough
        case .contractInvite:
            fallthrough
        case .getMyCategories:
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .jsonEncoding,
                urlParameters: nil,
                additionHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        guard let token = Session.access else { return nil }
        return ["x-auth-token": token]
    }
}
