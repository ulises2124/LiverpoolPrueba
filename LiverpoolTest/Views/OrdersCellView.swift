//
//  ResultsTableView.swift
//  LiverpoolTest
//
//  Created by Ulises Atonatiuh González Hernández on 14/10/20.
//

import Foundation
import UIKit

final class OrdersCellView: UITableViewCell {

    lazy var lbltitulo: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = Colors.mango
        label.text = "11111"
        label.numberOfLines = 2
        return label
    }()
    
    lazy var lblUbicacion: UILabel = {
           
           let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .black
        label.text = "Liverpool"
           return label
       }()
    
    lazy var lblPrecio: UILabel = {
           
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .blue
           label.text = "10,000"
           return label
       }()
    
   
    
    lazy var imgCell: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        addSubview(lbltitulo)
        addSubview(lblUbicacion)
        addSubview(lblPrecio)
        addSubview(imgCell)
        setUpConstraints()
        

    }
    
   
    

    func setUpConstraints() {
         lbltitulo.translatesAutoresizingMaskIntoConstraints = false
         lblUbicacion.translatesAutoresizingMaskIntoConstraints = false
         lblPrecio.translatesAutoresizingMaskIntoConstraints = false
        imgCell.translatesAutoresizingMaskIntoConstraints = false
        
        lbltitulo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5 ).isActive = true
        lbltitulo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        lbltitulo.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        imgCell.topAnchor.constraint(equalTo: lbltitulo.bottomAnchor, constant: 15 ).isActive = true
        imgCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        imgCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5).isActive = true
        imgCell.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imgCell.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
       
        lblUbicacion.topAnchor.constraint(equalTo: lbltitulo.bottomAnchor, constant: 10).isActive = true
        lblUbicacion.leftAnchor.constraint(equalTo: imgCell.leftAnchor, constant: 100).isActive = true
        
        
        lblPrecio.topAnchor.constraint(equalTo: lblUbicacion.bottomAnchor, constant: 10).isActive = true
        lblPrecio.leftAnchor.constraint(equalTo: imgCell.leftAnchor, constant: 100).isActive = true
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 0, left: 15, bottom: 20, right: 15)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
   
}



