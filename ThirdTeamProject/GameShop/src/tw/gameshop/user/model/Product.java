package tw.gameshop.user.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="product")
public class Product {
	
	@Id @Column(name="productId")			// 產品id(流水號)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer ProductId;
	
	@Column(name="productName")				// 產品名稱
	private String productName;
	
	@Column(name="intro")					// 產品簡介
	private String intro;
	
	@Column(name="price")					// 產品價格
	private Integer price;
	
	@Column(name="tag")						// 產品標籤
	private String tag;
	
	@Column(name="productImage")			// 產品圖片
	private byte[] productImage;
	
	@Column(name="uploadTime")				// 上架時間(後台控制)
	private Date uploadTime;
	
	@Column(name="downloadTime")			// 下架時間(後台控制)
	private Date downloadTime;

	public Integer getProductId() {
		return ProductId;
	}

	public void setProductId(Integer productId) {
		ProductId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public byte[] getProductImage() {
		return productImage;
	}

	public void setProductImage(byte[] productImage) {
		this.productImage = productImage;
	}

	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	public Date getDownloadTime() {
		return downloadTime;
	}

	public void setDownloadTime(Date downloadTime) {
		this.downloadTime = downloadTime;
	}

}
