//
//  WeeklyTableViewCell.swift


import UIKit

class WeeklyTableViewCell: UITableViewCell {

    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var singer: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with stock: Stock) {
        songName.text = stock.name
        singer.text = stock.stock_code
        albumImage.image = UIImage(named: stock.imageName)
        likeBtn.imageView?.image = UIImage(named: stock.likeBtnImageName)
    }

}
