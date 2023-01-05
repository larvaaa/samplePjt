package front.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import front.dao.ShoppingDao;
import net.coobird.thumbnailator.Thumbnailator;

@Service
public class ShoppingService {
	
	private static final Logger logger = LoggerFactory.getLogger(ShoppingService.class);
	
	@Autowired
	private ShoppingDao shoppingDao;
	
	@Value("${upload.path}") 
	private String uploadFolder;
	
	//브랜드 조회
	public HashMap<String,String> findBrand(String brandId) {
		
		HashMap<String,String> findResult = shoppingDao.findBrand(brandId);
		
		return findResult;
	}
	
	//브랜드 목록 조회
	public List<Map<String,Object>> selectBrandList(Map<String,String> parameterMap) {
		
		int pageNum = Integer.parseInt(parameterMap.getOrDefault("pageNum", "1"));
		int startNum = pageNum*10 - 9;
		int endNum = pageNum*10;
		
		parameterMap.put("start_num", String.valueOf(startNum));
		parameterMap.put("end_num", String.valueOf(endNum));
		
		return shoppingDao.selectBrandList(parameterMap);
	}

	//브랜드 추가
	@Transactional
	public void insertBrand(HashMap<String,String> parameterMap, MultipartFile[] uploadFile) throws Exception {
		
		//XSS 방지를 위한 Util에서 만들어둔 메서드 처리하기
		//brandName = Util.XSSHandling(brandName);
		
		//브랜드 추가
		shoppingDao.insertBrand(parameterMap);
		String brandId = parameterMap.get("brandId");
		
		if(brandId != "" || brandId != null) {
			
			List<Map<String,Object>> uploadList = uploadAction(uploadFile);
			
			if(!uploadList.isEmpty()) {
				for(int i = 0; i < uploadFile.length; i++) {

					if(uploadFile[i].getSize() > 0) { //i번째 요소에 업로드된 이미지가 있을 경우

						Map<String,String> brandImage = new HashMap<>();
						
						brandImage.put("brand_id", brandId);
						brandImage.put("upload_file_name", String.valueOf(uploadList.get(i).get("fileName")));
						brandImage.put("upload_path", String.valueOf(uploadList.get(i).get("uploadPath")));
						brandImage.put("cust_id", parameterMap.get("cust_id"));
						
						shoppingDao.insertBrandImage(brandImage);
					}
				}
			}
		}

	}
	
	//파일 업로드
	public List<Map<String,Object>> uploadAction(MultipartFile[] uploadFile) {
		
		//연/월/일 폴더 생성 시작-------
		File uploadPath = new File(uploadFolder, getFolder());
		logger.info("uploadPath : " + uploadPath);
		
		if(!uploadPath.exists()) {//해당 경로가 없으면 생성해줘야함
			uploadPath.mkdirs();
		}
		//연/월/일 폴더 생성 끝-------
		
		//첨부된 파일의 이름을 담을 List
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		for(MultipartFile multipartFile : uploadFile) {
			
			logger.info("-----------");
			logger.info("파일명 : " + multipartFile.getOriginalFilename());
			logger.info("파일크기 : " + multipartFile.getSize());
			
			HashMap<String,Object> attachFile = new HashMap<>();

			
			
			//-----------UUID 파일명 처리 시작 ----------------------------
			//동일한 이름으로 업로드되면 기존 파일을 지우게 되므로 이를 방지하기 위함
			UUID uuid = UUID.randomUUID();
			String uploadFileName = uuid.toString() + "-" + multipartFile.getOriginalFilename();
			// c:\\upload\\gongu03.jpg으로 조립
			// 이렇게 업로드 하겠다라고 설계 uploadFolder -> uploadPath
			File saveFile = new File(uploadPath,uploadFileName);
			//-----------UUID 파일명 처리 끝 ----------------------------
			
			try {
				
				//transferTo() : 물리적으로 파일 업로드가 됨
				multipartFile.transferTo(saveFile);
			
				//1)fileName
				attachFile.put("fileName", uploadFileName);
				//2) uploadPath
				attachFile.put("uploadPath", uploadPath.getPath());
				//3) uuid
				attachFile.put("uuid", uuid.toString());
				//-------썸네일 처리 시작---------
				//이미지 파일인지 체킹
				if(checkImageType(saveFile)) {
					logger.info("이미지 파일? true");
					//4) image여부
					attachFile.put("image", true);
					//uploadPath : 연/월/일이 포함된 경로
					//uploadFileName : UUID가 포함된 파일명
					FileOutputStream thumbnail = 
							new FileOutputStream(
									new File(uploadPath,"s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),
							thumbnail, 100, 100);
					thumbnail.close();
				}else {
					logger.info("이미지 파일? false");
				}
				//-------썸네일 처리 끝---------
				
				//파일 실제 명을 list에 담음
				list.add(attachFile);
			}catch(Exception e){
				logger.info(e.getMessage());
			}//end catch
		}//end for
		return list;
	}//end uploadAction

	//첨부파일을 보관하는 폴더를 연/월/일 계층 형태로 생성하기 위함
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	//특정한 파일이 이미지 타입인지 검사해주는 메소드
	private boolean checkImageType(File file) {
		try {
			//file.toPath() : 파일의 전체 경로
			logger.info("file.toPath() : " + file.toPath());
			String contentType = Files.probeContentType(file.toPath());
			logger.info("contentType : " + contentType);
			//contentType이 image로 시작하면 이미지 타입이므로 true를 리턴함
			return contentType.startsWith("image");
		}catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}

}
