<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- 주문자 휴대폰 번호 -->
<c:set var="ordererHp" value=""/>
<!-- 최종 결제 금액 -->
<c:set var="finalTotalOrderPrice" value="0"/>
<!-- 총주문 금액 -->
<c:set var="totalOrderPrice" value="0"/>
<!-- 총 상품수 -->
<c:set var="totalOrderGoodsQty" value="0"/>
<!-- 총할인금액 -->
<c:set var="totalDiscountPrice" value="0"/>
<!-- 총 배송비 -->
<c:set var="totalDeliveryPrice" value="2500"/>

<head>
    <style>
        #layer {
            z-index: 2;
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
        }

        #popupOrderDetail {
            z-index: 3;
            position: fixed;
            text-align: center;
            left: 10%;
            top: 0%;
            width: 60%;
            height: 100%;
            background-color: #ccff99;
            border: 2px solid #0000ff;
        }

        #close {
            z-index: 4;
            float: right;
        }
    </style>

    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                    // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                    var extraRoadAddr = ''; // 도로명 조합형 주소 변수
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = ' (' + extraRoadAddr + ')';
                    }
                    // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                    if (fullRoadAddr !== '') {
                        fullRoadAddr += extraRoadAddr;
                    }
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('zipCode').value = data.zonecode; //5자리 새우편번호 사용
                    document.getElementById('roadAddress').value = fullRoadAddr;
                    document.getElementById('jibunAddress').value = data.jibunAddress;
                    // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                    if (data.autoRoadAddress) {
                        //예상되는 도로명 주소에 조합형 주소를 추가한다.
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    } else if (data.autoJibunAddress) {
                        var expJibunAddr = data.autoJibunAddress;
                        document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    } else {
                        document.getElementById('guide').innerHTML = '';
                    }
                }
            }).open();
        }

        window.onload = function () {
            init();
        }

        function init() {
            var formOrder = document.formOrder;
            var hTel1 = formOrder.hTel1;
            var hHp1 = formOrder.hHp1;
            var tel1 = hTel1.value;
            var hp1 = hHp1.value;
            var selectTel1 = formOrder.tel1;
            var selectHp1 = formOrder.hp1;
            selectTel1.value = tel1;
            selectHp1.value = hp1;
        }

        function resetAll() {
            var eReceiverName = document.getElementById("receiverName");
            var eHp1 = document.getElementById("hp1");
            var eHp2 = document.getElementById("hp2");
            var eHp3 = document.getElementById("hp3");
            var eTel1 = document.getElementById("tel1");
            var eTel2 = document.getElementById("tel2");
            var eTel3 = document.getElementById("tel3");
            var eZipCode = document.getElementById("zipCode");
            var eRoadAddress = document.getElementById("roadAddress");
            var eJibunAddress = document.getElementById("jibunAddress");
            var eNamujiAddress = document.getElementById("namujiAddress");
            eReceiverName.value = "";
            eHp1.value = 0;
            eHp2.value = "";
            eHp3.value = "";
            eTel1.value = "";
            eTel2.value = "";
            eTel3.value = "";
            eZipCode.value = "";
            eRoadAddress.value = "";
            eJibunAddress.value = "";
            eNamujiAddress.value = "";
        }

        function restoreAll() {
            var eReceiverName = document.getElementById("receiverName");
            var eHp1 = document.getElementById("hp1");
            var eHp2 = document.getElementById("hp2");
            var eHp3 = document.getElementById("hp3");
            var eTel1 = document.getElementById("tel1");
            var eTel2 = document.getElementById("tel2");
            var eTel3 = document.getElementById("tel3");
            var eZipCode = document.getElementById("zipCode");
            var eRoadAddress = document.getElementById("roadAddress");
            var eJibunAddress = document.getElementById("jibunAddress");
            var eNamujiAddress = document.getElementById("namujiAddress");
            var hReceiverName = document.getElementById("hReceiverName");
            var hHp1 = document.getElementById("hHp1");
            var hHp2 = document.getElementById("hHp2");
            var hHp3 = document.getElementById("hHp3");
            var hTel1 = document.getElementById("hTel1");
            var hTel2 = document.getElementById("hTel2");
            var hTel3 = document.getElementById("hTel3");
            var hZipCode = document.getElementById("hZipCode");
            var hRoadAddress = document.getElementById("hRoadAddress");
            var hJibunAddress = document.getElementById("hJibunAddress");
            var hNamujiAddress = document.getElementById("hNamujiAddress");

            eReceiverName.value = hReceiverName.value;
            eHp1.value = hHp1.value;
            eHp2.value = hHp2.value;
            eHp3.value = hHp3.value;
            eTel1.value = hTel1.value;
            eTel2.value = hTel2.value;
            eTel3.value = hTel3.value;
            eZipCode.value = hZipCode.value;
            eRoadAddress.value = hRoadAddress.value;
            eJibunAddress.value = hJibunAddress.value;
            eNamujiAddress.value = hNamujiAddress.value;
        }

        function fnPayPhone() {

            var eCard = document.getElementById("trPayCard");
            var ePhone = document.getElementById("trPayPhone");
            eCard.style.visibility = "hidden";
            ePhone.style.visibility = "visible";
        }

        function fnPayCard() {
            var eCard = document.getElementById("trPayCard");
            var ePhone = document.getElementById("trPayPhone");
            eCard.style.visibility = "visible";
            ePhone.style.visibility = "hidden";
        }

        function imagePopup(type) {
            if (type == 'open') {
                // 팝업창을 연다.
                jQuery('#layer').attr('style', 'visibility:visible');
                // 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
                jQuery('#layer').height(jQuery(document).height());
            } else if (type == 'close') {
                // 팝업창을 닫는다.
                jQuery('#layer').attr('style', 'visibility:hidden');
            }
        }

        var goodsId = "";
        var goodsTitle = "";
        var goodsFileName = "";
        var orderGoodsQty
        var eachGoodsPrice;
        var totalOrderGoodsPrice;
        var totalOrderGoodsQty;
        var ordererName
        var receiverName
        var hp1;
        var hp2;
        var hp3;
        var tel1;
        var tel2;
        var tel3;
        var receiverHpNum;
        var receiverTelNum;
        var deliveryAddress;
        var deliveryMessage;
        var deliveryMethod;
        var giftWrapping;
        var payMethod;
        var cardComName;
        var cardPayMonth;
        var payOrdererHpNum;

        function fnShowOrderDetail() {
            goodsId = "";
            goodsTitle = "";

            var frm = document.formOrder;
            var hGoodsId = frm.hGoodsId;
            var hGoodsTitle = frm.hGoodsTitle;
            var hGoodsFileName = frm.hGoodsFileName;
            var rDeliveryMethod = frm.deliveryMethod;
            var hOrderGoodsQty = document.getElementById("hOrderGoodsQty");
            var hTotalOrderGoodsQty = document.getElementById("hTotalOrderGoodsQty");
            var hTotalSalesPrice = document.getElementById("hTotalSalesPrice");
            var hFinalTotalPrice = document.getElementById("hFinalTotalPrice");
            var hOrdererName = document.getElementById("hOrdererName");
            var iReceiverName = document.getElementById("receiverName");


            if (hGoodsId.length < 2 || hGoodsId.length == null) {
                goodsId += hGoodsId.value;
            } else {
                for (var i = 0; i < hGoodsId.length; i++) {
                    goodsId += hGoodsId[i].value + "<br>";

                }
            }

            if (hGoodsTitle.length < 2 || hGoodsTitle.length == null) {
                goodsTitle += hGoodsTitle.value;
            } else {
                for (var i = 0; i < hGoodsTitle.length; i++) {
                    goodsTitle += hGoodsTitle[i].value + "<br>";

                }
            }


            if (hGoodsFileName.length < 2 || hGoodsFileName.length == null) {
                goodsFileName += hGoodsFileName.value;
            } else {
                for (var i = 0; i < hGoodsFileName.length; i++) {
                    goodsFileName += hGoodsFileName[i].value + "<br>";

                }
            }


            totalOrderGoodsPrice = hFinalTotalPrice.value;
            totalOrderGoodsQty = hTotalOrderGoodsQty.value;

            for (var i = 0; i < rDeliveryMethod.length; i++) {
                if (rDeliveryMethod[i].checked == true) {
                    deliveryMethod = rDeliveryMethod[i].value
                    break;
                }
            }

            var rGiftWrapping = frm.giftWrapping;


            for (var i = 0; i < rGiftWrapping.length; i++) {
                if (rGiftWrapping[i].checked == true) {
                    giftWrapping = rGiftWrapping[i].value
                    break;
                }
            }

            var rPayMethod = frm.payMethod;

            for (var i = 0; i < rPayMethod.length; i++) {
                if (rPayMethod[i].checked == true) {
                    payMethod = rPayMethod[i].value
                    if (payMethod == "신용카드") {
                        var iCardComName = document.getElementById("cardComName");
                        var iCardPayMonth = document.getElementById("cardPayMonth");
                        cardComName = iCardComName.value;
                        cardPayMonth = iCardPayMonth.value;
                        payMethod += "<Br>" +
                            "카드사:" + cardComName + "<br>" +
                            "할부개월수:" + cardPayMonth;
                        payOrdererHpNum = "해당없음";

                    } else if (payMethod == "휴대폰결제") {
                        var iPayOrderTel1 = document.getElementById("payOrderTel1");
                        var iPayOrderTel2 = document.getElementById("payOrderTel2");
                        var iPayOrderTel3 = document.getElementById("payOrderTel3");
                        payOrdererHpNum = iPayOrderTel1.value + "-" +
                            iPayOrderTel2.value + "-" +
                            iPayOrderTel3.value;
                        payMethod += "<Br>" + "결제휴대폰번호:" + payOrdererHpNum;
                        cardComName = "해당없음";
                        cardPayMonth = "해당없음";
                    } //end if
                    break;
                }// end for
            }

            var iHp1 = document.getElementById("hp1");
            var iHp2 = document.getElementById("hp2");
            var iHp3 = document.getElementById("hp3");
            var iTel1 = document.getElementById("tel1");
            var iTel2 = document.getElementById("tel2");
            var iTel3 = document.getElementById("tel3");
            var iZipCode = document.getElementById("zipCode");
            var iRoadAddress = document.getElementById("roadAddress");
            var iJibunAddress = document.getElementById("jibunAddress");
            var iNamujiAddress = document.getElementById("namujiAddress");
            var iDeliveryMessage = document.getElementById("deliveryMessage");
            var iPayMethod = document.getElementById("payMethod");

            orderGoodsQty = hOrderGoodsQty.value;
            ordererName = hOrdererName.value;
            receiverName = iReceiverName.value;
            hp1 = iHp1.value;
            hp2 = iHp2.value;
            hp3 = iHp3.value;
            tel1 = iTel1.value;
            tel2 = iTel2.value;
            tel3 = iTel3.value;

            receiverHpNum = hp1 + "-" + hp2 + "-" + hp3;
            receiverTelNum = tel1 + "-" + tel2 + "-" + tel3;

            deliveryAddress = "우편번호:" + iZipCode.value + "<br>" +
                "도로명 주소:" + iRoadAddress.value + "<br>" +
                "[지번 주소:" + iJibunAddress.value + "]<br>" +
                iNamujiAddress.value;

            deliveryMessage = iDeliveryMessage.value;

            var pOrderGoodsId = document.getElementById("pOrderGoodsId");
            var pOrderGoodsTitle = document.getElementById("pOrderGoodsTitle");
            var pOrderGoodsQty = document.getElementById("pOrderGoodsQty");
            var pTotalOrderGoodsQty = document.getElementById("pTotalOrderGoodsQty");
            var pTotalOrderGoodsPrice = document.getElementById("pTotalOrderGoodsPrice");
            var pOrdererName = document.getElementById("pOrdererName");
            var pReceiverName = document.getElementById("pReceiverName");
            var pDeliveryMethod = document.getElementById("pDeliveryMethod");
            var pReceiverHpNum = document.getElementById("pReceiverHpNum");
            var pReceiverTelNum = document.getElementById("pReceiverTelNum");
            var pDeliveryAddress = document.getElementById("pDeliveryAddress");
            var pDeliveryMessage = document.getElementById("pDeliveryMessage");
            var pGiftWrapping = document.getElementById("pGiftWrapping");
            var pPayMethod = document.getElementById("pPayMethod");

            pOrderGoodsId.innerHTML = goodsId;
            pOrderGoodsTitle.innerHTML = goodsTitle;
            pTotalOrderGoodsQty.innerHTML = totalOrderGoodsQty + "개";
            pTotalOrderGoodsPrice.innerHTML = totalOrderGoodsPrice + "원";
            pOrdererName.innerHTML = ordererName;
            pReceiverName.innerHTML = receiverName;
            pDeliveryMethod.innerHTML = deliveryMethod;
            pReceiverHpNum.innerHTML = receiverHpNum;
            pReceiverTelNum.innerHTML = receiverTelNum;
            pDeliveryAddress.innerHTML = deliveryAddress;
            pDeliveryMessage.innerHTML = deliveryMessage;
            pGiftWrapping.innerHTML = giftWrapping;
            pPayMethod.innerHTML = payMethod;
            imagePopup('open');
        }

        function fnProcessPayOrder() {

            alert("최종 결제하기");
            var formObj = document.createElement("form");
            var iReceiverName = document.createElement("input");
            var iReceiverHp1 = document.createElement("input");
            var iReceiverHp2 = document.createElement("input");
            var iReceiverHp3 = document.createElement("input");
            var iReceiverTel1 = document.createElement("input");
            var iReceiverTel2 = document.createElement("input");
            var iReceiverTel3 = document.createElement("input");
            var iDeliveryAddress = document.createElement("input");
            var iDeliveryMessage = document.createElement("input");
            var iDeliveryMethod = document.createElement("input");
            var iGiftWrapping = document.createElement("input");
            var iPayMethod = document.createElement("input");
            var iCardComName = document.createElement("input");
            var iCardPayMonth = document.createElement("input");
            var iPayOrdererHpNum = document.createElement("input");

            iReceiverName.name = "receiverName";
            iReceiverHp1.name = "receiverHp1";
            iReceiverHp2.name = "receiverHp2";
            iReceiverHp3.name = "receiverHp3";
            iReceiverTel1.name = "receiverTel1";
            iReceiverTel2.name = "receiverTel2";
            iReceiverTel3.name = "receiverTel3";
            iDeliveryAddress.name = "deliveryAddress";
            iDeliveryMessage.name = "deliveryMessage";
            iDeliveryMethod.name = "deliveryMethod";
            iGiftWrapping.name = "giftWrapping";
            iPayMethod.name = "payMethod";
            iCardComName.name = "cardComName";
            iCardPayMonth.name = "cardPayMonth";
            iPayOrdererHpNum.name = "payOrdererHpNum";
            iReceiverName.value = receiverName;
            iReceiverHp1.value = hp1;
            iReceiverHp2.value = hp2;
            iReceiverHp3.value = hp3;
            iReceiverTel1.value = tel1;
            iReceiverTel2.value = tel2;
            iReceiverTel3.value = tel3;
            iDeliveryAddress.value = deliveryAddress;
            iDeliveryMessage.value = deliveryMessage;
            iDeliveryMethod.value = deliveryMethod;
            iGiftWrapping.value = giftWrapping;
            iPayMethod.value = payMethod;
            iCardComName.value = cardComName;
            iCardPayMonth.value = cardPayMonth;
            iPayOrdererHpNum.value = payOrdererHpNum;

            formObj.appendChild(iReceiverName);
            formObj.appendChild(iReceiverHp1);
            formObj.appendChild(iReceiverHp2);
            formObj.appendChild(iReceiverHp3);
            formObj.appendChild(iReceiverTel1);
            formObj.appendChild(iReceiverTel2);
            formObj.appendChild(iReceiverTel3);
            formObj.appendChild(iDeliveryAddress);
            formObj.appendChild(iDeliveryMessage);
            formObj.appendChild(iDeliveryMethod);
            formObj.appendChild(iGiftWrapping);
            formObj.appendChild(iPayMethod);
            formObj.appendChild(iCardComName);
            formObj.appendChild(iCardPayMonth);
            formObj.appendChild(iPayOrdererHpNum);

            document.body.appendChild(formObj);
            formObj.method = "post";
            formObj.action = "${contextPath}/order/payToOrderGoods.do";
            formObj.submit();
            imagePopup('close');
        }
    </script>
