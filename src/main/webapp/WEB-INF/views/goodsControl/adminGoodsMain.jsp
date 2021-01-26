<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html >
<html>
<head>
    <meta charset="utf-8">
    <script>
        function search_goods_list(fixeSearchPeriod) {
            var formObj = document.createElement("form");
            var i_fixedSearch_period = document.createElement("input");
            i_fixedSearch_period.name = "fixedSearchPeriod";
            i_fixedSearch_period.value = searchPeriod;
            formObj.appendChild(i_fixedSearch_period);
            document.body.appendChild(formObj);
            formObj.method = "get";
            formObj.action = "${contextPath}/goodsControl/adminGoodsMain.do";
            formObj.submit();
        }

        function calcPeriod(search_period) {
            var dt = new Date();
            var beginYear, endYear;
            var beginMonth, endMonth;
            var beginDay, endDay;
            var beginDate, endDate;

            endYear = dt.getFullYear();
            endMonth = dt.getMonth() + 1;
            endDay = dt.getDate();
            if (search_period == 'today') {
                beginYear = endYear;
                beginMonth = endMonth;
                beginDay = endDay;
            } else if (search_period == 'one_week') {
                beginYear = dt.getFullYear();
                beginMonth = dt.getMonth() + 1;
                dt.setDate(endDay - 7);
                beginDay = dt.getDate();

            } else if (search_period == 'two_week') {
                beginYear = dt.getFullYear();
                beginMonth = dt.getMonth() + 1;
                dt.setDate(endDay - 14);
                beginDay = dt.getDate();
            } else if (search_period == 'one_month') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 1);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (search_period == 'two_month') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 2);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (search_period == 'three_month') {
                beginYear = dt.getFullYear();
                dt.setMonth(endMonth - 3);
                beginMonth = dt.getMonth();
                beginDay = dt.getDate();
            } else if (search_period == 'four_month') {
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
    </script>
</head>
<body>
<H3>상품 조회</H3>
<form method="post">
    <TABLE cellpadding="10" cellspacing="10">
        <TBODY>
        <TR>
            <TD>
                <input type="radio" name="r_search" checked/> 등록일로조회 &nbsp;&nbsp;&nbsp;
                <input type="radio" name="r_search"/>상세조회 &nbsp;&nbsp;&nbsp;
            </TD>
        </TR>
        <TR>
            <TD>
                <select name="curYear">
                    <c:forEach var="i" begin="0" end="5">
                        <c:choose>
                            <c:when test="${endYear==endYear-i}">
                                <option value="${endYear}" selected>${endYear}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${endYear-i }">${endYear-i }</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>년 <select name="curMonth">
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
                            <c:when test="${endDay==i}">
                                <option value="${i }" selected>${i }</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${i }">${i }</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>일 &nbsp;이전&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="javascript:search_goods_list('today')">
                    <img src="${contextPath}/image/btn_search_one_day.jpg">
                </a>
                <a href="javascript:search_goods_list('one_week')">
                    <img src="${contextPath}/image/btn_search_1_week.jpg">
                </a>
                <a href="javascript:search_goods_list('two_week')">
                    <img src="${contextPath}/image/btn_search_2_week.jpg">
                </a>
                <a href="javascript:search_goods_list('one_month')">
                    <img src="${pageContext.request.contextPath}/image/btn_search_1_month.jpg">
                </a>
                <a href="javascript:search_goods_list('two_month')">
                    <img src="${contextPath}/image/btn_search_2_month.jpg">
                </a>
                <a href="javascript:search_goods_list('three_month')">
                    <img src="${contextPath}/image/btn_search_3_month.jpg">
                </a>
                <a href="javascript:search_goods_list('four_month')">
                    <img src="${contextPath}/image/btn_search_4_month.jpg">
                </a>
                &nbsp;까지 조회
            </TD>
        </TR>

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
                <select name="s_search_type" disabled>
                    <option value="all" checked>전체</option>
                    <option value="orderer_name">주문자이름</option>
                    <option value="orderer_id">주문자아이디</option>
                    <option value="orderer_hp">주문자휴대폰번호</option>
                    <option value="orderer_goods">주문상품품명</option>
                </select>
                <input type="text" size="30" name="t_search_word" disabled/>
                <input type="button" value="조회" name="btn_search" onClick="fn_detail_search()" disabled/>
            </td>
        </tr>
        </TBODY>
    </TABLE>
    <DIV class="clear">
    </DIV>
</form>
<DIV class="clear"></DIV>
<TABLE class="list_view">
    <TBODY align=center>
    <tr style="background:#33ff00">
        <td>상품번호</td>
        <td>상품이름</td>
        <td>저자</td>
        <td>출판사</td>
        <td>상품가격</td>
        <td>입고일자</td>
        <td>출판일</td>
    </tr>
    <c:choose>
        <c:when test="${empty newGoodsList }">
            <TR>
                <TD colspan=8 class="fixed">
                    <strong>조회된 상품이 없습니다.</strong>
                </TD>
            </TR>
        </c:when>
        <c:otherwise>
            <c:forEach var="item" items="${newGoodsList }">
                <TR>
                    <TD>
                        <strong>${item.goods_id }</strong>
                    </TD>
                    <TD>
                        <a href="${pageContext.request.contextPath}/goodsControl/modifyGoodsForm.do?goods_id=${item.goods_id}">
                            <strong>${item.goods_title } </strong>
                        </a>
                    </TD>
                    <TD>
                        <strong>${item.goods_writer }</strong>
                    </TD>
                    <TD>
                        <strong>${item.goods_publisher }</strong>
                    </TD>
                    <td>
                        <strong>${item.goods_sales_price }</strong>
                    </td>
                    <td>
                        <strong>${item.goods_credate }</strong>
                    </td>
                    <td>
                        <c:set var="pub_date" value="${item.goods_published_date}"/>
                        <c:set var="arr" value="${fn:split(pub_date,' ')}"/>
                        <strong>
                            <c:out value="${arr[0]}"/>
                        </strong>
                    </td>

                </TR>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    <tr>
        <td colspan=8 class="fixed">
            <c:forEach var="page" begin="1" end="10" step="1">
            <c:if test="${section >1 && page==1 }">
            <a href="${contextPath}/goodsControl/adminGoodsMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
                &nbsp;</a>
            </c:if>
            <a href="${contextPath}/goodsControl/adminGoodsMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
            <c:if test="${page ==10 }">
            <a href="${contextPath}/goodsControl/adminGoodsMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp;
                next</a>
            </c:if>
            </c:forEach>

    </TBODY>

</TABLE>
<DIV class="clear"></DIV>
<br><br><br>
<H3>상품등록하기</H3>
<DIV id="search">
    <form action="${contextPath}/goodsControl/addNewGoodsForm.do">
        <input type="submit" value="상품 등록하기">
    </form>
</DIV>
</body>
</html>