package tw.gameshop.user.model;



import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Event")
public class Game_Event {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY) 
	@Column(name = "eventId")
	private Integer eventId;
	
	@Column(name = "productId")
	private Integer productId;
	
	@Column(name = "eventName")
	private String eventName;
	
	@Column(name = "content")
	private String content;
	
	@Column(name = "startDate")
	private String startDate;
	
	@Column(name = "endDate")
	private String endDate;
	
	@Column(name = "eventImage")
	private byte[] eventImage;
	
	public Game_Event() {
	}
	
	public Game_Event(int eventId,int productId,String eventName,String content,String startDate,String endDate,byte[] eventImage) {
		this.eventId = eventId;
		this.productId = productId;
		this.eventName = eventName;
		this.content = content;
		this.startDate =startDate;
		this.endDate = endDate;
		this.eventImage = eventImage;
	}

	public Integer getEventId() {
		return eventId;
	}

	public void setEventId(Integer eventId) {
		this.eventId = eventId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public byte[] getEventImage() {
		return eventImage;
	}

	public void setEventImage(byte[] eventImage) {
		this.eventImage = eventImage;
	}

	
	
}
