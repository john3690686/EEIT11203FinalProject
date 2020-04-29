package tw.gameshop.user.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "product")
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	public Product() {
	}

	public Product(String pName, int pPrice, String intro, String tag, Date uplTime, Date dwlTime) {
		this.productName = pName;
		this.price = pPrice;
		this.intro = intro;
		this.tag = tag;
		this.uploadTime = uplTime;
		this.downloadTime = dwlTime;
	}

	@Id
	@Column(name = "productId") // ���~id(�y����)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer ProductId;

	@Column(name = "productName") // ���~�W��
	private String productName;

	@Column(name = "intro") // ���~²��
	private String intro;

	@Column(name = "price") // ���~����
	private Integer price;

	@Column(name = "tag") // ���~����
	private String tag;

	@Column(name = "productImage") // ���~�Ϥ�
	private byte[] productImage;

	@JsonFormat(pattern = "yyyy-MM-DD hh:mm:ss")
	@Column(name = "uploadTime") // �W�[�ɶ�(��x����)
	private Date uploadTime;

	@JsonFormat(pattern = "yyyy-MM-DD hh:mm:ss")
	@Column(name = "downloadTime") // �U�[�ɶ�(��x����)
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
