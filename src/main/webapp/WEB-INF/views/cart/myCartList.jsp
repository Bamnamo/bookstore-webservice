<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="myCartList" value="${cartMap.myCartList}"/>
<c:set var="myGoodsList" value="${cartMap.myGoodsList}"/>

<c:set var="totalGoodsNum" value="0"/> <!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="2500"/> <!-- 총 배송비 -->
<c:set var="totalDiscountedPrice" value="0"/> <!-- 총 할인금액 -->

<html>
<head>
    <script type="text/javascript">

        function calcGoodsPrice(bookPrice, obj) {
            var totalPrice, finalTotalPrice, totalNum;
            var goodsQty = document.getElementById("selectGoodsQty");
            var pTotalNum = document.getElementById("pTotalNum");
            var pTotalPrice = document.getElementById("pTotalPrice");
            var pFinalTotalPrice = document.getElementById("pFinalTotalPrice");
            var hTotalNum = document.getElementById("hTotalNum");
            var hTotalPrice = document.getElementById("hTotalPrice");
            var hTotalDelivery = document.getElementById("hTotalDelivery");
            var hFinalTotalPrice = document.getElementById("hFinalTotalPrice");
            if (obj.checked == true) {
                totalNum = Number(hTotalNum.value) + Number(goodsQty.value);
                totalPrice = Number(hTotalPrice.value) + Number(goodsQty.value * bookPrice);
                finalTotalPrice = totalPrice + Number(hTotalDelivery.value);
            } else {
                totalNum = Number(hTotalNum.value) - Number(goodsQty.value);
                totalPrice = Number(hTotalPrice.value) - Number(goodsQty.value) * bookPrice;
                finalTotalPrice = totalPrice - Number(hTotalDelivery.value);
            }
            hTotalNum.value = totalNum;
            hTotalPrice.value = totalPrice;
            hFinalTotalPrice.value = finalTotalPrice;
            pTotalNum.innerHTML = totalNum;
            pTotalPrice.innerHTML = totalPrice;
            pFinalTotalPrice.innerHTML = finalTotalPrice;
        }

        function modifyCartQty(goodsId, bookPrice, index) {

            var length = document.frmOrderAllCart.cartGoodsQty.length;
            var tCartGoodsQty = 0;
            if (length > 1) { //카트에 제품이 한개인 경우와 여러개인 경우 나누어서 처리한다.
                tCartGoodsQty = document.frmOrderAllCart.cartGoodsQty[index].value;
            } else {
                tCartGoodsQty = document.frmOrderAllCart.cartGoodsQty.value;
            }

            var cartGoodsQty = Number(tCartGoodsQty);

            $.ajax({
                type: "post",
                async: false, //false인 경우 동기식으로 처리한다.
                url: "${contextPath}/cart/modifyCartQty.do",
                data: {
                    goodsId: goodsId,
                    cartGoodsQty: cartGoodsQty
                },

                success: function (data, textStatus) {
                    //alert(data);
                    if (data.trim() == 'modify_success') {
                        alert("수량을 변경했습니다!!");
                    } else {
                        alert("다시 시도해 주세요!!");
                    }

                },
                error: function (data, textStatus) {
                    alert("에러가 발생했습니다." + data);
                },
                complete: function (data, textStatus) {
                    //alert("작업을완료 했습니다");

                }
            }); //end ajax
        }

        function deleteCartGoods(cartId) {
            var cartId = Number(cartId);
            var formObj = document.createElement("form");
            var iCart = document.createElement("input");
            iCart.name = "cartId";
            iCart.value = cartId;

            formObj.appendChild(iCart);
            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/cart/removeCartGoods.do";
            formObj.submit();
        }

        function fnOrderEachGoods(goodsId, goodsTitle, goodsSalesPrice, fileName) {
            var totalPrice, finalTotalPrice, tGoodsQty;
            var cartGoodsQty = document.getElementById("cartGoodsQty");

            tOrderGoodsQty = cartGoodsQty.value; //장바구니에 담긴 개수 만큼 주문한다.
            var formObj = document.createElement("form");
            var iGoodsId = document.createElement("input");
            var iGoodsTitle = document.createElement("input");
            var iGoodsSalesPrice = document.createElement("input");
            var iFileName = document.createElement("input");
            var iOrderGoodsQty = document.createElement("input");

            iGoodsId.name = "goodsId";
            iGoodsTitle.name = "goodsTitle";
            iGoodsSalesPrice.name = "goodsSalesPrice";
            iFileName.name = "goodsFileName";
            iOrderGoodsQty.name = "orderGoodsQty";

            iGoodsId.value = goodsId;
            iOrderGoodsQty.value = tOrderGoodsQty;
            iGoodsTitle.value = goodsTitle;
            iGoodsSalesPrice.value = goodsSalesPrice;
            iFileName.value = fileName;

            formObj.appendChild(iGoodsId);
            formObj.appendChild(iGoodsTitle);
            formObj.appendChild(iGoodsSalesPrice);
            formObj.appendChild(iFileName);
            formObj.appendChild(iOrderGoodsQty);
            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/order/orderEachGoods.do";
            formObj.submit();
        }

        function fnOrderAllCartGoods() {
//	alert("모두 주문하기");
            var orderGoodsQty;
            var orderGoodsId;
            var objForm = document.frmOrderAllCart;
            var cartGoodsQty = objForm.cartGoodsQty;
            var checkedGoods = objForm.checkedGoods;
            var length = checkedGoods.length;


            //alert(length);
            if (length > 1) {
                for (var i = 0; i < length; i++) {
                    if (checkedGoods[i].checked == true) {
                        orderGoodsId = checkedGoods[i].value;
                        orderGoodsQty = cartGoodsQty[i].value;
                        cartGoodsQty[i].value = "";
                        cartGoodsQty[i].value = orderGoodsId + ":" + orderGoodsQty;
                        console.log(cartGoodsQty[i].value);
                    }
                }
            } else {
                orderGoodsId = checkedGoods.value;
                orderGoodsQty = cartGoodsQty.value;
                cartGoodsQty.value = orderGoodsId + ":" + orderGoodsQty;
            }

            objForm.method = "post";
            objForm.action = "${contextPath}/order/orderAllCartGoods.do";
            objForm.submit();
        }
    </script>
    <title></title>
