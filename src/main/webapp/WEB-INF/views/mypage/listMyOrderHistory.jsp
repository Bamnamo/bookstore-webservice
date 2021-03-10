<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html >
<html>
<head>
    <meta charset="utf-8">
    <script>

        function searchOrderHistory(fixedSearchPeriod) {
            var formObj = document.createElement("form");
            var iFixedSearchPeriod = document.createElement("input");
            iFixedSearchPeriod.name = "fixedSearchPeriod";
            iFixedSearchPeriod.value = "fixedSearchPeriod";
            formObj.appendChild(formObj);
            formObj.method = "get";
            formObj.action = "${contextPath}/mypage/listMyOrderHistory.do";
            formObj.submit();
        }

        function fnCancelOrder(orderId) {
            var answer = confirm("주문을 취소하시겠습니까?");
            if (answer == true) {
                var formObj = document.createElement("form");
                var iOrderId = document.createElement("input")

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

<h3>주문 배송 조회</h3>
<form method="post">
    <table>
        <tbody>

        <tr>
            <td>
                <input type="radio" name="simple" checked/> 간단조회 &nbsp;&nbsp;&nbsp;
                <input type="radio" name="simple"/> 일간 &nbsp;&nbsp;&nbsp;
                <input type="radio" name="simple"/> 월간
            </td>
        </tr>

        <tr>
            <td>
                <select name="curYear">
                    <c:forEach var="i" begin="0" end="5">
                        <c:choose>
                            <c:when test="${endYear==endYear-i}">
                                <option value="${endYear}" selected>${endYear}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${endYear-i}">${endYear-i}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select> 년

                <select name="curMonth">
                    <c:forEach var="i" begin="1" end="12">
                        <c:choose>
                            <c:when test="${endMonth==i}">
                                <option value="${i}" selected>${i}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i}">${i}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select> 월

                <select name="curDay">
                    <c:forEach var="i" begin="1" end="31">
                        <c:choose>
                            <c:when test="${endDay==i}">
                                <option value="${i}" selected>${i}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i}" selected>${i}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select> 일 &nbsp;이전&nbsp;&nbsp;&nbsp;

                <a href="javascript:searchOrderHistory('today')"><img src="${contextPath}/image/btn_search_one_day.jpg"></a>
                <a href="javascript:searchOrderHistory('oneWeek')"><img src="${contextPath}/image/btn_search_1_week.jpg"></a>
                <a href="javascript:searchOrderHistory('twoWeek')"><img src="${contextPath}/image/btn_search_2_week.jpg"></a>
                <a href="javascript:searchOrderHistory('oneMonth')"><img src="${contextPath}/image/btn_search_1_month.jpg"></a>
                <a href="javascript:searchOrderHistory('twoMonth')"><img src="${contextPath}/image/btn_search_2_month.jpg"></a>
                <a href="javascript:searchOrderHistory('threeMonth')"><img src="${contextPath}/image/btn_search_3_month.jpg"></a>
                <a href="javascript:searchOrderHistory('fourMonth')"><img src="${contextPath}/image/btn_search_4_month.jpg"></a>
                &nbsp; 까지 조회
            </td>
        </tr>

        <tr>
            <td>
                <select name="searchCondition">
                    <option value="2015" checked>전체</option>
                    <option value="2015">수령자</option>
                    <option value="2015">주문자</option>
                    <option value="2015">주문번호</option>
                </select>
                <input type="text" size="30"/>
                <input type="button" value="조회"/>
            </td>
        </tr>

        <tr>
            <td>
                조회한 기간:
                <input type="text" size="4" value="${beginYear}"/> 년
                <input type="text" size="4" value="${beginMonth}"/> 월
                <input type="text" size="4" value="${beginDay}"/> 일
                &nbsp;
                <input type="text" size="4" value="${beginYear}"/> 년
                <input type="text" size="4" value="${beginMonth}"/> 월
                <input type="text" size="4" value="${beginDay}"/> 일
            </td>
        </tr>

        </tbody>
    </table>

    <div class="clear"></div>

</form>

<div class="clear"></div>

<table class="list_view">
    <tbody align="center">
    <tr style="background: #33ff00">
        <td class="fixed">주문번호</td>
        <td class="fixed">주문일자</td>
        <td>주문내역</td>
        <td>주문금액/수량</td>
        <td>주문상태</td>
        <td>주문자</td>
        <td>수령자</td>
        <td>주문취소</td>
    </tr>

    <c:choose>
        <c:when test="${empty myOrderHistList}">
            <tr>
                <td colspan="8" class="fixed">
                    <strong>주문한 상품이 없습니다.</strong>
                </td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach var="item" items="${myOrderHistList}" varStatus="i">
                <c:choose>
                    <c:when test="${item.orderId != preOrderId}">

                        <tr>
                            <td>
                                <a href="${contextPath}/mypage/myOrderDetail.do?orderId=${item.orderId}"><strong>${item.orderId}</strong></a>
                            </td>

                            <td>
                                <strong>${item.payOrderTime}</strong>
                            </td>

                            <td>
                                <strong>
                                    <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
                                        <c:if test="${item.orderId == item2.orderId}">
                                            <a href="${contextPath}/goods/goodsDetail.do?goodsId=${item2.goodsId}">${item2.goodsTitle}</a><br>
                                        </c:if>
                                    </c:forEach>
                                </strong>
                            </td>

                            <td>
                                <strong>
                                    <c:forEach var="item2" items="${myOrderHistList}" varStatus="j">
                                        <c:if test="${item.orderId}">
                                            ${item.goodsSalesPrice*item.orderGoodsQty}원/${item.orderGoodsQty}<br>
                                        </c:if>
                                    </c:forEach>
                                </strong>
                            </td>

                            <td>
                                <strong>
                                    <c:choose>
                                        <c:when test="${item.delivery_state=='deliveryPrepared'}"> 배송준비중 </c:when>
                                        <c:when test="${item.delivery_state=='delivering'}"> 배송중 </c:when>
                                        <c:when test="${item.delivery_state=='finishedDelivering'}"> 배송완료 </c:when>
                                        <c:when test="${item.delivery_state=='cancelOrder'}"> 주문취소 </c:when>
                                        <c:when test="${item.delivery_state=='returningGoods'}"> 반품 </c:when>
                                    </c:choose>
                                </strong>
                            </td>

                            <td><strong>${item.ordererName}</strong></td>

                            <td><strong>${item.receiverName}</strong></td>

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
<div class="clear"></div>
</body>
</html>