package tw.gameshop.user.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "wish")
public class Wish {

	private Integer wishId;
	private Integer userId;
	private Integer productId;
	private String accomplish = "w";

	@Id @Column(name="wishId")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer getWishId() {
		return wishId;
	}

	public void setWishId(Integer wishId) {
		this.wishId = wishId;
	}

	@Column(name="userId")
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(name="productId")
	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	@Column(name="accomplish")
	public String getAccomplish() {
		return accomplish;
	}

	public void setAccomplish(String accomplish) {
		this.accomplish = accomplish;
	}
}
