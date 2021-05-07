package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.FreeBoardDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Map<String, Object>> freeBoardList(Map<String, Object> sMap){
		return sqlSessionTemplate.selectList("freeBoardGetList", sMap);
	}


	public Map<String, Object> freeBoardInsertPro(FreeBoardDto dto){
		Map<String, Object> map = new HashMap<>();
		
		try {
			sqlSessionTemplate.insert("freeBoardInsertPro",dto);
			map.put("result", "true");
			map.put("num", getNewNum());
		} catch (Exception e) {
			map.put("result", "false");
		}
		return map;
	}

	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}
	
	public int getDataCount(Map<String, Object> sMap){
		return sqlSessionTemplate.selectOne("getDataCount", sMap);
	}

	public Map<String, Object> freeBoardModify(FreeBoardDto dto){
		Map<String, Object> hMap = new HashMap<>();
		
		try {
			sqlSessionTemplate.update("freeBoardModify", dto);
			hMap.put("result", "true");
			hMap.put("num", dto.getNum());
		} catch (Exception e) {
			hMap.put("result", "false");
		}
		
		return hMap;
	}

	public Map<String, Object> FreeBoardDelete (int num) {
		Map<String, Object> dMap = new HashMap<>();
		
		try {
			sqlSessionTemplate.delete("freeBoardDelete", num);
			dMap.put("result", "true");
			dMap.put("num", num);
		} catch (Exception e) {
			dMap.put("result", "false");
		}
		
		return dMap;
	}
	
	public Map<String, Object> freeBoardCheckDelete(List<String> checkArray){
		
		Map<String, Object> cMap = new HashMap<>();
		
		try {
			sqlSessionTemplate.delete("freeBoardCheckDelete", checkArray);
			cMap.put("result","true");
		} catch (Exception e) {
			cMap.put("result", "false");
		}
		
		return cMap;
	}
	
	public List<Map<String, Object>> selectType(){
		return sqlSessionTemplate.selectList("selectType");
	}
	public List<Map<String, Object>> codeType(){
		return sqlSessionTemplate.selectList("codeType");
	}

}