</head>
<body>
<table class="list_view">
    <tbody align=center>
    <tr style="background:#33ff00">
        <td class="fixed">구분</td>
        <td colspan=2 class="fixed">상품명</td>
        <td>정가</td>
        <td>판매가</td>
        <td>수량</td>
        <td>합계</td>
        <td>주문</td>
    </tr>

    <c:choose>
    <c:when test="${ empty myCartList }">
        <tr>
            <td colspan=8 class="fixed">
                <strong>장바구니에 상품이 없습니다.</strong>
            </td>
        </tr>
    </c:when>
    <c:otherwise>
    <tr>
        <form name="frmOrderAllCart">

            <c:forEach var="item" items="${myGoodsList}" varStatus="cnt">
                <c:set var="cartGoodsQty" value="${myCartList[cnt.count-1].cartGoodsQty}"/>
                <c:set var="cartId" value="${myCartList[cnt.count-1].cartId}"/>

            <td>
                <input type="checkbox" name="checkedGoods" checked value="${item.goodsId }"
                       onClick="calcGoodsPrice(${item.goodsSalesPrice },this)">
            </td>

                <td class="goods_image">
                <a href="${contextPath}/goods/goodsDetail.do?goodsId=${item.goodsId }">
                    <img width="75" alt="" src="${contextPath}/thumbnails.do?goodsId=${item.goodsId}&fileName=${item.goodsFileName}"/></a>
                </td>

                <td>
                <h2><a href="${contextPath}/goods/goodsDetail.do?goodsId=${item.goodsId }">${item.goodsTitle }</a></h2>
                </td>

                <td>${item.goodsPrice}원</td>

                <td>
                <strong style="color: crimson">
                    <fmt:formatNumber value="${item.goodsPrice*0.9}" type="number" var="discountedPrice"/>
                        ${discountedPrice}원&#8595
                </strong><br>
                    <p style="font-size: 11px">10% 할인</p>
                </td>

                <td>
                <input type="text" id="cartGoodsQty" name="cartGoodsQty" size=3 value="${cartGoodsQty}"><br>
                <a href="javascript:modifyCartQty('${item.goodsId }','${item.goodsPrice*0.9 }','${cnt.count-1 }');">
                    <img width=25 alt="" src="${contextPath}/image/btn_modify_qty.jpg"></a>
                </td>

                <td>
                <strong>
                    <fmt:formatNumber value="${item.goodsPrice*0.9*cartGoodsQty}" type="number" var="totalPrice"/>
                        ${totalPrice}원
                </strong>
                </td>


                <td>
                <a href="javascript:fnOrderEachGoods('${item.goodsId }','${item.goodsTitle }','${item.goodsSalesPrice}','${item.goodsFileName}');">
                    <img width="75" alt="" src="${contextPath}/image/btn_order.jpg">
                </a><br>
                <a href="#">
                    <img width="75" alt=""
                         src="${contextPath}/image/btn_order_later.jpg">
                </a><br>
                <a href="#">
                    <img width="75" alt=""
                         src="${contextPath}/image/btn_add_list.jpg">
                </A><br>
                <a href="javascript:deleteCartGoods('${cartId}');">
                    <img width="75" alt=""
                         src="${contextPath}/image/btn_delete.jpg">
                </a>
                </td>

    </tr>

    <c:set var="totalGoodsPrice" value="${totalGoodsPrice+item.goodsPrice*cartGoodsQty }"/>
    <c:set var="totalGoodsNum" value="${totalGoodsNum+1 }"/>
    <c:set var="totalSalesPrice" value="${totalSalesPrice+item.goodsPrice-item.goodsPrice*0.9*cartGoodsQty}"/>


    </c:forEach>

    </tbody>
