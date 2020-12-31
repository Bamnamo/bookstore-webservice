<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!-- 주문자 휴대폰 번호 -->
<c:set var="orderer_hp" value=""/>
<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0"/>

<!-- 총주문 금액 -->
<c:set var="total_order_price" value="0"/>
<!-- 총 상품수 -->
<c:set var="total_order_goods_qty" value="0"/>
<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0"/>
<!-- 총 배송비 -->
<c:set var="total_delivery_price" value="0"/>

<head>
    <style>
        #layer {
            z-index: 2;
            position: absolute;
            top: 0px;
            left: 0px;
            width: 100%;
            /* background-color:rgba(0,0,0,0.8); */
        }

        #popup_order_detail {
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
    <script type="text/javascript">

        function init() {
            var form_order = document.form_order;
            var h_tel1 = form_order.h_tel1;
            var h_hp1 = form_order.h_hp1;
            var tel1 = h_tel1.value;
            var hp1 = h_hp1.value;
            var select_tel1 = form_order.tel1;
            var select_hp1 = form_order.hp1;
            select_tel1.value = tel1;
            select_hp1.value = hp1;
        }

        function fn_process_pay_order() {

            alert("최종 결제하기");
            var formObj = document.createElement("form");
            var i_receiver_name = document.createElement("input");

            var i_receiver_hp1 = document.createElement("input");
            var i_receiver_hp2 = document.createElement("input");
            var i_receiver_hp3 = document.createElement("input");

            var i_receiver_tel1 = document.createElement("input");
            var i_receiver_tel2 = document.createElement("input");
            var i_receiver_tel3 = document.createElement("input");

            var i_delivery_address = document.createElement("input");
            var i_delivery_message = document.createElement("input");
            var i_delivery_method = document.createElement("input");
            var i_gift_wrapping = document.createElement("input");
            var i_pay_method = document.createElement("input");
            var i_card_com_name = document.createElement("input");
            var i_card_pay_month = document.createElement("input");
            var i_pay_orderer_hp_num = document.createElement("input");

            i_receiver_name.name = "receiver_name";
            i_receiver_hp1.name = "receiver_hp1";
            i_receiver_hp2.name = "receiver_hp2";
            i_receiver_hp3.name = "receiver_hp3";

            i_receiver_tel1.name = "receiver_tel1";
            i_receiver_tel2.name = "receiver_tel2";
            i_receiver_tel3.name = "receiver_tel3";

            i_delivery_address.name = "delivery_address";
            i_delivery_message.name = "delivery_message";
            i_delivery_method.name = "delivery_method";
            i_gift_wrapping.name = "gift_wrapping";
            i_pay_method.name = "pay_method";
            i_card_com_name.name = "card_com_name";
            i_card_pay_month.name = "card_pay_month";
            i_pay_orderer_hp_num.name = "pay_orderer_hp_num";

            i_receiver_name.value = receiver_name;
            i_receiver_hp1.value = hp1;
            i_receiver_hp2.value = hp2;
            i_receiver_hp3.value = hp3;

            i_receiver_tel1.value = tel1;
            i_receiver_tel2.value = tel2;
            i_receiver_tel3.value = tel3;
            ;
            i_delivery_address.value = delivery_address;
            i_delivery_message.value = delivery_message;
            i_delivery_method.value = delivery_method;
            i_gift_wrapping.value = gift_wrapping;
            i_pay_method.value = pay_method;
            i_card_com_name.value = card_com_name;
            i_card_pay_month.value = card_pay_month;
            i_pay_orderer_hp_num.value = pay_orderer_hp_num;

            formObj.appendChild(i_receiver_name);
            formObj.appendChild(i_receiver_hp1);
            formObj.appendChild(i_receiver_hp2);
            formObj.appendChild(i_receiver_hp3);
            formObj.appendChild(i_receiver_tel1);
            formObj.appendChild(i_receiver_tel2);
            formObj.appendChild(i_receiver_tel3);
            formObj.appendChild(i_delivery_address);
            formObj.appendChild(i_delivery_message);
            formObj.appendChild(i_delivery_method);
            formObj.appendChild(i_gift_wrapping);

            formObj.appendChild(i_pay_method);
            formObj.appendChild(i_card_com_name);
            formObj.appendChild(i_card_pay_month);
            formObj.appendChild(i_pay_orderer_hp_num);

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
<form name="form_order">
    <table class="list_view">
        <tbody align=center>
        <tr style="background: #33ff00">
            <td colspan=2 class="fixed">주문상품명</td>
            <td>수량</td>
            <td>주문금액</td>
            <td>배송비</td>
            <td>예상적립금</td>
            <td>주문금액합계</td>
        </tr>
        <tr>
            <c:forEach var="item" items="${myOrderList }">
            <td class="goods_image">
                <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
                    <img width="75" alt=""
                         src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
                    <input type="hidden" id="h_goods_id" name="h_goods_id" value="${item.goods_id }"/>
                    <input type="hidden" id="h_goods_fileName" name="h_goods_fileName" value="${item.goods_fileName }"/>
                </a>
            </td>
            <td>
                <h2>
                    <a href="${pageContext.request.contextPath}/goods/goods.do?command=goods_detail&goods_id=${item.goods_id }">${item.goods_title }</A>
                    <input type="hidden" id="h_goods_title" name="h_goods_title" value="${item.goods_title }"/>
                </h2>
            </td>
            <td>
                <h2>${item.order_goods_qty }개<h2>
                    <input type="hidden" id="h_order_goods_qty" name="h_order_goods_qty"
                           value="${item.order_goods_qty}"/>
            </td>
            <td><h2>${item.goods_sales_price}원 (10% 할인)</h2></td>
            <td><h2>0원</h2></td>
            <td><h2>${1500 *item.order_goods_qty}원</h2></td>
            <td>
                <h2>${item.goods_sales_price * item.order_goods_qty}원</h2>
                <input type="hidden" id="h_each_goods_price" name="h_each_goods_price"
                       value="${item.goods_sales_price * item.order_goods_qty}"/>
            </td>
        </tr>
        <c:set var="final_total_order_price"
               value="${final_total_order_price+ item.goods_sales_price* item.order_goods_qty}"/>
        <c:set var="total_order_price"
               value="${total_order_price+ item.goods_sales_price* item.order_goods_qty}"/>
        <c:set var="total_order_goods_qty"
               value="${total_order_goods_qty+item.order_goods_qty }"/>
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
                    <input type="radio" id="delivery_method" name="delivery_method" value="일반택배" checked>일반택배 &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="delivery_method" name="delivery_method" value="편의점택배">편의점택배 &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="delivery_method" name="delivery_method" value="해외배송">해외배송 &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr class="dot_line">
                <td class="fixed_join">배송지 선택</td>
                <td><input type="radio" name="delivery_place"
                           onClick="restore_all()" value="기본배송지" checked>기본배송지 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="delivery_place" value="새로입력" onClick="reset_all()">새로입력 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="delivery_place" value="최근배송지">최근배송지 &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr class="dot_line">
                <td class="fixed_join">받으실 분</td>
                <td><input id="receiver_name" name="receiver_name" type="text" size="40"
                           value="${orderer.member_name }"/>
                    <input type="hidden" id="h_orderer_name" name="h_orderer_name" value="${orderer.member_name }"/>
                    <input type="hidden" id="h_receiver_name" name="h_receiver_name" value="${orderer.member_name }"/>
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
                    <input type="hidden" id="h_hp1" name="h_hp1" value="${orderer.hp1 }"/>
                    <input type="hidden" id="h_hp2" name="h_hp2" value="${orderer.hp2 }"/>
                    <input type="hidden" id="h_hp3" name="h_hp3" value="${orderer.hp3 }"/>
                    <c:set var="orderer_hp" value="${orderer.hp1}-${orderer.hp2}-${orderer.hp3 }"/>


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
                <input type="hidden" id="h_tel1" name="h_tel1" value="${orderer.tel1 }"/>
                <input type="hidden" id="h_tel2" name="h_tel2" value="${orderer.tel2 }"/>
                <input type="hidden" id="h_tel3" name="h_tel3" value="${orderer.tel3 }"/>
            </tr>
            <tr class="dot_line">
                <td class="fixed_join">주소</td>
                <td><input type="text" id="zipcode" name="zipcode" size="5"
                           value="${orderer.zipcode }">
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
                    <input type="hidden" id="h_zipcode" name="h_zipcode" value="${orderer.zipcode }"/>
                    <input type="hidden" id="h_roadAddress" name="h_roadAddress" value="${orderer.roadAddress }"/>
                    <input type="hidden" id="h_jibunAddress" name="h_jibunAddress" value="${orderer.jibunAddress }"/>
                    <input type="hidden" id="h_namujiAddress" name="h_namujiAddress" value="${orderer.namujiAddress }"/>
                </td>
            </tr>
            <tr class="dot_line">
                <td class="fixed_join">배송 메시지</td>
                <td>
                    <input id="delivery_message" name="delivery_message" type="text" size="50"
                           placeholder="택배 기사님께 전달할 메시지를 남겨주세요."/>
                </td>
            </tr>
            <tr class="dot_line">
                <td class="fixed_join">선물 포장</td>
                <td><input type="radio" id="gift_wrapping" name="gift_wrapping" value="yes">예
                    &nbsp;&nbsp;&nbsp; <input type="radio" id="gift_wrapping" name="gift_wrapping" checked value="no">아니요
                </td>
                </td>
                </tboby>
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
                    <input type="text" value="${orderer.member_name}" size="15"/>
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
                <td><input name="discount_juklip" type="text" size="10"/>원/1000원
                    &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두 사용하기
                </td>
            </tr>
            <tr class="dot_line">
                <td>예치금</td>
                <td><input name="discount_yechi" type="text" size="10"/>원/1000원
                    &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두 사용하기
                </td>
            </tr>
            <tr class="dot_line">
                <td>상품권 전환금</td>
                <td cellpadding="5"><input name="discount_sangpum" type="text"
                                           size="10"/>원/0원 &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두
                    사용하기
                </td>
            </tr>
            <tr class="dot_line">
                <td>OK 캐쉬백 포인트</td>
                <td cellpadding="5"><input name="discount_okcashbag" type="text"
                                           size="10"/>원/0원 &nbsp;&nbsp;&nbsp; <input type="checkbox"/> 모두
                    사용하기
                </td>
            </tr>
            <tr class="dot_line">
                <td>쿠폰할인</td>
                <td cellpadding="5"><input name="discount_coupon" type="text"
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
                <p id="p_totalNum">${total_order_goods_qty}개</p>
                <input id="h_total_order_goods_qty" type="hidden" value="${total_order_goods_qty}"/>
            </td>
            <td>
                <p id="p_totalPrice">${total_order_price}원</p> <input
                    id="h_totalPrice" type="hidden" value="${total_order_price}"/>
            </td>
            <td><IMG width="25" alt=""
                     src="${pageContext.request.contextPath}/image/plus.jpg"></td>
            <td>
                <p id="p_totalDelivery">${total_delivery_price }원</p> <input
                    id="h_totalDelivery" type="hidden" value="${total_delivery_price}"/>
            </td>
            <td>
                <img width="25" alt="" src="${pageContext.request.contextPath}/image/minus.jpg"></td>
            <td>
                <p id="p_totalSalesPrice">${total_discount_price }원</p>
                <input id="h_total_sales_price" type="hidden" value="${total_discount_price}"/>
            </td>
            <td><img width="25" alt="" src="${pageContext.request.contextPath}/image/equal.jpg"></td>
            <td>
                <p id="p_final_totalPrice">
                    <font size="15">${final_total_order_price }원 </font>
                </p> <input id="h_final_total_Price" type="hidden" value="${final_total_order_price}"/>
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
                    <input type="radio" id="pay_method" name="pay_method" value="신용카드" onClick="fn_pay_card()" checked>신용카드
                    &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="pay_method" name="pay_method" value="제휴 신용카드">제휴 신용카드 &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="pay_method" name="pay_method" value="실시간 계좌이체">실시간 계좌이체 &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="pay_method" name="pay_method" value="무통장 입금">무통장 입금 &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <input type="radio" id="pay_method" name="pay_method" value="휴대폰결제" onClick="fn_pay_phone()">휴대폰 결제
                    &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="pay_method" name="pay_method" value="카카오페이(간편결제)">카카오페이(간편결제) &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="pay_method" name="pay_method" value="페이나우(간편결제)">페이나우(간편결제) &nbsp;&nbsp;&nbsp;
                    <input type="radio" id="pay_method" name="pay_method" value="페이코(간편결제)">페이코(간편결제) &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <input type="radio" id="pay_method" name="pay_method" value="직접입금">직접입금&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr id="tr_pay_card">
                <td>
                    <strong>카드 선택<strong>:&nbsp;&nbsp;&nbsp;
                        <select id="card_com_name" name="card_com_name">
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
                            <select id="card_pay_month" name="card_pay_month">
                                <option value="일시불" selected>일시불</option>
                                <option value="2개월">2개월</option>
                                <option value="3개월">3개월</option>
                                <option value="4개월">4개월</option>
                                <option value="5개월">5개월</option>
                                <option value="6개월">6개월</option>
                            </select>

                </td>
            </tr>
            <tr id="tr_pay_phone" style="visibility:hidden">
                <td>
                    <strong>휴대폰 번호 입력: <strong>
                        <input type="text" size="5" value="" id="pay_order_tel1" name="pay_order_tel1"/>-
                        <input type="text" size="5" value="" id="pay_order_tel2" name="pay_order_tel2"/>-
                        <input type="text" size="5" value="" id="pay_order_tel3" name="pay_order_tel3"/>
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
    <br> <a href="javascript:fn_show_order_detail();">
    <img width="125" alt="" src="${contextPath}/image/btn_gulje.jpg">
</a> <a href="${contextPath}/main/main.do">
    <img width="75" alt="" src="${contextPath}/image/btn_shoping_continue.jpg">
</a>

    <div class="clear"></div>
    <div id="layer" style="visibility:hidden">
        <!-- visibility:hidden 으로 설정하여 해당 div안의 모든것들을 가려둔다. -->
        <div id="popup_order_detail">
            <!-- 팝업창 닫기 버튼 -->
            <a href="javascript:" onClick="javascript:imagePopup('close', '.layer01');">
                <img src="${contextPath}/image/close.png" id="close"/>
            </a>
            <br/>
            <div class="detail_table">
                <h1>최종 주문 사항</h1>
                <table>
                    <tbody align=left>
                    <tr>
                        <td width=200px>
                            주문상품번호:
                        </td>
                        <td>
                            <p id="p_order_goods_id"> 주문번호 </p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            주문상품명:
                        </td>
                        <td>
                            <p id="p_order_goods_title"> 주문 상품명 </p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            주문상품개수:
                        </td>
                        <td>
                            <p id="p_total_order_goods_qty"> 주문 상품개수 </p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            주문금액합계:
                        </td>
                        <td>
                            <p id="p_total_order_goods_price">주문금액합계</p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            주문자:
                        </td>
                        <td>
                            <p id="p_orderer_name"> 주문자 이름</p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            받는사람:
                        </td>
                        <td>
                            <p id="p_receiver_name">받는사람이름</p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            배송방법:
                        </td>
                        <td>
                            <p id="p_delivery_method">배송방법</p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            받는사람 휴대폰번호:
                        </td>
                        <td>
                            <p id="p_receiver_hp_num"></p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            받는사람 유선번화번호:
                        </td>
                        <td>
                            <p id="p_receiver_tel_num">배송방법</p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            배송주소:
                        </td>
                        <td align=left>
                            <p id="p_delivery_address">배송주소</p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            배송메시지:
                        </td>
                        <td align=left>
                            <p id="p_delivery_message">배송메시지</p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            선물포장 여부:
                        </td>
                        <td align=left>
                            <p id="p_gift_wrapping">선물포장</p>
                        </td>
                    </tr>
                    <tr>
                        <td width=200px>
                            결제방법:
                        </td>
                        <td align=left>
                            <p id="p_pay_method">결제방법</p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan=2 align=center>
                            <input name="btn_process_pay_order" type="button" onClick="fn_process_pay_order()"
                                   value="최종결제하기">
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="clear"></div>
            <br>



