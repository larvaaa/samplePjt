package front.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import front.dao.MainDao;

@Service
public class MainService{

	@Autowired
	private MainDao mainDao;
	
	public List<Map<String,Object>> getData() {
		return mainDao.getData();
	}
}
