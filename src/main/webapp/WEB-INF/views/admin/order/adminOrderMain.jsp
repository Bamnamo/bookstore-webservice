<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <c:choose>
        <c:when test='${not empty orderGoodsList}'>
            <script type="text/javascript">
                window.onload = function () {
                    init();
                }

                //화면이 표시되면서  각각의 주문건에 대한 배송 상태를 표시한다.
                function init() {
                    var frmDeliveryList = document.frmDeliveryList;
                    var hDeliveryState = frmDeliveryList.hDeliveryState;
                    var sDeliveryState = frmDeliveryList.sDeliveryState;


                    if (hDeliveryState.length == undefined) {
                        sDeliveryState.value = hDeliveryState.value; //조회된 주문 정보가 1건인 경우
                    } else {
                        for (var i = 0; sDeliveryState.length; i++) {
                            sDeliveryState[i].value = hDeliveryState[i].value;//조회된 주문 정보가 여러건인 경우
                        }
                    }
                }
            </script>
        </c:when>
    </c:choose>

    <script>
        function searchOrderHistory(searchPeriod) {
            temp = calcPeriod(searchPeriod);
            var date = temp.split(",");
            beginDate = date[0];
            endDate = date[1];


            var formObj = document.createElement("form");
            var iCommand = document.createElement("input");
            var iBeginDate = document.createElement("input");
            var iEndDate = document.createElement("input");

            iBeginDate.name = "beginDate";
            iBeginDate.value = beginDate;
            iEndDate.name = "endDate";
            iEndDate.value = endDate;

            formObj.appendChild(iBeginDate);
            formObj.appendChild(iEndDate);
            document.body.appendChild(formObj);
            formObj.method = "get";
            formObj.action = "${contextPath}/admin/order/adminOrderMain.do";
            formObj.submit();
        }

        function calcPeriod(searchPeriod) {
            var dt = new Date();
            var beginYear, endYear;
            var beginMonth, endMonth;
            var beginDay, endDay;
            var beginDate, endDate;

            endYear = dt.getFullYear();
            endMonth = dt.getMonth() + 1;
            endDay = dt.getDate();
            if (searchPeriod == 'today') {
                beginYear = endYear;
                beginMonth = endMonth;
                beginDay = endDay;
            } else if (searchPeriod == 'one_week') {
                beginYear = dt.getFullYear();
                beginMonth = dt.getMonth() + 1;
                dt.setDate(endDay - 7);
                beginDay = dt.getDate();

            } else if (searchPeriod == 'twoWeek') {
                beginYear = dt.getFullYear();
                beginMonth = dt.getMonth() + 1;
                dt.setDate(endDay - 14);
                beginDay = dt.getDate();
            } else if (searchPeriod == 'oneMonth') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 1);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (searchPeriod == 'twoMonth') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 2);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (searchPeriod == 'threeMonth') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 3);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (searchPeriod == 'fourMonth') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 4);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            }

            if (beginMonth < 10) {
                beginMonth = '0' + beginMonth;
                if (beginDay < 10) {
                    beginDay = '0' + beginDay;
                }
            }
            if (endMonth < 10) {
                endMonth = '0' + endMonth;
                if (endDay < 10) {
                    endDay = '0' + endDay;
                }
            }
            endDate = endYear + '-' + endMonth + '-' + endDay;
            beginDate = beginYear + '-' + beginMonth + '-' + beginDay;
            //alert(beginDate+","+endDate);
            return beginDate + "," + endDate;
        }

        function fnModifyOrderState(orderId, selectId) {
            var sDeliveryState = document.getElementById(selectId);
            var index = sDeliveryState.selectedIndex;
            var value = sDeliveryState[index].value;

            $.ajax({
                type: "post",
                async: false,
                url: "${contextPath}/admin/order/modifyDeliveryState.do",
                data: {
                    orderId: orderId,
                    "deliveryState": value
                },
                success: function (data, textStatus) {
                    if (data.trim() == 'mod_success') {
                        alert("주문 정보를 수정했습니다.");
                        location.href = "${contextPath}/admin/order/adminOrderMain.do";
                    } else if (data.trim() == 'failed') {
                        alert("다시 시도해 주세요.");
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

        function fnEnableDetailSearch(rSearch) {
            var frmDeliveryList = document.frmDeliveryList;
            tBeginYear = frmDeliveryList.beginYear;
            tBeginMonth = frmDeliveryList.beginMonth;
            tBeginDay = frmDeliveryList.beginDay;
            tEndYear = frmDeliveryList.endYear;
            tEndMonth = frmDeliveryList.endMonth;
            tEndDay = frmDeliveryList.endDay;
            btnSearchType = frmDeliveryList.btnSearchType;
            btnSearchWord = frmDeliveryList.btnSearchWord;
            btnSearch = frmDeliveryList.btnSearch;

            if (rSearch.value == 'detailSearch') {
                tBeginYear.disabled = false;
                tBeginMonth.disabled = false;
                tBeginDay.disabled = false;
                tEndYear.disabled = false;
                tEndMonth.disabled = false;
                tEndDay.disabled = false;
                btnSearchType.disabled = false;
                btnSearchWord.disabled = false;
                btnSearch.disabled = false;
            } else {
                tBeginYear.disabled = true;
                tBeginMonth.disabled = true;
                tBeginDay.disabled = true;
                tEndYear.disabled = true;
                tEndMonth.disabled = true;
                tEndDay.disabled = true;
                btnSearchType.disabled = true;
                btnSearchWord.disabled = true;
                btnSearch.disabled = true;
            }
        }

        function fnDetailOrder(orderId) {

            var frmDeliveryList = document.frmDeliveryList;
            var formObj = document.createElement("form");
            var iOrderId = document.createElement("input");

            iOrderId.name = "orderId";
            iOrderId.value = orderId;

            formObj.appendChild(iOrderId);
            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/admin/order/orderDetail.do";
            formObj.submit();

        }

        //상세조회 버튼 클릭 시 수행
        function fnDetailSearch() {
            var frmDeliveryList = document.frmDeliveryList;

            beginYear = frmDeliveryList.beginYear.value;
            beginMonth = frmDeliveryList.beginMonth.value;
            beginDay = frmDeliveryList.beginDay.value;
            endYear = frmDeliveryList.endYear.value;
            endMonth = frmDeliveryList.endMonth.value;
            endDay = frmDeliveryList.endDay.value;
            searchType = frmDeliveryList.btnSearchType.value;
            searchWord = frmDeliveryList.btnSearchWord.value;
            var formObj = document.createElement("form");
            var iCommand = document.createElement("input");
            var iBeginDate = document.createElement("input");
            var iEndDate = document.createElement("input");
            var iSearchType = document.createElement("input");
            var iSearchWord = document.createElement("input");

            iCommand.name = "command";
            iBeginDate.name = "beginDate";
            iEndDate.name = "endDate";
            iSearchType.name = "searchType";
            iSearchWord.name = "searchWord";
            iCommand.value = "listDetailOrderGoods";
            iBeginDate.value = beginYear + "-" + beginMonth + "-" + beginDay;
            iEndDate.value = endYear + "-" + endMonth + "-" + endDay;
            iSearchType.value = searchType;
            iSearchWord.value = searchWord;

            formObj.appendChild(iCommand);
            formObj.appendChild(iBeginDate);
            formObj.appendChild(iEndDate);
            formObj.appendChild(iSearchType);
            formObj.appendChild(iSearchWord);
            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/admin/order/detailOrder.do";
            formObj.submit();
        }
    </script>
</head>
<body>

<h3>주문 조회</h3>
<form name="frmDeliveryList" action="${contextPath }/admin/order/adminOrderMain.do" method="post">
    <table>
        <tbody>

        <tr>
            <td>
                <input type="radio" name="rSearchOption" value="simpleSearch" checked onClick="fnEnableDetailSearch(this)"/> 간단조회 &nbsp;&nbsp;&nbsp;
                <input type="radio" name="rSearchOption" value="detailSearch" onClick="fnEnableDetailSearch(this)"/> 상세조회 &nbsp;&nbsp;&nbsp;
            </td>
        </tr>

        <tr>
            <td>
                <select name="curYear">
                    <c:forEach var="i" begin="0" end="5">
                        <c:choose>
                            <c:when test="${endYear==endYear-i}">
                                <option value="${endYear }" selected>${endYear  }</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${endYear-i }">${endYear-i }</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>년

                <select name="curMonth">
                    <c:forEach var="i" begin="1" end="12">
                        <c:choose>
                            <c:when test="${endMonth==i }">
                                <option value="${i }" selected>${i }</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i }">${i }</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>월

                <select name="curDay">
                    <c:forEach var="i" begin="1" end="31">
                        <c:choose>
                            <c:when test="${endDay==i }">
                                <option value="${i }" selected>${i }</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i }">${i }</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>일 &nbsp;이전&nbsp;&nbsp;&nbsp;&nbsp;

                <a href="javascript:searchOrderHistory('today')">         <img src="${contextPath}/image/btn_search_one_day.jpg"></a>
                <a href="javascript:searchOrderHistory('oneWeek')">      <img src="${contextPath}/image/btn_search_1_week.jpg"></a>
                <a href="javascript:searchOrderHistory('twoWeek')">      <img src="${contextPath}/image/btn_search_2_week.jpg"></a>
                <a href="javascript:searchOrderHistory('oneMonth')">     <img src="${contextPath}/image/btn_search_1_month.jpg"></a>
                <a href="javascript:searchOrderHistory('twoMonth')">     <img src="${contextPath}/image/btn_search_2_month.jpg"></a>
                <a href="javascript:searchOrderHistory('threeMonth')">   <img src="${contextPath}/image/btn_search_3_month.jpg"></a>
                <a href="javascript:searchOrderHistory('fourMonth')">    <img src="${contextPath}/image/btn_search_4_month.jpg"></a>
                &nbsp;까지 조회
            </td>
        </tr>

        <tr>
            <td>
                조회 기간:
                <select name="beginYear" disabled>
                    <c:forEach var="i" begin="0" end="5">
                        <c:choose>
                            <c:when test="${beginYear==beginYear-i }">
                                <option value="${beginYear-i }" selected>${beginYear-i  }</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${beginYear-i }">${beginYear-i }</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>년

                <select name="beginMonth" disabled>
                    <c:forEach var="i" begin="1" end="12">
                        <c:choose>
                            <c:when test="${beginMonth==i }">
                                <option value="${i }" selected>${i }</option>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${i <10 }">
                                        <option value="0${i }">0${i }</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${i }">${i }</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>월

                <select name="beginDay" disabled>
                    <c:forEach var="i" begin="1" end="31">
                        <c:choose>
                            <c:when test="${beginDay==i }">
                                <option value="${i }" selected>${i }</option>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${i <10 }">
                                        <option value="0${i }">0${i }</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${i }">${i }</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>일 &nbsp; ~

                <select name="endYear" disabled>
                    <c:forEach var="i" begin="0" end="5">
                        <c:choose>
                            <c:when test="${endYear==endYear-i }">
                                <option value="${2016-i }" selected>${2016-i  }</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${2016-i }">${2016-i }</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>년

                <select name="endMonth" disabled>
                    <c:forEach var="i" begin="1" end="12">
                        <c:choose>
                            <c:when test="${endMonth==i }">
                                <option value="${i }" selected>${i }</option>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${i <10 }">
                                        <option value="0${i }">0${i }</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${i }">${i }</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>월

                <select name="endDay" disabled>
                    <c:forEach var="i" begin="1" end="31">
                        <c:choose>
                            <c:when test="${endDay==i }">
                                <option value="${i }" selected>${i }</option>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${i <10 }">
                                        <option value="0${i }">0${i }</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${i }">${i }</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>

            </td>
        </tr>

        <tr>
            <td>
                <select name="btnSearchType" disabled>
                    <option value="all" checked>전체</option>
                    <option value="ordererName">주문자이름</option>
                    <option value="ordererId">주문자아이디</option>
                    <option value="ordererHp">주문자휴대폰번호</option>
                    <option value="ordererGoods">주문상품품명</option>
                </select>
                <input type="text" size="30" name="btnSearchWord" disabled/>
                <input type="button" value="조회" name="btnSearch" onClick="fnDetailSearch()" disabled/>
            </td>
        </tr>

        </tbody>
    </table>

    <div class="clear"></div>
    <div class="clear"></div>

    <table class="list_view">
        <tbody align=center>
        <tr style="background:#33ff00">
            <td class="fixed">주문번호</td>
            <td class="fixed">주문일자</td>
            <td>주문내역</td>
            <td>배송상태</td>
            <td>배송수정</td>
        </tr>
        <c:choose>
            <c:when test="${empty newOrderList}">
                <tr>
                    <td colspan=5 class="fixed">
                        <strong>주문한 상품이 없습니다.</strong>
                    </td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="item" items="${newOrderList}" varStatus="i">
                    <c:choose>
                        <c:when test="${item.orderId != preOrderId }">
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

                            <td width=10%>
                                <a href="javascript:fnDetailOrder('${item.orderId}')">
                                    <strong>${item.orderId}</strong>
                                </a>
                            </td>

                            <td width=20%><strong>${item.payOrderTime }</strong></td>

                            <td width=50% align=left>
                                <strong>주문자:${item.ordererName}</strong><br>
                                <strong>주문자 번화번호:${item.ordererHp}</strong><br>
                                <strong>수령자:${item.receiverName}</strong><br>
                                <strong>수령자 번화번호:${item.receiverHp1}-${item.receiverHp2}-${item.receiverHp3}</strong><br>
                                <strong>주문상품명(수량):${item.goodsTitle}(${item.orderGoodsQty})</strong><br>

                                <c:forEach var="item2" items="${newOrderList}" varStatus="j">
                                    <c:if test="${j.index > i.index }">
                                        <c:if test="${item.orderId ==item2.orderId}">
                                            <strong>주문상품명(수량):${item2.goodsTitle}(${item2.orderGoodsQty})</strong><br>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </td>

                            <td width=10%>
                                <select name="sDeliveryState${i.index }" id="sDeliveryState${i.index }">
                                    <c:choose>
                                        <c:when test="${item.deliveryState=='deliveryPrepared' }">
                                            <option value="deliveryPrepared" selected>배송준비중</option>
                                            <option value="delivering">배송중</option>
                                            <option value="finishedDelivering">배송완료</option>
                                            <option value="cancelOrder">주문취소</option>
                                            <option value="returningGoods">반품</option>
                                        </c:when>

                                        <c:when test="${item.deliveryState=='delivering' }">
                                            <option value="deliveryPrepared">배송준비중</option>
                                            <option value="delivering" selected>배송중</option>
                                            <option value="finishedDelivering">배송완료</option>
                                            <option value="cancelOrder">주문취소</option>
                                            <option value="returningGoods">반품</option>
                                        </c:when>

                                        <c:when test="${item.deliveryState=='finishedDelivering' }">
                                            <option value="deliveryPrepared">배송준비중</option>
                                            <option value="delivering">배송중</option>
                                            <option value="finishedDelivering" selected>배송완료</option>
                                            <option value="cancelOrder">주문취소</option>
                                            <option value="returningGoods">반품</option>
                                        </c:when>

                                        <c:when test="${item.deliveryState=='cancelOrder' }">
                                            <option value="deliveryPrepared">배송준비중</option>
                                            <option value="delivering">배송중</option>
                                            <option value="finishedDelivering">배송완료</option>
                                            <option value="cancelOrder" selected>주문취소</option>
                                            <option value="returningGoods">반품</option>
                                        </c:when>

                                        <c:when test="${item.deliveryState=='returningGoods' }">
                                            <option value="deliveryPrepared">배송준비중</option>
                                            <option value="delivering">배송중</option>
                                            <option value="finishedDelivering">배송완료</option>
                                            <option value="cancelOrder">주문취소</option>
                                            <option value="returningGoods" selected>반품</option>
                                        </c:when>
                                    </c:choose>
                                </select>
                            </td>

                            <td width=10%>
                                <input type="button" value="배송수정" onClick="fnModifyOrderState('${item.orderId}','sDeliveryState${i.index}')"/>
                            </td>

                            </tr>
                        </c:when>
                    </c:choose>
                    <c:set var="preOrderId" value="${item.orderId }"/>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <tr>
            <td colspan=8 class="fixed">
                <c:forEach var="page" begin="1" end="10" step="1">
                    <c:if test="${section >1 && page==1 }">
                        <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;&nbsp;</a>
                    </c:if>
                    <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
                    <c:if test="${page ==10 }">
                        <a href="${contextPath}/admin/order/adminOrderMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp;
                            next</a>
                    </c:if>
                </c:forEach>
            </td>
        </tr>

        </tbody>
    </table>
</form>
<div class="clear"></div>
</body>
</html>