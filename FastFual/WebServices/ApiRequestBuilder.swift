//
//  ApiRequestBuilder.swift
//  FastFual
//
//  Created by macbook on 5/23/21.
//


import Foundation
import AlamofireObjectMapper
import Alamofire
import ObjectMapper
import SVProgressHUD

typealias InternetConnectionChecker = ( _ status: Bool) -> Void

class ApiRequestBuilder{
    
    typealias APIRequestResponse<T> = (_ status: Bool, _ object: T?) -> Void

    private static var shared: ApiRequestBuilder?
    private  init() {
        //MUST BE PRIVATE TO DISABLE USER CALL AND ACCESS ONLY BY getInstance()
    }
    
    private var url: String?
    private var method: HTTPMethod = .get
    private var parameters: Parameters = Parameters()
    private var showMessage: Bool = true
    
    static func getInstance()-> ApiRequestBuilder?{
        if let _shared = shared {
            return _shared
        }
        shared = ApiRequestBuilder()
        return shared
    }
    
    func url(url: String) -> ApiRequestBuilder {
        self.url = url
        return self
    }
    
    func method(method: HTTPMethod) -> ApiRequestBuilder {
        self.method = method
        return self
    }
    
    func set(key: String, value: Any) -> ApiRequestBuilder {
        parameters[key] = value
        return self
    }
    
    func enableMessage(status: Bool)->ApiRequestBuilder{
        self.showMessage = status
        return self
    }
        
    public func build<T: BaseResponse>(callback: @escaping APIRequestResponse<T>){
        internetConnectionChecker { (status) in
            if status{
                self.showLoading()
                Alamofire.request(self.url!, method: self.method, parameters: self.parameters, headers: self.getHeaders()).responseObject { (response: DataResponse<T>) in
                    
                    if let _baseResponse = response.result.value{
                        let status = _baseResponse.success ?? false

                        let message = _baseResponse.message ?? ""
                        if status{
                            if self.showMessage {
                                print(message)
//                                self.showMessage(message: message, isError: false)
                            }
                            
                            callback(true, _baseResponse)
                        }else{
                            print(message)

//                            self.showMessage(message: message, isError: true)
                            callback(false, nil)
                        }
                    }else{
                        callback(false, nil)
                    }
                    self.hideLoading()
                    self.reset()
                }
                
                
                

               
            }
        }
    }
    public func internetConnectionChecker(callback: @escaping InternetConnectionChecker){
        if MainController.isConnectedToInternet() {
            callback(true)
        }else{
            noInternetErrorMessage(callback: callback)
        }
    }
    public func noInternetErrorMessage(callback: @escaping InternetConnectionChecker){
        if MainController.isConnectedToInternet(){
            callback(true)
        }else{
            callback(false)
        }
 
    }
    
    //RESET VALUES FOR SINGELTON INSTANCE PROPERTIES (VARIABLES) AFTER EACH REQUEST
    private func reset(){
        url =  ""
        method = .get
        parameters = Parameters()
        showMessage = true
    }
    public func showLoading(){
        SVProgressHUD.setForegroundColor(UIColor.gray)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.show()
    }

    public func hideLoading(){
        SVProgressHUD.dismiss()
    }
    public func getHeaders()->HTTPHeaders{
        var headers: HTTPHeaders?
             headers = ["Authorization": ""]
     
    
        return headers!
    }
    
}
