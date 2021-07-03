//
//  VCDisplayCollectionPrice.swift
//  FastFual
//
//  Created by macbook on 6/12/21.
//

import UIKit
import Alamofire
import ObjectMapper
class VCDisplayCollectionPrice: UIViewController {
    var fuel:[Fuels]=[]
    var year=0
    var month=0
    @IBOutlet var display: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        date()

    }


    func registerNib(){
        let nib = UINib(nibName: "CVCGasPrice", bundle: nil)
        display.register(nib, forCellWithReuseIdentifier: "CVCGasPrice")
        
        display.register(UINib(nibName: "HeaderCRV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCRV")
        
        display.register(UINib(nibName: "FooterCRV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterCRV")
    }
    func date(){
        let date = Date()
        
        let calendar = Calendar.current
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        gazPrice(month: month, year: year)
        
    }

}
extension VCDisplayCollectionPrice:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fuel.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCGasPrice", for: indexPath) as! CVCGasPrice
        cell.latitle.text=fuel[indexPath.row].name ?? ""
        cell.laQuality.text="\(fuel[indexPath.row].price ?? 0.0)" + "SR"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let vv =  collectionView.frame.width  - 10.0
        return CGSize(width: vv / 2.0 , height: 100)
        
        
    }
func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            
            let header = display.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCRV", for: indexPath) as! HeaderCRV
 
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footer = display.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterCRV", for: indexPath) as! FooterCRV

            return footer
            
        default:
            
            print("anything")
        }
        
       return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
                return CGSize(width: self.view.frame.size.width, height: 200)
            
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 200)

        }

}

extension VCDisplayCollectionPrice{
    
    private func gazPrice(month:Int,year:Int){
        
        
        let parameters: Parameters = [
            "month" : month,
            "year":year]
        
        print("Bearer \(UserDefaults.standard.string(forKey: "token")!)")
        Alamofire.request(API_KEYS.get_prices.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : getPrice = Mapper<getPrice>().map(JSONString:str){
//                    print(parsedMapperString.data?.fuels?[0].name ?? "")
//                    laStationName.text!=(parsedMapperString.data?.fuels?[0].name)!
//                    price.text! = "\(parsedMapperString.data?.fuels?[0].price ?? 0.0)"
//                    if let urlimg = parsedMapperString.data?.fuels?[0].logo{
//                        stationImg.sd_setImage(with:URL(string: urlimg))
//                    }
//                    
                    fuel=(parsedMapperString.data?.fuels)!
                    display.delegate=self
                    display.dataSource=self
                }}}
        
    }
}
