//
//  ThirdViewController.swift
//  music_demo
//
//  Created by Isaac Sheets on 1/23/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //constants
    let artistComp = 0
    let albumComp = 1
    
    //vars
    var artistAlbums = ArtistAlbumsController()
    var artists = [String]()
    var albums = [String]()
    
    //view connections
    @IBOutlet weak var artistPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            //load the data
            try artistAlbums.loadData()
            
            //populate initial artists and albums arrays
            artists = try artistAlbums.getAllArtists()
            albums = try artistAlbums.getAlbums(idx: 0)
            
        } catch {
            //handle error better
            print(error)
        }
    }
    
    //DataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == artistComp {
            return artists.count
        } else if component == albumComp {
            return albums.count
        } else {
            print("Unknown component")
            return -1
        }
    }
    
    //Picker Delegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //switch based on component
        if component == artistComp {
            return artists[row]
        } else if component == albumComp {
            return albums[row]
        } else {
            print("Unknown component")
            return "unknown"
        }
    }
    
    //1: update albums and label when artist component is changed
    //2: update label when album component is changed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //check which component changed
        if component == artistComp {
            //task 1
            do {
                albums = try artistAlbums.getAlbums(idx: row)
            } catch {
                print(error)
            }
            //reload component
            artistPicker.reloadComponent(albumComp)
            artistPicker.selectRow(0, inComponent: albumComp, animated: true)
        }
        
        //get the currently selected indexes artist and album
        let artistIdx = pickerView.selectedRow(inComponent: artistComp)
        let albumIdx = pickerView.selectedRow(inComponent: albumComp)
        
        choiceLabel.text = "You like \(albums[albumIdx]) by \(artists[artistIdx])"
    }
    

}
