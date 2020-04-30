package tw.gameshop.user.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ARTICLE")
public class Article {
	private int articleID;
	private int userId;
	private String articleTitle;
	private String articleAbstract;
	private String articleContent;
	private String articleThumbnail;
	private String postDatetime;
	private String updateDatetime;



	public Article() {
	}

//	public Article(int userId, String articleTitle, String articleContent) {
//		this.userId = userId;
//		this.articleTitle = articleTitle;
//		this.articleContent = articleContent;
//	}

	@Id
	@Column(name = "articleID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getArticleID() {
		return articleID;
	}

	public void setArticleID(int articleID) {
		this.articleID = articleID;
	}

	@Column(name = "userId")
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Column(name = "articleTitle")
	public String getArticleTitle() {
		return articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}
	
	@Column(name = "articleAbstract")
	public String getArticleAbstract() {
		return articleAbstract;
	}

	public void setArticleAbstract(String articleAbstract) {
		this.articleAbstract = articleAbstract;
	}
	
	@Column(name = "articleContent")
	public String getArticleContent() {
		return articleContent;
	}

	public void setArticleContent(String articleContent) {
		this.articleContent = articleContent;
	}

	@Column(name = "articleThumbnail")
	public String getArticleThumbnail() {
		return articleThumbnail;
	}

	public void setArticleThumbnail(String articleThumbnail) {
		this.articleThumbnail = articleThumbnail;
	}

	@Column(name = "postDatetime")
//	@GeneratedValue(strategy = GenerationType.AUTO)
	public String getPostDatetime() {
		return postDatetime;
	}

	public void setPostDatetime(String postDatetime) {
		this.postDatetime = postDatetime;
	}

	@Column(name = "updateDatetime")
	public String getUpdateDatetime() {
		return updateDatetime;
	}

	public void setUpdateDatetime(String updateDatetime) {
		this.updateDatetime = updateDatetime;
	}

}
