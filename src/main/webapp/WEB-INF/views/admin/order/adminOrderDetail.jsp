<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="orderList"  value="${orderMap.orderList}"  />
<c:set var="deliveryInfo"  value="${orderMap.deliveryInfo}"  />
<c:set var="orderer"  value="${orderMap.orderer}"  />

<script  type="text/javascript">

    function fnModifyOrderState(orderId){
        var sDeliveryState=document.getElementById("sDeliveryState");
        var index = sDeliveryState.selectedIndex;   //선택한 옵션의 인덱스를 구합니다.
        var value = sDeliveryState[index].value;    //선택한 옵션의 값을 구합니다.
        console.log("value: " +value);
        $.ajax({
            type : "post",
            async : false, //false인 경우 동기식으로 처리한다.
            url : "${contextPath}/admin/order/modifyDeliveryState.do",
            data : {
                orderId:orderId,
                'deliveryState':value
            },
            success : function(data, textStatus) {
                if(data.trim()=='mod_success'){
                    alert("주문 정보를 수정했습니다.");
                    location.href="${contextPath}/orderControl/orderDetail.do?orderId="+orderId;
                }else if(data.trim()=='failed'){
                    alert("다시 시도해 주세요.");
                }
            },
            error : function(data, textStatus) {
                alert("에러가 발생했습니다."+data);
            },
            complete : function(data, textStatus) {
                //alert("작업을완료 했습니다");
            }
        }); //end ajax
    }
</script>
</head>
<body>

<h11>1. 주문 상세정보</h11>

<table class="list_view">
    <tbody align=center>
    <tr style="background: #33ff00">
        <td>주문번호 </td>
        <td colspan=2 class="fixed">주문상품명</td>
        <td>수량</td>
        <td>주문금액</td>
        <td>배송비</td>
        <td>예상적립금</td>
        <td>주문금액합계</td>
    </tr>

    <tr>
        <c:forEach var="item" items="${orderList }">

            <td> ${item.orderId }</td>

            <td class="goods_image">
                <a href="${contextPath}/goods/goodsDetail.do?goodsId=${item.goodsId }">
                    <img width="75" alt=""  src="${contextPath}/thumbnails.do?goodsId=${item.goodsId}&fileName=${item.goodsFileName}">
                </a>
            </td>

            <td><h2><a href="${contextPath}/goods/goodsDetail.do?goodsId=${item.goodsId }">${item.goodsTitle }</a></h2></td>

            <td><h2>${item.orderGoodsQty }개<h2></td>

            <td><h2>${item.orderGoodsQty *item.goodsSalesPrice}원 (10% 할인)</h2></td>

            <td><h2>0원</h2></td>

            <td><h2>${1500 *item.orderGoodsQty }원</h2></td>

            <td><h2>${item.orderGoodsQty *item.goodsSalesPrice}원</h2></td>
    </tr>
    </c:forEach>
    </tbody>
</table>

<div class="clear"></div>

<form name="frmDeliveryList" >
    <br>
    <br>
    <h1>2.배송지 정보</h1>
    <div class="detail_table">

        <table>
            <tbody>

            <tr class="dot_line">
                <td class="fixed_join">배송방법</td>
                <td>${deliveryInfo.deliveryMethod }</td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">받으실 분</td>
                <td>${deliveryInfo.receiverName }</td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">휴대폰번호</td>
                <td>${deliveryInfo.receiverHp1}-${deliveryInfo.receiverHp2}-${deliveryInfo.receiverHp3}</td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">유선전화(선택)</td>
                <td>${deliveryInfo.receiverTel1}-${deliveryInfo.receiverTel2}-${deliveryInfo.receiverTel3}</td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">주소</td>
                <td>${deliveryInfo.deliveryAddress}</td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">배송 메시지</td>
                <td>${deliveryInfo.deliveryMessage}</td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">선물 포장</td>
                <td>${deliveryInfo.giftWrapping}</td>
            </tr>

            </tbody>
        </table>
    </div>

    <div>
        <br><br>

        <h2>주문고객</h2>
        <table >
            <tbody>

            <tr class="dot_line">
                <td ><h2>이름</h2></td>
                <td><input  type="text" value="${orderer.memberName}" size="15" disabled /></td>
            </tr>

            <tr class="dot_line">
                <td ><h2>핸드폰</h2></td>
                <td><input  type="text" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15" disabled /></td>
            </tr>

            <tr class="dot_line">
                <td><h2>이메일</h2></td>
                <td><input  type="text" value="${orderer.email1}@${orderer.email2}" size="15" disabled /></td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="clear"></div>

    <br>
    <br>
    <br>

    <h1>3.결제정보</h1>
    <div class="detail_table">
        <table>
            <tbody>

            <tr class="dot_line">
                <td class="fixed_join">결제방법</td>
                <td>${deliveryInfo.payMethod }</td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">결제카드</td>
                <td>${deliveryInfo.cardComName}</td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">할부기간</td>
                <td>${deliveryInfo.cardPayMonth }</td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="clear"></div>

    <br>
    <br>
    <br>

    <h1>3.배송상태</h1>
    <div class="detail_table">
        <table>
            <tbody>
            <tr class="dot_line">
                <td>
                    <select name="sDeliveryState"  id="sDeliveryState">
                        <c:choose>

                            <c:when test="${deliveryInfo.deliveryState=='deliveryPrepared' }">
                                <option  value="deliveryPrepared" selected>배송준비중</option>
                                <option  value="delivering">배송중</option>
                                <option  value="finishedDelivering">배송완료</option>
                                <option  value="cancelOrder">주문취소</option>
                                <option  value="returningGoods">반품</option>
                            </c:when>

                            <c:when test="${deliveryInfo.deliveryState=='delivering' }">
                                <option  value="deliveryPrepared" >배송준비중</option>
                                <option  value="delivering" selected >배송중</option>
                                <option  value="finishedDelivering">배송완료</option>
                                <option  value="cancelOrder">주문취소</option>
                                <option  value="returningGoods">반품</option>
                            </c:when>

                            <c:when test="${deliveryInfo.deliveryState=='finishedDelivering' }">
                                <option  value="deliveryPrepared" >배송준비중</option>
                                <option  value="delivering"  >배송중</option>
                                <option  value="finishedDelivering" selected>배송완료</option>
                                <option  value="cancelOrder">주문취소</option>
                                <option  value="returningGoods">반품</option>
                            </c:when>

                            <c:when test="${deliveryInfo.deliveryState=='cancelOrder' }">
                                <option  value="deliveryPrepared" >배송준비중</option>
                                <option  value="delivering"  >배송중</option>
                                <option  value="finishedDelivering" >배송완료</option>
                                <option  value="cancelOrder" selected>주문취소</option>
                                <option  value="returningGoods">반품</option>
                            </c:when>

                            <c:when test="${deliveryInfo.deliveryState=='returningGoods' }">
                                <option  value="deliveryPrepared" >배송준비중</option>
                                <option  value="delivering"  >배송중</option>
                                <option  value="finishedDelivering" >배송완료</option>
                                <option  value="cancelOrder" >주문취소</option>
                                <option  value="returningGoods" selected>반품</option>
                            </c:when>

                        </c:choose>
                    </select>
                    <input  type="hidden" name="hDeliveryState" value="${deliveryInfo.deliveryState }" />
                </td>

                <td width=10%><input  type="button" value="배송수정"  onClick="fnModifyOrderState('${deliveryInfo.orderId}')"/></td>
            </tr>

            </tbody>
        </table>
    </div>
</form>

<div class="clear"></div>
<br>
<br>
<br>
<br>
<br>
<div class="clear"></div>