//
//  ThirdViewController.swift
//  music
//
//  Created by Isaac Sheets on 1/5/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let artistComponent = 0
    let albumComponent = 1
    
    var artistAlbums = ArtistAlbumsController()
    var artists = [String]()
    var albums = [String]()
    

    @IBOutlet weak var artistAlbumPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load the data using our data class
        do {
            try artistAlbums.loadData()
            artists = try artistAlbums.getAllArtists()
            //use first index on load since that is what the artist component will be set to
            albums = try artistAlbums.getAlbums(idx: 0)
        } catch {
            print(error)
        }
    }
    
    //need two components again
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    //return the right number of rows based on the size of each data array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == artistComponent {
            return artists.count
        } else if component == albumComponent {
            return albums.count
        } else {
            print("Unknown component")
            return -1
        }
    }

    //get the titles for each row from the data arrays
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == artistComponent {
            return artists[row]
        } else if component == albumComponent {
            return albums[row]
        } else {
            print("Unkown component")
            return "Unknown component"
        }
    }

    //change the albums component when the user selects a new artist -- also update the choice label
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //need to update albums if user selects a new artists
        if component == artistComponent {
            //get the new list of albums
            do {
                albums = try artistAlbums.getAlbums(idx: row)
            }
            catch {
                print(error)
            }
            //update the album component
            artistAlbumPicker.reloadComponent(albumComponent)
            //reset the album component to the first row
            artistAlbumPicker.selectRow(0, inComponent: albumComponent, animated: true)
        }
        
        let artist = pickerView.selectedRow(inComponent: artistComponent)
        let album = pickerView.selectedRow(inComponent: albumComponent)
        
        choiceLabel.text = "You like \(albums[album]) by \(artists[artist])"
    }
    

}
