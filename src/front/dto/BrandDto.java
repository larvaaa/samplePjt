package front.dto;

import org.springframework.web.multipart.MultipartFile;

import common.dto.CommonDto;

public class BrandDto extends CommonDto {
	
	private Long brandId;
	
	private String brandName;

	private MultipartFile[] uploadFile;
	
	private String[] deleteFile;

	public Long getBrandId() {
		return brandId;
	}

	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public MultipartFile[] getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile[] uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String[] getDeleteFile() {
		return deleteFile;
	}

	public void setDeleteFile(String[] deleteFile) {
		this.deleteFile = deleteFile;
	}

}