</table>

<div class="clear"></div>
</c:otherwise>
</c:choose>
<br>
<br>

<table width=80% class="list_view" style="background:#cacaff">
    <tbody>
    <tr align=center class="fixed">
        <td class="fixed">총 상품수</td>
        <td>총 상품금액</td>
        <td></td>
        <td>총 배송비</td>
        <td></td>
        <td>총 할인 금액</td>
        <td></td>
        <td>최종 결제금액</td>
    </tr>

    <c:set var="finalTotalPrice" value="${totalGoodsPrice+totalDeliveryPrice-totalSalesPrice}" />

    <tr cellpadding=40 align=center>

        <td id="">
            <p id="pTotalGoodsNum">${totalGoodsNum}개 </p>
            <input id="hTotalGoodsNum" type="hidden" value="${totalGoodsNum}"/>
        </td>

        <td>
            <p id="pTotalGoodsPrice">
                <fmt:formatNumber value="${totalGoodsPrice}" type="number" var="totalGoodsPrice"/>
                ${totalGoodsPrice}원 </p>
            <input id="hTotalGoodsPrice" type="hidden" value="${totalGoodsPrice}"/>
        </td>

        <td>
            <img width="25" alt="" src="${contextPath}/image/plus.jpg">
        </td>

        <td>
            <p id="p_totalDeliveryPrice">${totalDeliveryPrice }원  </p>
            <input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
        </td>

        <td>
            <img width="25" alt="" src="${contextPath}/image/minus.jpg">
        </td>

        <td>
            <p id="p_totalSalesPrice">
                <fmt:formatNumber  value="${totalSalesPrice}" type="number" var="finalSalesPrice" />
                ${finalSalesPrice}원
            </p>
            <input id="h_totalSalesPrice"type="hidden" value="${finalSalesPrice}" />
        </td>

        <td>
            <img width="25" alt="" src="${contextPath}/image/equal.jpg">
        </td>

        <td>
            <p id="pFinalTotalPrice">
                <fmt:formatNumber  value="${finalTotalPrice}" type="number" var="finalTotalPrice" />
                ${finalTotalPrice}원
            </p>
            <input id="h_final_totalPrice" type="hidden" value="${finalTotalPrice}" />
        </td>

    </tr>
    </tbody>
</table>
<center>
    <br><br>
    <a href="javascript:fnOrderAllCartGoods()">
        <img width="75" alt="" src="${contextPath}/image/btn_order_final.jpg"></a>
    <a href="#">
        <img width="75" alt="" src="${contextPath}/image/btn_shoping_continue.jpg"></a>
</center>
</form>
</body>
</html>