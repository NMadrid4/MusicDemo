//
//  TableViewController.swift
//  YoutubeDemo
//
//  Created by Nicolas on 9/08/18.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class TableViewController: UITableViewController {
    
    
    var music: [Music] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = UIColor.white
        tableView.register(UINib(nibName: "MusicViewCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        getData()
    }
    
    func getData() {
        Alamofire.request("\(MusicAPI.baseURL)\(MusicAPI.myAudioURL)").responseJSON { response in
            switch response.result {
            case .success:
                let data = JSON(response.data!)
                self.music = Music.from(jsonArray: data.array!)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return music.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! TableViewCell
        
        let url = URL(string: music[indexPath.row].image)
        let data = try? Data(contentsOf: url!)
        cell.albumImageView.image = UIImage(data: data!)!
        
        cell.titleLabel.text = music[indexPath.row].title
        cell.authorLabel.text = music[indexPath.row].author
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playSongs" {
            let musicViewController: ViewController = segue.destination as! ViewController
            musicViewController.music = sender as! Music
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let musica = music[indexPath.row]
        performSegue(withIdentifier: "playSongs", sender: musica)
    }
    
}