</head>
<body>

<H1>1.주문확인</H1>
<form name="formOrder">
    <table class="list_view">
        <tbody align=center>
        <tr style="background: #33ff00">
            <td colspan=2 class="fixed">주문상품명</td>
            <td>수량</td>
            <td>정가</td>
            <td>판매가</td>
            <td>예상적립금</td>
            <td>주문금액합계</td>
        </tr>
        <tr>
            <c:forEach var="item" items="${myOrderList }">

                <td class="goods_image">
                <a href="${contextPath}/goods/goodsDetail.do?goodsId=${item.goodsId }">
                    <img width="75" alt=""
                         src="${contextPath}/thumbnails.do?goodsId=${item.goodsId}&fileName=${item.goodsFileName}">
                    <input type="hidden" id="hGoodsId" name="hGoodsId" value="${item.goodsId }"/>
                    <input type="hidden" id="hGoodsFileName" name="hGoodsFileName" value="${item.goodsFileName }"/>
                </a>
                </td>

                <td>
                <h2>
                    <a href="${pageContext.request.contextPath}/goods/goods.do?command=goodsDetail&goodsId=${item.goodsId }">${item.goodsTitle }</A>
                    <input type="hidden" id="hGoodsTitle" name="hGoodsTitle" value="${item.goodsTitle }"/>
                </h2>
                </td>

                <td>
                    <h2>${item.orderGoodsQty}개</h2>
                    <input type="hidden" id="hOrderGoodsQty" name="hOrderGoodsQty" value="${item.orderGoodsQty}">
                </td>

                <td>
                    <fmt:formatNumber value="${item.goodsSalesPrice/0.9}" type="number" var="goodsPrice" />
                    <h2>${goodsPrice}원</h2>
                </td>

                <td>
                    <strong style="color: crimson">
                        <fmt:formatNumber value="${item.goodsSalesPrice}" type="number" var="discountedPrice"/>
                        ${discountedPrice}원 &#8595
                    </strong><br>
                    <p style="font-size: 11px">10% 할인</p>
                </td>

                <td><h2>${1500 *item.orderGoodsQty}원</h2></td>

                <td>
                    <fmt:formatNumber value="${item.goodsSalesPrice*item.orderGoodsQty+totalDeliveryPrice}" type="number" var="orderPrice" />
                <h2>${orderPrice}원</h2>
                <input type="hidden" id="hEachGoodsPrice" name="hEachGoodsPrice" value="${item.goodsSalesPrice*item.orderGoodsQty+totalDeliveryPrice}"/>
                </td>

        </tr>

        <c:set var="finalTotalOrderPrice" value="${finalTotalOrderPrice+item.goodsSalesPrice*item.orderGoodsQty+totalDeliveryPrice}"/>
        <c:set var="totalOrderPrice" value="${totalOrderPrice+(item.goodsSalesPrice/0.9)*item.orderGoodsQty}"/>
        <c:set var="totalDiscountPrice" value="${totalDiscountPrice+item.goodsSalesPrice*item.orderGoodsQty}" />
        <c:set var="totalOrderGoodsQty" value="${totalOrderGoodsQty+item.orderGoodsQty }"/>

        </c:forEach>
        </tbody>
    </table>
    <div class="clear"></div>

    <br>
    <br>

    <H1>2.배송지 정보</H1>
    <DIV class="detail_table">

        <table>
            <tbody>

            <tr class="dot_line">
                <td class="fixed_join">배송방법</td>
                <td>
                    <input type="radio" id="deliveryMethod" name="deliveryMethod" value="일반택배" checked>일반택배 &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="deliveryMethod" name="deliveryMethod" value="편의점택배">편의점택배 &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="deliveryMethod" name="deliveryMethod" value="해외배송">해외배송 &nbsp;&nbsp;&nbsp;
                </td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">배송지 선택</td>
                <td><input type="radio" name="delivery_place"
                           onClick="restoreAll()" value="기본배송지" checked>기본배송지 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="delivery_place" value="새로입력" onClick="resetAll()">새로입력 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="delivery_place" value="최근배송지">최근배송지 &nbsp;&nbsp;&nbsp;
                </td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">받으실 분</td>
                <td><input id="receiverName" name="receiverName" type="text" size="40"
                           value="${orderer.memberName }"/>
                    <input type="hidden" id="hOrdererName" name="hOrdererName" value="${orderer.memberName }"/>
                    <input type="hidden" id="hReceiverName" name="hReceiverName" value="${orderer.memberName }"/>
                </td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">휴대폰번호</td>
                <td><select id="hp1" name="hp1">
                    <option>없음</option>
                    <option value="010" selected>010</option>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="017">017</option>
                    <option value="018">018</option>
                    <option value="019">019</option>
                </select>
                    - <input size="10px" type="text" id="hp2" name="hp2" value="${orderer.hp2 }">
                    - <input size="10px" type="text" id="hp3" name="hp3" value="${orderer.hp3 }"><br><br>
                    <input type="hidden" id="hHp1" name="hHp1" value="${orderer.hp1 }"/>
                    <input type="hidden" id="hHp2" name="hHp2" value="${orderer.hp2 }"/>
                    <input type="hidden" id="hHp3" name="hHp3" value="${orderer.hp3 }"/>
                    <c:set var="ordererHp" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3 }"/>


            </tr>

            <tr class="dot_line">
                <td class="fixed_join">유선전화(선택)</td>
                <td><select id="tel1" name="tel1">
                    <option value="02">02</option>
                    <option value="031">031</option>
                    <option value="032">032</option>
                    <option value="033">033</option>
                    <option value="041">041</option>
                    <option value="042">042</option>
                    <option value="043">043</option>
                    <option value="044">044</option>
                    <option value="051">051</option>
                    <option value="052">052</option>
                    <option value="053">053</option>
                    <option value="054">054</option>
                    <option value="055">055</option>
                    <option value="061">061</option>
                    <option value="062">062</option>
                    <option value="063">063</option>
                    <option value="064">064</option>
                    <option value="0502">0502</option>
                    <option value="0503">0503</option>
                    <option value="0505">0505</option>
                    <option value="0506">0506</option>
                    <option value="0507">0507</option>
                    <option value="0508">0508</option>
                    <option value="070">070</option>
                </select> - <input size="10px" type="text" id="tel2" name="tel2" value="${orderer.tel2 }"> - <input
                        size="10px" type="text" id="tel3" name="tel3" value="${orderer.tel3 }">
                </td>
                <input type="hidden" id="hTel1" name="hTel1" value="${orderer.tel1 }"/>
                <input type="hidden" id="hTel2" name="hTel2" value="${orderer.tel2 }"/>
                <input type="hidden" id="hTel3" name="hTel3" value="${orderer.tel3 }"/>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">주소</td>
                <td><input type="text" id="zipCode" name="zipCode" size="5"
                           value="${orderer.zipCode }">
                    <a href="javascript:execDaumPostcode()">우편번호검색</a> <br>
                    <p>
                        지번 주소:<br>
                        <input type="text" id="roadAddress" name="roadAddress" size="50"
                               value="${orderer.roadAddress }"/><br>
                        <br> 도로명 주소:
                        <input type="text" id="jibunAddress" name="jibunAddress" size="50"
                               value="${orderer.jibunAddress }"/><br>
                        <br> 나머지 주소:
                        <input type="text" id="namujiAddress" name="namujiAddress" size="50"
                               value="${orderer.namujiAddress }"/>
                    </p>
                    <input type="hidden" id="hZipCode" name="hZipCode" value="${orderer.zipCode }"/>
                    <input type="hidden" id="hRoadAddress" name="hRoadAddress" value="${orderer.roadAddress }"/>
                    <input type="hidden" id="hJibunAddress" name="hJibunAddress" value="${orderer.jibunAddress }"/>
                    <input type="hidden" id="hNamujiAddress" name="hNamujiAddress" value="${orderer.namujiAddress }"/>
                </td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">배송 메시지</td>
                <td>
                    <input id="deliveryMessage" name="deliveryMessage" type="text" size="50"
                           placeholder="택배 기사님께 전달할 메시지를 남겨주세요."/>
                </td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">선물 포장</td>
                <td><input type="radio" id="giftWrapping" name="giftWrapping" value="yes">예
                    &nbsp;&nbsp;&nbsp; <input type="radio" id="giftWrapping" name="giftWrapping" checked value="no">아니요
                </td>
            </tr>

            </tbody>
        </table>
    </div>

    <div>
        <br><br>
        <h2>주문고객</h2>
        <table>
            <tbody>

            <tr class="dot_line">
                <td><h2>이름</h2></td>
                <td>
                    <input type="text" value="${orderer.memberName}" size="15"/>
                </td>
            </tr>

            <tr class="dot_line">
                <td><h2>핸드폰</h2></td>
                <td>
                    <input type="text" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3}" size="15"/>
                </td>
            </tr>

            <tr class="dot_line">
                <td><h2>이메일</h2></td>
                <td>
                    <input type="text" value="${orderer.email1}@${orderer.email2}" size="15"/>
                </td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="clear"></div>

    <br>
    <br>
    <br>


    <H1>3.할인 정보</H1>
    <div class="detail_table">
        <table>
            <tbody>

            <tr class="dot_line">
                <td width=100>적립금</td>
                <td><input name="discountJuklip" type="text" size="10"/>원/1000원
                    &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두 사용하기
                </td>
            </tr>

            <tr class="dot_line">
                <td>예치금</td>
                <td><input name="discountYechi" type="text" size="10"/>원/1000원
                    &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두 사용하기
                </td>
            </tr>

            <tr class="dot_line">
                <td>상품권 전환금</td>
                <td cellpadding="5"><input name="discountSangpum" type="text"
                                           size="10"/>원/0원 &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두
                    사용하기
                </td>
            </tr>

            <tr class="dot_line">
                <td>OK 캐쉬백 포인트</td>
                <td cellpadding="5"><input name="discountOkcashbag" type="text"
                                           size="10"/>원/0원 &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두
                    사용하기
                </td>
            </tr>

            <tr class="dot_line">
                <td>쿠폰할인</td>
                <td cellpadding="5"><input name="discountCoupon" type="text"
                                           size="10"/>원/0원 &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두
                    사용하기
                </td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="clear"></div>

    <br>

    <table width=80% class="list_view" style="background: #ccffff">
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

        <tr cellpadding=40 align=center>

            <td id="">
                <p id="pTotalNum"><h2>${totalOrderGoodsQty}개</h2></p>
                <input id="hTotalOrderGoodsQty" type="hidden" value="${totalOrderGoodsQty}"/>
            </td>

            <td>
                <p id="pTotalPrice">
                    <fmt:formatNumber value="${totalOrderPrice}" type="number" var="pTotalOrderPrice" />
                <h2>${pTotalOrderPrice}원</h2></p>
                <input id="hTotalPrice" type="hidden" value="${totalOrderPrice}"/>
            </td>

            <td><IMG width="25" alt=""
                     src="${pageContext.request.contextPath}/image/plus.jpg"></td>
            <td>
                <p id="pTotalDelivery">
                    <fmt:formatNumber value="${totalDeliveryPrice}" type="number" var="pTotalDeliveryPrice" />
                <h2>${pTotalDeliveryPrice }원</h2></p>
                <input id="hTotalDelivery" type="hidden" value="${totalDeliveryPrice}"/>
            </td>

            <td><img width="25" alt="" src="${pageContext.request.contextPath}/image/minus.jpg"></td>

            <td>
                <p id="pTotalSalesPrice">
                    <fmt:formatNumber value="${totalOrderPrice-totalDiscountPrice}" type="number" var="pTotalSalesPrice" />
                <h2>${pTotalSalesPrice}원</h2></p>
                <input id="hTotalSalesPrice" type="hidden" value="${totalDiscountPrice}"/>
            </td>

            <td><img width="25" alt="" src="${pageContext.request.contextPath}/image/equal.jpg"></td>

            <td>
                <p id="pFinalTotalPrice">
                <fmt:formatNumber value="${finalTotalOrderPrice}" type="number" var="pFinalTotalOrderPrice" />
                <h2>${pFinalTotalOrderPrice }원</h2></p>
                <input id="hFinalTotalPrice" type="hidden" value="${finalTotalOrderPrice}"/>
            </td>

        </tr>
        </tbody>
    </table>

    <div class="clear"></div>

    <br>
    <br>
    <br>

    <h1>4.결제정보</h1>
    <div class="detail_table">
        <table>
            <tbody>

            <tr>
                <td>
                    <input type="radio" id="payMethod" name="payMethod" value="신용카드" onClick="fnPayCard()" checked>신용카드&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="payMethod" name="payMethod" value="제휴 신용카드">제휴 신용카드 &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="payMethod" name="payMethod" value="실시간 계좌이체">실시간 계좌이체 &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="payMethod" name="payMethod" value="무통장 입금">무통장 입금 &nbsp;&nbsp;&nbsp;
                </td>
            </tr>

            <tr>
                <td>
                    <input type="radio" id="payMethod" name="payMethod" value="휴대폰결제" onClick="fnPayPhone()">휴대폰 결제&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="payMethod" name="payMethod" value="카카오페이(간편결제)">카카오페이(간편결제) &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="payMethod" name="payMethod" value="페이나우(간편결제)">페이나우(간편결제) &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="payMethod" name="payMethod" value="페이코(간편결제)">페이코(간편결제) &nbsp;&nbsp;&nbsp;
                </td>
            </tr>

            <tr>
                <td>
                    <input type="radio" id="payMethod" name="payMethod" value="직접입금">직접입금&nbsp;&nbsp;&nbsp;
                </td>
            </tr>

            <tr id="trPayCard">
                <td>
                    <strong>카드 선택<strong>:&nbsp;&nbsp;&nbsp;
                        <select id="cardComName" name="cardComName">
                            <option value="삼성" selected>삼성</option>
                            <option value="하나SK">하나SK</option>
                            <option value="현대">현대</option>
                            <option value="KB">KB</option>
                            <option value="신한">신한</option>
                            <option value="롯데">롯데</option>
                            <option value="BC">BC</option>
                            <option value="시티">시티</option>
                            <option value="NH농협">NH농협</option>
                        </select>

                        <br><Br>

                        <strong>할부 기간:<strong> &nbsp;&nbsp;&nbsp;
                            <select id="cardPayMonth" name="cardPayMonth">
                                <option value="일시불" selected>일시불</option>
                                <option value="2개월">2개월</option>
                                <option value="3개월">3개월</option>
                                <option value="4개월">4개월</option>
                                <option value="5개월">5개월</option>
                                <option value="6개월">6개월</option>
                            </select>

                </td>
            </tr>

            <tr id="trPayPhone" style="visibility:hidden">
                <td>
                    <strong>휴대폰 번호 입력: <strong>
                        <input type="text" size="5" value="" id="payOrderTel1" name="payOrderTel1"/>-
                        <input type="text" size="5" value="" id="payOrderTel2" name="payOrderTel2"/>-
                        <input type="text" size="5" value="" id="payOrderTel3" name="payOrderTel3"/>
                </td>
            </tr>

            </tbody>
        </table>
    </div>
