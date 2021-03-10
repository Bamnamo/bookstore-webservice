<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="euc-kr"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="goods"  value="${goodsMap.goods}"  />
<c:set var="imageFileList"  value="${goodsMap.imageFileList}"  />

<c:choose>
<c:when test='${not empty goods.goodsStatus}'>

	<script>
		window.onload=function()
		{
			init();
		}


		function init(){
			var frmModGoods=document.frmModGoods;
			var hGoodsStatus=frmModGoods.hGoodsStatus;
			var goodsStatus=hGoodsStatus.value;
			var selectGoodsStatus=frmModGoods.goodsStatus;
			selectGoodsStatus.value=goodsStatus;
		}
	</script>

</c:when>
</c:choose>

<script type="text/javascript">
	function fnModifyGoods(goodsId, attribute){
		var frmModGoods=document.frmModGoods;
		var value="";
		if(attribute=='goodsSort'){
			value=frmModGoods.goodsSort.value;
		}else if(attribute=='goodsTitle'){
			value=frmModGoods.goodsTitle.value;
		}else if(attribute=='goodsWriter'){
			value=frmModGoods.goodsWriter.value;
		}else if(attribute=='goodsPublisher'){
			value=frmModGoods.goodsPublisher.value;
		}else if(attribute=='goodsPrice'){
			value=frmModGoods.goodsPrice.value;
		}else if(attribute=='goodsSalesPrice'){
			value=frmModGoods.goodsSalesPrice.value;
		}else if(attribute=='goodsPoint'){
			value=frmModGoods.goodsPoint.value;
		}else if(attribute=='goodsPublishedDate'){
			value=frmModGoods.goodsPublishedDate.value;
		}else if(attribute=='goodsTotalPage'){
			value=frmModGoods.goodsTotalPage.value;
		}else if(attribute=='goodsIsbn'){
			value=frmModGoods.goodsIsbn.value;
		}else if(attribute=='goodsDeliveryPrice'){
			value=frmModGoods.goodsDeliveryPrice.value;
		}else if(attribute=='goodsDeliveryDate'){
			value=frmModGoods.goodsDeliveryDate.value;
		}else if(attribute=='goodsStatus'){
			value=frmModGoods.goodsStatus.value;
		}else if(attribute=='goodsContentsOrder'){
			value=frmModGoods.goodsContentsOrder.value;
		}else if(attribute=='goodsWriterIntro'){
			value=frmModGoods.goodsWriterIntro.value;
		}else if(attribute=='goodsIntro'){
			value=frmModGoods.goodsIntro.value;
		}else if(attribute=='goodsPublisherComment'){
			value=frmModGoods.goodsPublisherComment.value;
		}else if(attribute=='goodsRecommendation'){
			value=frmModGoods.goodsRecommendation.value;
		}

		$.ajax({
			type : "post",
			async : false, //false�� ��� ��������� ó���Ѵ�.
			url : "${contextPath}/admin/goods/modifyGoodsInfo.do",
			data : {
				goodsId:goodsId,
				attribute:attribute,
				value:value
			},
			success : function(data, textStatus) {
				if(data.trim()=='mod_success'){
					alert("��ǰ ������ �����߽��ϴ�.");
				}else if(data.trim()=='failed'){
					alert("�ٽ� �õ��� �ּ���.");
				}
				},
			error : function(data, textStatus) {
				alert("������ �߻��߽��ϴ�."+data);
				},
			complete : function(data, textStatus) {
				//alert("�۾����Ϸ� �߽��ϴ�");
			}
		});
	}



	function readURL(input,preview) {
		//  alert(preview);
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function (e) {
				$('#'+preview).attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}

	var cnt =1;

	function fnAddFile(){
		$("#dFile").append("<br>"+"<input  type='file' name='detailImage"+cnt+"' id='detailImage"+cnt+"'  onchange=readURL(this,'previewImage"+cnt+"') />");
		$("#dFile").append("<img  id='previewImage"+cnt+"'   width=200 height=200  />");
		$("#dFile").append("<input  type='button' value='�߰�'  onClick=addNewImageFile('detailImage"+cnt+"','${imageFileList[0].goodsId}','detailImage')  />");
		cnt++;
	}
  
	function modifyImageFile(fileId,goodsId, imageId,fileType){
		// alert(fileId);
		var form = $('#fileForm')[0];
		var formData = new FormData(form);
		formData.append("fileName", $('#'+fileId)[0].files[0]);
		formData.append("goodsId", goodsId);
		formData.append("imageId", imageId);
		formData.append("fileType", fileType);
      
		$.ajax({
			url: '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			success: function(result){
				alert("�̹����� �����߽��ϴ�!");
			}
		});
	}
  

	function addNewImageFile(fileId,goodsId, fileType){
		//  alert(fileId);

		var form = $('#fileForm')[0];
		var formData = new FormData(form);
		formData.append("uploadFile", $('#'+fileId)[0].files[0]);
		formData.append("goodsId", goodsId);
		formData.append("fileType", fileType);
	      
		$.ajax({
			url: '${contextPath}/admin/goods/addNewGoodsImage.do',
			processData: false,
			contentType: false,
			data: formData,
			type: 'post',
			success: function(result){
				alert("�̹����� �����߽��ϴ�!");
			}
		});
	}
  

	function deleteImageFile(goodsId,imageId,imageFileName,trId){

		var tr = document.getElementById(trId);

		$.ajax({
			type : "post",
			async : true, //false�� ��� ��������� ó���Ѵ�.
			url : "${contextPath}/admin/goods/removeGoodsImage.do",
			data: {goodsId:goodsId,
				imageId:imageId,
				imageFileName:imageFileName},
			success : function(data, textStatus) {
				alert("�̹����� �����߽��ϴ�!!");
				tr.style.display = 'none';
				},
			error : function(data, textStatus) {
				alert("������ �߻��߽��ϴ�."+textStatus);
				},
			complete : function(data, textStatus) {
				//alert("�۾����Ϸ� �߽��ϴ�");
			}
		}); //end ajax
	}
