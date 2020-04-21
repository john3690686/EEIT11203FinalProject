package tw.gameshop.user.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "product")
public class Product {
	@Id @Column(name = "productId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int productId;

	@Column(name = "productName")
	private String productName;

	@Column(name = "price")
	private int price;
	
	@Column(name = "intro")
	private String intro;
	
	@Column(name = "tag")
	private String tag;
	
	@Column(name = "productImage")
	private byte[] productImage;
	
	@Column(name = "uploadTime", columnDefinition = "TIMESTAMP")
	private Date uploadTime;
	
	@Column(name = "downloadTime", columnDefinition = "TIMESTAMP")
	private Date downloadTime;
	
	public Product() { super(); }
	
	public Product(String pName, int pPrice, String intro, String tag, Date uplTime, Date dwlTime) {
		this.productName = pName;
		this.price = pPrice;
		this.intro = intro;
		this.tag = tag;
		this.uploadTime = uplTime;
		this.downloadTime = dwlTime;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
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
