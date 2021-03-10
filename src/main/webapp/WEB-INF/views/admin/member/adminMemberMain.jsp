<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <script>
        function searchMember(searchPeriod) {

            temp = calcPeriod(searchPeriod);
            var date = temp.split(",");
            beginDate = date[0];
            endDate = date[1];

            var formObj = document.createElement("form");
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
            formObj.action = "${contextPath}/admin/member/adminMemberMain.do";
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
            } else if (searchPeriod == 'oneWeek') {
                beginYear = dt.getFullYear();
                if (endDay - 7 < 1) {
                    beginMonth = dt.getMonth();
                } else {
                    beginMonth = dt.getMonth() + 1;
                }

                dt.setDate(endDay - 7);
                beginDay = dt.getDate();

            } else if (searchPeriod == 'twoWeek') {
                beginYear = dt.getFullYear();
                if (endDay - 14 < 1) {
                    beginMonth = dt.getMonth();
                } else {
                    beginMonth = dt.getMonth() + 1;
                }
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

            return beginDate + "," + endDate;
        }

        function fnMemberDetail(orderId) {

            var frmDeliveryList = document.frmDeliveryList;

            var formObj = document.createElement("form");
            var iOrderId = document.createElement("input");

            iOrderId.name = "orderId";
            iOrderId.value = orderId;

            formObj.appendChild(iOrderId);
            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/admin/member/memberDetail.do";
            formObj.submit();

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
            formObj.action = "${contextPath}/admin/member/memberDetail.do";
            formObj.submit();

        }
    </script>
</head>
<body>

<h3>회원 조회</h3>
<form name="frmDeliveryList">

    <table cellpadding="10" cellspacing="10">
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

                <a href="javascript:searchMember('today')"><img src="${pageContext.request.contextPath}/image/btn_search_one_day.jpg"></a>
                <a href="javascript:searchMember('oneWeek')"><img src="${pageContext.request.contextPath}/image/btn_search_1_week.jpg"></a>
                <a href="javascript:searchMember('twoWeek')"><img src="${pageContext.request.contextPath}/image/btn_search_2_week.jpg"></a>
                <a href="javascript:searchMember('oneMonth')"><img src="${pageContext.request.contextPath}/image/btn_search_1_month.jpg"></a>
                <a href="javascript:searchMember('twoMonth')"><img src="${pageContext.request.contextPath}/image/btn_search_2_month.jpg"></a>
                <a href="javascript:searchMember('threeMonth')"><img src="${pageContext.request.contextPath}/image/btn_search_3_month.jpg"></a>
                <a href="javascript:searchMember('fourMonth')"><img src="${pageContext.request.contextPath}/image/btn_search_4_month.jpg"></a>

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
                                    <c:when test="${i<10}">
                                        <option value="0${i}">0${i }</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${i}">${i }</option>
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
                    <option value="memberName">회원이름</option>
                    <option value="memberId">회원아이디</option>
                    <option value="memberHpNum">회원휴대폰번호</option>
                    <option value="memberAddr">회원주소</option>
                </select>
                <input type="text" size="30" name="btnSearchWord" disabled/>
                <input type="button" value="조회" name="btnSearch" onClick="fnDetailSearch()" disabled/>
            </td>
        </tr>

        </tbody>
    </table>

    <div class="clear">

    </div>

    <div class="clear"></div>

    <table class="list_view">
        <tbody align=center>

        <tr align=center bgcolor="#ffcc00">
            <td class="fixed">회원아이디</td>
            <td class="fixed">회원이름</td>
            <td>휴대폰번호</td>
            <td>주소</td>
            <td>가입일</td>
            <td>탈퇴여부</td>
        </tr>

        <c:choose>

            <c:when test="${empty memberList}">
                <tr>
                    <td colspan=5 class="fixed">
                    <strong>조회된 회원이 없습니다.</strong>
                    </td>
                </tr>
            </c:when>

            <c:otherwise>
                <c:forEach var="item" items="${memberList}" varStatus="item_num">

                    <tr>
                        <td width=10%>
                            <a href="${pageContext.request.contextPath}/admin/member/memberDetail.do?memberId=${item.memberId}">
                                <strong>${item.memberId}</strong>
                            </a>
                        </td>

                        <td width=10%>
                            <strong>${item.memberName}</strong><br>
                        </td>

                        <td width=10%>
                            <strong>${item.hp1}-${item.hp2}-${item.hp3}</strong><br>
                        </td>

                        <td width=50%>
                            <strong>${item.roadAddress}</strong><br>
                            <strong>${item.jibunAddress}</strong><br>
                            <strong>${item.namujiAddress}</strong><br>
                        </td>

                        <td width=10%>
                            <c:set var="joinDate" value="${item.joinDate}"/>
                            <c:set var="arr" value="${fn:split(joinDate,' ')}"/>
                            <strong><c:out value="${arr[0]}"/></strong>
                        </td>

                        <td width=10%>
                            <c:choose>
                                <c:when test="${item.delYn=='N' }">
                                    <strong>활동중</strong>
                                </c:when>
                                <c:otherwise>
                                    <strong>탈퇴</strong>
                                </c:otherwise>
                            </c:choose>
                        </td>

                    </tr>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <tr>
            <td colspan=8 class="fixed">
                <c:forEach var="page" begin="1" end="10" step="1">
                    <c:if test="${section >1 && page==1 }">
                        <a href="${contextPath}/admin/member/adminOrderMain.do?chapter=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;&nbsp;</a>
                    </c:if>
                    <a href="${contextPath}/admin/member/adminOrderMain.do?chapter=${section}&pageNum=${page}">${(section-1)*10 +page } </a>
                    <c:if test="${page ==10 }">
                        <a href="${contextPath}/admin/member/adminOrderMain.do?chapter=${section+1}&pageNum=${section*10+1}">&nbsp;
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