</form>

<div class="clear"></div>

<br>
<br>
<br>

<center>
    <br>
    <br>

    <a href="javascript:fnShowOrderDetail();">
    <img width="125" alt="" src="${contextPath}/image/btn_gulje.jpg"></a>

    <a href="${contextPath}/main/main.do">
    <img width="75" alt="" src="${contextPath}/image/btn_shoping_continue.jpg"></a>

    <div class="clear"></div>

    <div id="layer" style="visibility:hidden">

        <!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
        <div id="popupOrderDetail">

            <!-- 팝업창 닫기 버튼 -->
            <a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');">
                <img src="${contextPath}/image/close.png" id="close"/></a>

            <br>

            <div class="detail_table">

                <h1>최종 주문 사항</h1>
                <table>

                    <tbody align=left>

                    <tr>
                        <td width=200px>주문상품번호: </td>
                        <td><p id="pOrderGoodsId"> 주문번호 </p></td>
                    </tr>

                    <tr>
                        <td width=200px>주문상품명:</td>
                        <td><p id="pOrderGoodsTitle"> 주문 상품명 </p></td>
                    </tr>

                    <tr>
                        <td width=200px>주문상품개수:</td>
                        <td><p id="pTotalOrderGoodsQty"> 주문 상품개수 </p></td>
                    </tr>

                    <tr>
                        <td width=200px>주문금액합계:</td>
                        <td><p id="pTotalOrderGoodsPrice">주문금액합계</p></td>
                    </tr>

                    <tr>
                        <td width=200px>주문자:</td>
                        <td><p id="pOrdererName"> 주문자 이름</p></td>
                    </tr>

                    <tr>
                        <td width=200px>받는사람:</td>
                        <td><p id="pReceiverName">받는사람이름</p></td>
                    </tr>

                    <tr>
                        <td width=200px>배송방법:</td>
                        <td><p id="pDeliveryMethod">배송방법</p></td>
                    </tr>

                    <tr>
                        <td width=200px>받는사람 휴대폰번호:</td>
                        <td><p id="pReceiverHpNum"></p></td>
                    </tr>

                    <tr>
                        <td width=200px>받는사람 유선번화번호:</td>
                        <td><p id="pReceiverTelNum">배송방법</p></td>
                    </tr>

                    <tr>
                        <td width=200px>배송주소:</td>
                        <td align=left><p id="pDeliveryAddress">배송주소</p></td>
                    </tr>

                    <tr>
                        <td width=200px>배송메시지:</td>
                        <td align=left><p id="pDeliveryMessage">배송메시지</p></td>
                    </tr>

                    <tr>
                        <td width=200px>선물포장 여부:</td>
                        <td align=left><p id="pGiftWrapping">선물포장</p></td>
                    </tr>

                    <tr>
                        <td width=200px>결제방법:</td>
                        <td align=left><p id="pPayMethod">결제방법</p></td>
                    </tr>

                    <tr>
                        <td colspan=2 align=center>
                            <input name="btnProcessPayOrder" type="button" onClick="fnProcessPayOrder()"
                                   value="최종결제하기">
                        </td>
                    </tr>

                    </tbody>
                </table>
            </div>

            <div class="clear"></div>

            <br>