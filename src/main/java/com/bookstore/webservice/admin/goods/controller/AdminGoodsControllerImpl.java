package com.bookstore.webservice.admin.goods.controller;

import com.bookstore.webservice.admin.goods.service.AdminGoodsService;
import com.bookstore.webservice.goods.vo.ImageFileVO;
import com.bookstore.webservice.main.BaseController;
import com.bookstore.webservice.member.vo.MemberVO;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("adminGoodsController")
@RequestMapping(value = "/admin/goods")
public class AdminGoodsControllerImpl extends BaseController implements AdminGoodsController {

    private static final String CURR_IMAGE_REPO_PATH = "src/main/resources/static/image/file_repo";

    @Autowired
    private AdminGoodsService adminGoodsService;

    @Override
    @RequestMapping(value = "/addNewGoods.do", method = RequestMethod.POST)
    public ResponseEntity addNewGoods(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
        multipartRequest.setCharacterEncoding("utf-8");
        response.setContentType("text/html; charset=UTF-8");
        String imageFileName = null;

        Map newGoodsMap = new HashMap();
        Enumeration enu = multipartRequest.getParameterNames();
        while (enu.hasMoreElements()) {
            String name = (String) enu.nextElement();
            String value = multipartRequest.getParameter(name);
            newGoodsMap.put(name, value);
        }

        HttpSession session = multipartRequest.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
        String reg_id = memberVO.getMember_id();
        List<ImageFileVO> imageFileList = upload(multipartRequest);
        if (imageFileList != null && imageFileList.size() != 0) {
            for (ImageFileVO imageFileVO : imageFileList) {
                imageFileVO.setReg_id(reg_id);
            }
            newGoodsMap.put("imageFileList", imageFileList);
        }
        String message = null;
        ResponseEntity resEntity = null;
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Content-Type", "text/html charset=UTF-8");
        try {
            int goods_id = adminGoodsService.addNewGoods(newGoodsMap);
            if (imageFileList != null && imageFileList.size() != 0) {
                for (ImageFileVO imageFileVO : imageFileList) {
                    imageFileName = imageFileVO.getFileName();
                    File srcFile = new File(CURR_IMAGE_REPO_PATH + "//" + "temp" + "//" + imageFileName);
                    File destDir = new File(CURR_IMAGE_REPO_PATH + "//" + goods_id);
                    FileUtils.moveFileToDirectory(srcFile, destDir, true);
                }
            }
            message = "<script>";
            message += " alert('새상품을 추가했습니다.');";
            message += " location.href='" + multipartRequest.getContextPath() + "/admin/goods/addNewGoodsForm.do';";
            message += ("</script>");
        } catch (Exception e) {
            if (imageFileList != null && imageFileList.size() != 0) {
                for (ImageFileVO imageFileVO : imageFileList) {
                    imageFileName = imageFileVO.getFileName();
                    File srcFile = new File(CURR_IMAGE_REPO_PATH + "//" + "temp" + "//" + imageFileName);
                    srcFile.delete();
                }
            }
            message = "<script>";
            message += " alert('오류가 발생했습니다. 다시 시도해 주세요');";
            message += " location.href='" + multipartRequest.getContextPath() + "/admin/goods/addNewGoodsForm.do';";
            message += ("</script>");
            e.printStackTrace();
        }
        resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
        return resEntity;
    }
}
