<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <c:if test="${message=='cancelOrder'}">
        <script>
            window.onload = function () {
                init();
            }

            function init() {
                alert("주문을 취소했습니다.");
            }
        </script>
    </c:if>

    <script>
        function fnCancelOrder(orderId) {
            var answer = confirm("주문을 취소하시겠습니까?");
            if (answer == true) {
                var formObj = document.createElement("form");
                var iOrderId = document.createElement("input");

                iOrderId.name = "orderId";
                iOrderId.value = orderId;

                formObj.appendChild(iOrderId);
                document.body.appendChild(formObj);
                formObj.method = "post";
                formObj.action = "${contextPath}/mypage/cancelMyOrder.do";
                formObj.submit();
            }
        }
    </script>

</head>

<body>

<h1>최근주문내역
    <A href="#"> <IMG src="${contextPath}/image/btn_more_see.jpg"> </A>
</h1>

<table class="list_view">
    <tbody align=center>
    <tr style="background:#33ff00">
        <td>주문번호</td>
        <td>주문일자</td>
        <td>주문상품</td>
        <td>주문상태</td>
        <td>주문취소</td>
    </tr>
    <c:choose>
        <c:when test="${ empty myOrderList  }">
            <tr>
                <td colspan=5 class="fixed">
                    <strong>주문한 상품이 없습니다.</strong>
                </td>
            </tr>
        </c:when>
        <c:otherwise>

            <c:forEach var="item" items="${myOrderList }" varStatus="i">

                <c:choose>
                    <c:when test="${ preOrderId != item.orderId}">
                        <c:choose>
                            <c:when test="${item.deliveryState=='deliveryPrepared' }">
                                <tr bgcolor="lightgreen">
                            </c:when>
                            <c:when test="${item.deliveryState=='finishedDelivering' }">
                                <tr bgcolor="lightgray">
                            </c:when>
                            <c:otherwise>
                                <tr bgcolor="orange">
                            </c:otherwise>
                        </c:choose>

                        <tr>
                            <td>
                                <a href="${contextPath}/mypage/myOrderDetail.do?orderId=${item.orderId }"><span>${item.orderId }</span>
                                </a>
                            </td>

                            <td><span>${item.payOrderTime }</span></td>

                            <td align="left">
                                <strong>
                                    <c:forEach var="item2" items="${myOrderList}" varStatus="j">
                                        <c:if test="${item.orderId ==item2.orderId}">
                                            <a href="${contextPath}/goods/goodsDetail.do?goodsId=${item2.goodsId }">${item2.goodsTitle }/${item.orderGoodsQty }개</a><br>
                                        </c:if>
                                    </c:forEach>
                                </strong>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.deliveryState=='deliveryPrepared' }"> 배송준비중 </c:when>
                                    <c:when test="${item.deliveryState=='delivering' }"> 배송중 </c:when>
                                    <c:when test="${item.deliveryState=='finishedDelivering' }">배송완료 </c:when>
                                    <c:when test="${item.deliveryState=='cancelOrder' }"> 주문취소 </c:when>
                                    <c:when test="${item.deliveryState=='returningGoods' }"> 반품완료 </c:when>
                                </c:choose>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.deliveryState=='deliveryPrepared'}">
                                        <input type="button" onClick="fnCancelOrder('${item.orderId}')" value="주문취소"/>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="button" onClick="fnCancelOrder('${item.orderId}')" value="주문취소" disabled/>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                        </tr>

                        <c:set var="preOrderId" value="${item.orderId}"/>
                    </c:when>
                </c:choose>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    </tbody>
</table>

<br><br><br>
<h1>계좌내역
    <a href="#"> <img src="${contextPath}/image/btn_more_see.jpg"/> </a>
</h1>
<table border=0 width=100% cellpadding=10 cellspacing=10>
    <tr>
        <td>
            예치금 &nbsp;&nbsp; <strong>10000원</strong>
        </td>
        <td>
            쇼핑머니 &nbsp;&nbsp; <strong>9000원</strong>
        </td>
    </tr>
    <tr>
        <td>
            쿠폰 &nbsp;&nbsp; <strong>6000원</strong>
        </td>
        <td>
            포인트 &nbsp;&nbsp; <strong>2000원</strong>
        </td>
    </tr>
    <tr>
        <td>
            상품권 &nbsp;&nbsp; <strong>4000원</strong>
        </td>
        <td>
            디지털머니 &nbsp;&nbsp; <strong>9000원</strong>
        </td>
    </tr>
</table>

<br><br><br>
<h1>나의 정보
    <a href="#"> <img src="${contextPath}/image/btn_more_see.jpg"/> </a>
</h1>
<table border=0 width=100% cellpadding=10 cellspacing=10>
    <tr>
        <td>
            이메일:
        </td>
        <td>
            <strong>${memberInfo.email1 }@${memberInfo.email2 }</strong>
        </td>
    </tr>
    <tr>
        <td>
            전화번호
        </td>
        <td>
            <strong>${memberInfo.hp1 }-${memberInfo.hp2}-${memberInfo.hp3 }</strong>
        </td>
    </tr>
    <tr>
        <td>
            주소
        </td>
        <td>
            도로명: &nbsp;&nbsp; <strong>${memberInfo.roadAddress }</strong> <br>
            지번: &nbsp;&nbsp; <strong>${memberInfo.jibunAddress }</strong>
        </td>
    </tr>
</table>
</body>
</html>