</script>

</head>
<body>
<form  name="frmModGoods"  method=post >
	<div class="clear"></div>
	<!-- ���� ��� ���� �� -->
	<div id="container">
		<ul class="tabs">
			<li><a href="#tab1">��ǰ����</a></li>
			<li><a href="#tab2">��ǰ����</a></li>
			<li><a href="#tab3">��ǰ���ڼҰ�</a></li>
			<li><a href="#tab4">��ǰ�Ұ�</a></li>
			<li><a href="#tab5">���ǻ� ��ǰ ��</a></li>
			<li><a href="#tab6">��õ��</a></li>
			<li><a href="#tab7">��ǰ�̹���</a></li>
		</ul>

		<div class="tab_container">
			<div class="tab_content" id="tab1">
				<table >

					<tr>
						<td width=200 >��ǰ�з�</td>
						<td width=500>
							<select name="goodsSort">
								<c:choose>
									<c:when test="${goods.goodsSort=='��ǻ�Ϳ� ���ͳ�' }">
										<option value="��ǻ�Ϳ� ���ͳ�" selected>��ǻ�Ϳ� ���ͳ� </option>
										<option value="������ ���">������ ���  </option>
									</c:when>
									<c:when test="${goods.goodsSort=='������ ���' }">
										<option value="��ǻ�Ϳ� ���ͳ�" >��ǻ�Ϳ� ���ͳ� </option>
										<option value="������ ���" selected>������ ���  </option>
									</c:when>
								</c:choose>
							</select>
						</td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsSort')"/></td>
					</tr>


					<tr >
						<td >��ǰ�̸�</td>
						<td><input name="goodsTitle" type="text" size="40"  value="${goods.goodsTitle }"/></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsTitle')"/></td>
					</tr>
			

					<tr>
						<td >����</td>
						<td><input name="goodsWriter" type="text" size="40" value="${goods.goodsWriter }" /></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsWriter')"/></td>
					</tr>


					<tr>
						<td>���ǻ�</td>
						<td><input name="goodsPublisher" type="text" size="40" value="${goods.goodsPublisher }" /></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsPublisher')"/></td>
					</tr>


					<tr>
						<td >��ǰ����</td>
						<td><input name="goodsPrice" type="text" size="40" value="${goods.goodsPrice }" /></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsPrice')"/></td>
					</tr>
			

					<tr>
						<td >��ǰ�ǸŰ���</td>
						<td><input name="goodsSalesPrice" type="text" size="40" value="${goods.goodsSalesPrice }" /></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsSalesPrice')"/></td>
					</tr>


					<tr>
						<td >��ǰ ���� ����Ʈ</td>
						<td><input name="goodsPoint" type="text" size="40" value="${goods.goodsPoint }" /></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsPoint')"/></td>
					</tr>


					<tr>
						<td >��ǰ������</td>
						<td><input  name="goodsPublishedDate"  type="date"  value="${goods.goodsPublishedDate }" /></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsPublishedDate')"/></td>
					</tr>
			

					<tr>
						<td >��ǰ �� ��������</td>
						<td><input name="goodsTotalPage" type="text" size="40"  value="${goods.goodsTotalPage }"/></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsTotalPage"/></td>
					</tr>
			

					<tr>
						<td >ISBN</td>
						<td><input name="goodsIsbn" type="text" size="40" value="${goods.goodsIsbn }" /></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsIsbn')"/></td>
					</tr>


					<tr>
						<td >��ǰ ��ۺ�</td>
						<td><input name="goodsDeliveryPrice" type="text" size="40"  value="${goods.goodsDeliveryPrice }"/></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsDeliveryPrice')"/></td>
					</tr>


					<tr>
						<td >��ǰ ���� ������</td>
						<td><input name="goodsDeliveryDate" type="date"  value="${goods.goodsDeliveryDate }" /></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsDeliveryDate')"/></td>
					</tr>
			

					<tr>

						<td >��ǰ����</td>

						<td>
							<select name="goodsStatus">
								<option value="bestseller"  >����Ʈ����</option>
								<option value="steadyseller" >���׵𼿷�</option>
								<option value="newbook" >�Ű�</option>
								<option value="onSale" >�Ǹ���</option>
								<option value="buyOut"  selected>ǰ��</option>
								<option value="outOfPrint" >����</option>
							</select>

							<input  type="hidden" name="hGoodsStatus" value="${goods.goodsStatus }"/>
						</td>

						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsStatus')"/></td>

					</tr>


					<tr>
						<td colspan=3>
							<br>
						</td>
					</tr>

				</table>
			</div>


			<div class="tab_content" id="tab2">
				<h4>å����</h4>
				<table>
					<tr>
						<td >��ǰ����</td>
						<td><textarea  rows="100" cols="80" name="goodsContentsOrder"> ${goods.goodsContentsOrder }</textarea></td>
						<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsContentsOrder')"/></td>
					</tr>
				</table>
			</div>

			<div class="tab_content" id="tab3">
				<h4>��ǰ ���� �Ұ�</h4>
				<p>
				<table>
				<tr>
					<td >��ǰ ���� �Ұ�</td>
					<td><textarea  rows="100" cols="80" name="goodsWriterIntro">${goods.goodsWriterIntro }</textarea></td>
					<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsWriterIntro')"/></td>
				</tr>
			    </table>
				</p>
			</div>

			<div class="tab_content" id="tab4">
				<H4>��ǰ�Ұ�</H4>
				<p>
				<table>
				<tr>
					<td>��ǰ�Ұ�</td>
					<td><textarea  rows="100" cols="80" name="goodsIntro">${goods.goodsIntro }</textarea></td>
					<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsIntro')"/></td>
				</tr>
			    </table>
				</p>
			</div>

			<div class="tab_content" id="tab5">
				<h4>���ǻ� ��ǰ ��</h4>
				<p>
				<table>
				<tr>
					<td><textarea  rows="100" cols="80" name="goodsPublisherComment">${goods.goodsPublisherComment }</textarea></td>
					<td><input  type="button" value="����"  onClick="fnModifyGoods('${goods.goodsId }','goodsPublisherComment')"/></td>
				</tr>
			    </table>
				</p>
			</div>

			<div class="tab_content" id="tab6">
				<h4>��õ��</h4>
				 <table>
					 <tr>
						<td>��õ��</td>
						<td><textarea  rows="100" cols="80" name="goodsRecommendation">${goods.goodsRecommendation }</textarea>
						</td>
						<td><input  type="button" value="����"  onClick=" fnModifyGoods('${goods.goodsId }','goodsRecommendation')"/></td>
					</tr>
			    </table>
			</div>

			<d class="tab_content" id="tab7">
			   <form id="fileFrom" method="post" enctype="multipart/form-data"  >

				   <h4>��ǰ�̹���</h4>
				   <table>

					   <tr>
						   <c:forEach var="item" items="${imageFileList }"  varStatus="itemNum">
						   <c:choose>
							   <c:when test="${item.fileType=='mainImage' }">

					   <tr>

					   <td>���� �̹���</td>

					   <td>
						   <input type="file"  id="mainImage"  name="mainImage"  onchange="readURL(this,'preview${itemNum.count}');" />
						   <input type="hidden"  name="imageId" value="${item.imageId}"  />
						   <br>
					   </td>

					   <td><img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goodsId=${item.goodsId}&fileName=${item.fileName}" /></td>
					   <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					   <td><input  type="button" value="����"  onClick="modifyImageFile('mainImage','${item.goodsId}','${item.imageId}','${item.fileType}')"/></td>

				       </tr>

					   <tr>
						   <td><br></td>
					   </tr>

					   </c:when>

					   <c:otherwise>

						   <tr  id="${itemNum.count-1}">

							   <td>�� �̹���${itemNum.count-1 }</td>

							   <td>
								   <input type="file" name="detailImage"  id="detailImage"   onchange="readURL(this,'preview${itemNum.count}');" />
								   <input type="hidden"  name="imageId" value="${item.imageId }"  />
								   <br>
							   </td>

							   <td><img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goodsId=${item.goodsId}&fileName=${item.fileName}"></td>
							   <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>

							   <td>
								   <input  type="button" value="����"  onClick="modifyImageFile('detailImage','${item.goodsId}','${item.imageId}','${item.fileType}')"/>
								   <input  type="button" value="����"  onClick="deleteImageFile('${item.goodsId}','${item.imageId}','${item.fileName}','${itemNum.count-1}')"/>
							   </td>
						   </tr>

						   <tr>
							   <td><br></td>
						   </tr>

					   </c:otherwise>
					   </c:choose>
					   </c:forEach>

					   <tr align="center">
						   <td colspan="3">
							   <div id="dFile">
								   <%-- <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" /> --%>
							   </div>
						   </td>
					   </tr>

					   <tr>
						   <td align=center colspan=2>
							   <input   type="button" value="�̹��������߰��ϱ�"  onClick="fnAddFile()"  />
						   </td>
					   </tr>

				   </table>
			   </form>

		</div>

		<div class="clear"></div>
					
</form>