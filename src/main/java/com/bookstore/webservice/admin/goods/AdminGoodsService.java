package com.bookstore.webservice.admin.goods;

import com.bookstore.webservice.goods.GoodsVO;
import com.bookstore.webservice.goods.ImageFileVO;
import com.bookstore.webservice.order.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("adminGoodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminGoodsService {

	@Autowired
	private AdminGoodsDAO adminGoodsDAO;
	

	public int addNewGoods(Map newGoodsMap) throws Exception{
		int goodsId = adminGoodsDAO.insertNewGoods(newGoodsMap);
		ArrayList<ImageFileVO> imageFileList = (ArrayList)newGoodsMap.get("imageFileList");
		for(ImageFileVO imageFileVO : imageFileList) {
			imageFileVO.setGoodsId(goodsId);
		}
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
		return goodsId;
	}
	

	public List<GoodsVO> listNewGoods(Map condMap) throws Exception{
		return adminGoodsDAO.selectNewGoodsList(condMap);
	}

	public Map goodsDetail(int goodsId) throws Exception {
		Map goodsMap = new HashMap();
		GoodsVO goodsVO=adminGoodsDAO.selectGoodsDetail(goodsId);
		List imageFileList =adminGoodsDAO.selectGoodsImageFileList(goodsId);
		goodsMap.put("goods", goodsVO);
		goodsMap.put("imageFileList", imageFileList);
		return goodsMap;
	}


	public List goodsImageFile(int goodsId) throws Exception{
		return adminGoodsDAO.selectGoodsImageFileList(goodsId);
	}
	

	public void modifyGoodsInfo(Map goodsMap) throws Exception{
		adminGoodsDAO.updateGoodsInfo(goodsMap);
		
	}	

	public void modifyGoodsImage(List<ImageFileVO> imageFileList) throws Exception{
		adminGoodsDAO.updateGoodsImage(imageFileList); 
	}
	

	public List<OrderVO> listOrderGoods(Map condMap) throws Exception{
		return adminGoodsDAO.selectOrderGoodsList(condMap);
	}

	public void modifyOrderGoods(Map orderMap) throws Exception{
		adminGoodsDAO.updateOrderGoods(orderMap);
	}
	

	public void removeGoodsImage(int imageId) throws Exception{
		adminGoodsDAO.deleteGoodsImage(imageId);
	}
	

	public void addNewGoodsImage(List imageFileList) throws Exception{
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
	}
	

	
}
