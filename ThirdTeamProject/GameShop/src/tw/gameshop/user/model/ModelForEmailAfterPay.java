package tw.gameshop.user.model;

public class ModelForEmailAfterPay {
	private String Name;
	private String key;
	private byte[] image;
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	
	
}
