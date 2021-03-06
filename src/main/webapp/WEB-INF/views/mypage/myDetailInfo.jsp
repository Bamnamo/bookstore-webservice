<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html >
<html>
<head>
    <meta charset="utf-8">
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    //팝업에서 검색결과 실행 코드
                    //도로명 주소의 노출 규칙에 따라 주소 조합
                    //내려오는 변수가 값이 없는 경우 공백('')  값을 가진다, 이를 참고하여 분기
                    var fullRoadAddr = data.roadAddress; //도로명 주소 변수
                    var extraRoadAddr = '';              //도로명 조합형 주소 변수

                    //법정동명이 있을 경우 추가한다.
                    //법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동/로/가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }

                    //건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingname !== '' && data.apartment == 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingname : data.buildingname);
                    }

                    //도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraRoadAddr !== '') {
                        extraRoadAddr = '(' + extraRoadAddr + ')';
                    }

                    //도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                    if (fullRoadAddr !== '') {
                        fullRoadAddr += extraRoadAddr;
                    }

                    //우편번호와 주소 정보를 해당 필드를 넣는다.
                    document.getElementById('zipCode').value = data.zonecode;
                    document.getElementById('roadAddress').value = fullRoadAddr;
                    document.getElementById('jibunAddress').value = data.jibunAddress;

                    //사용자가 '선택 안함'을 클릭한 경우, 예상 주소를 표시한다.
                    if (data.autoRoadAddress) {
                        //예상되는 도로명 주소에 조합형 주소를 추가
                        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + extraRoadAddr + ')';
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
            selectBoxInit();
        }

        function selectBoxInit() {
            var tel1 = '${memberInfo.tel1}';
            var hp1 = '${memberInfo.hp1}';
            var selTel1 = document.getElementById('tel1');
            var selHp1 = document.getElementById('hp1');
            var optionTel1 = selTel1.options;
            var optionHp1 = selHp1.options;
            var val;
            for (var i = 0; i < optionTel1.length; i++) {
                val = optionTel1[i].value;
                if (tel1 == val) {
                    optionTel1[i].selected = true;
                    break;
                }
            }

            for (var i = 0; i < optionHp1.length; i++) {
                val = optionHp1[i].value;
                if (hp1 == val) {
                    optionHp1[i].selected = true;
                    break;
                }
            }
        }

        function fnModifyMemberInfo(attribute) {
            var value;
            var frmModMember = document.frmModMember;
            if (attribute == 'memberPw') {
                value = frmModMember.memberPw.value;
            } else if (attribute == 'memberGender') {
                var memberGender = frmModMember.memberGender;
                for (var i = 0; memberGender.length; i++) {
                    if (memberGender[i].checked) {
                        value = memberGender[i].value;
                        break;
                    }
                }

            } else if (attribute == 'memberBirth') {
                var memberBirthY = frmModMember.memberBirthY;
                var memberBirthM = frmModMember.memberBirthM;
                var memberBirthD = frmModMember.memberBirthD;
                var memberBirthGn = frmModMember.memberBirthGn;

                for (var i = 0; memberBirthY.length; i++) {
                    if (memberBirthY[i].selected) {
                        valueY = memberBirthY[i].value;
                        break;
                    }
                }
                for (var i = 0; memberBirthM.length; i++) {
                    if (memberBirthM[i].selected) {
                        valueM = memberBirthM[i].value;
                        break;
                    }
                }

                for (var i = 0; memberBirthD.length; i++) {
                    if (memberBirthD[i].selected) {
                        valueD = memberBirthD[i].value;
                        break;
                    }
                }

                //alert("수정 년:"+value_y+","+value_m+","+value_d);
                for (var i = 0; memberBirthGn.length; i++) {
                    if (memberBirthGn[i].checked) {
                        valueGn = memberBirthGn[i].value;
                        break;
                    }
                }
                //alert("생년 양음년 "+value_gn);
                value = +valueY + "," + valueM + "," + valueD + "," + valueGn;
            } else if (attribute == 'tel') {
                var tel1 = frmModMember.tel1;
                var tel2 = frmModMember.tel2;
                var tel3 = frmModMember.tel3;

                for (var i = 0; tel1.length; i++) {
                    if (tel1[i].selected) {
                        valueTel1 = tel1[i].value;
                        break;
                    }
                }
                valueTel2 = tel2.value;
                valueTel3 = tel3.value;
                value = valueTel1 + "," + valueTel2 + ", " + valueTel3;
            } else if (attribute == 'hp') {
                var hp1 = frmModMember.hp1;
                var hp2 = frmModMember.hp2;
                var hp3 = frmModMember.hp3;
                var smsstsYn = frmModMember.smsstsYn;

                for (var i = 0; hp1.length; i++) {
                    if (hp1[i].selected) {
                        valueHp1 = hp1[i].value;
                        break;
                    }
                }
                valueHp2 = hp2.value;
                valueHp3 = hp3.value;
                valueSmsstsYn = smsstsYn.checked;
                value = valueHp1 + "," + valueHp2 + ", " + valueHp3 + "," + valueSmsstsYn;
            } else if (attribute == 'email') {
                var email1 = frmModMember.email1;
                var email2 = frmModMember.email2;
                var emailstsYn = frmModMember.emailstsYn;

                valueEmail1 = email1.value;
                valueEmail2 = email2.value;
                valueEmailstsYn = emailstsYn.checked;
                value = valueEmail1 + "," + valueEmail2 + "," + valueEmailstsYn;
                //alert(value);
            } else if (attribute == 'address') {
                var zipCode = frmModMember.zipcode;
                var roadAddress = frmModMember.roadAddress;
                var jibunAddress = frmModMember.jibunAddress;
                var namujiAddress = frmModMember.namujiAddress;

                valueZipCode = zipCode.value;
                valueRoadAddress = roadAddress.value;
                valueJibunAddress = jibunAddress.value;
                valueNamujiAddress = namujiAddress.value;
                value = valueZipCode + "," + valueRoadAddress + "," + valueJibunAddress + "," + valueNamujiAddress;
            }
            console.log(attribute);

            $.ajax({
                type: "post",
                async: false, //false인 경우 동기식으로 처리한다.
                url: "${contextPath}/mypage/modifyMyInfo.do",
                data: {
                    attribute: attribute,
                    value: value,
                },
                success: function (data, textStatus) {
                    if (data.trim() == 'mod_success') {
                        alert("회원 정보를 수정했습니다.");
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
    </script>
</head>

<body>

<h3>내 상세 정보</h3>
<form name="frmModMember">

    <div id="detail_table">
        <table>
            <tbody>

            <tr class="dot_line">
                <td class="fixed_join">아이디</td>
                <td><input name="memberId" type="text" size="20" value="${memberInfo.memberId }" disabled/></td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">비밀번호</td>
                <td><input name="memberPw" type="password" size="20" value="${memberInfo.memberPw }"/></td>
                <td><input type="button" value="수정하기" onClick="fnModifyMemberInfo('memberPw')"/></td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">이름</td>
                <td><input name="memberName" type="text" size="20" value="${memberInfo.memberName }" disabled/></td>
            </tr>

            <tr class="dot_line">

                <td class="fixed_join">성별</td>
                <td>
                    <c:choose>
                        <c:when test="${memberInfo.memberGender =='101' }">
                            <input type="radio" name="memberGender" value="102"/>여성
                            <span style="padding-left:30px"></span>
                            <input type="radio" name="memberGender" value="101" checked/>남성
                        </c:when>
                        <c:otherwise>
                            <input type="radio" name="memberGender" value="102" checked/>여성
                            <span style="padding-left:30px"></span>
                            <input type="radio" name="memberGender" value="101"/>남성
                        </c:otherwise>
                    </c:choose>
                </td>

                <td><input type="button" value="수정하기" onClick="fnModifyMemberInfo('memberGender')"/></td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">법정생년월일</td>

                <td>
                    <select name="memberBirthY">
                        <c:forEach var="i" begin="1" end="100">
                            <c:choose>
                                <c:when test="${memberInfo.memberBirthY==1920+i }">
                                    <option value="${ 1920+i}" selected>${ 1920+i} </option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${ 1920+i}">${ 1920+i} </option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>년

                    <select name="memberBirthM">
                        <c:forEach var="i" begin="1" end="12">
                            <c:choose>
                                <c:when test="${memberInfo.memberBirthM==i }">
                                    <option value="${i }" selected>${i }</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${i }">${i }</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>월

                    <select name="memberBirthD">
                        <c:forEach var="i" begin="1" end="31">
                            <c:choose>
                                <c:when test="${memberInfo.memberBirthD==i }">
                                    <option value="${i }" selected>${i }</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${i }">${i }</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>일

                    <span style="padding-left:40px"></span>

                    <c:choose>
                        <c:when test="${memberInfo.memberBirthGn=='2' }">
                            <input type="radio" name="memberBirthGn" value="2" checked/>양력
                            <span style="padding-left:20px"></span>
                            <input type="radio" name="memberBirthGn" value="1"/>음력
                        </c:when>
                        <c:otherwise>
                            <input type="radio" name="memberBirthGn" value="2"/>양력
                            <input type="radio" name="memberBirthGn" value="1" checked/>음력
                        </c:otherwise>
                    </c:choose>
                </td>

                <td><input type="button" value="수정하기" onClick="fnModifyMemberInfo('memberBirth')"/></td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">전화번호</td>
                <td>
                    <select name="tel1" id="tel1">
                        <option value="00">없음</option>
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
                    </select>
                    - <input type="text" size=4 name="tel2" value="${memberInfo.tel2 }">
                    - <input type="text" size=4 name="tel3" value="${memberInfo.tel3 }">
                </td>

                <td>
                    <input type="button" value="수정하기" onClick="fnModifyMemberInfo('tel')"/>
                </td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">휴대폰번호</td>

                <td>
                    <select name="hp1" id="hp1">
                        <option>없음</option>
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select>
                    - <input type="text" name="hp2" size=4 value="${memberInfo.hp2 }">
                    - <input type="text" name="hp3" size=4 value="${memberInfo.hp3 }"><br> <br>
                    <c:choose>
                        <c:when test="${memberInfo.smsstsYn=='true' }">
                            <input type="checkbox" name="smsstsYn" value="Y" checked/> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
                        </c:when>
                        <c:otherwise>
                            <input type="checkbox" name="smsstsYn" value="N"/> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.
                        </c:otherwise>
                    </c:choose>
                </td>

                <td><input type="button" value="수정하기" onClick="fnModifyMemberInfo('hp')"/></td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">이메일<br>(e-mail)</td>
                <td>
                    <input type="text" name="email1" size=10 value="${memberInfo.email1 }"/> @ <input type="text"
                                                                                                      size=10
                                                                                                      name="email2"
                                                                                                      value="${memberInfo.email2 }"/>
                    <select name="selectEmail2" onChange="" title="직접입력">
                        <option value="non">직접입력</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="naver.com">naver.com</option>
                        <option value="yahoo.co.kr">yahoo.co.kr</option>
                        <option value="hotmail.com">hotmail.com</option>
                        <option value="paran.com">paran.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="google.com">google.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="empal.com">empal.com</option>
                        <option value="korea.com">korea.com</option>
                        <option value="freechal.com">freechal.com</option>
                    </select>

                    <br>
                    <br>

                    <c:choose>
                        <c:when test="${memberInfo.emailstsYn=='true' }">
                            <input type="checkbox" name="emailstsYn" value="Y" checked/> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
                        </c:when>
                        <c:otherwise>
                            <input type="checkbox" name="emailstsYn" value="N"/> 쇼핑몰에서 발송하는 e-mail을 수신합니다.
                        </c:otherwise>
                    </c:choose>

                </td>

                <td><input type="button" value="수정하기" onClick="fnModifyMemberInfo('email')"/></td>
            </tr>

            <tr class="dot_line">
                <td class="fixed_join">주소</td>

                <td>
                    <input type="text" id="zipCode" name="zipCode" size=5 value="${memberInfo.zipCode }"> <a
                        href="javascript:execDaumPostcode()">우편번호검색</a>
                    <br>
                    <p>
                        지번 주소:<br><input type="text" id="roadAddress" name="roadAddress" size="50" value="${memberInfo.roadAddress }"><br><br>
                        도로명 주소: <input type="text" id="jibunAddress" name="jibunAddress" size="50" value="${memberInfo.jibunAddress }"><br><br>
                        나머지 주소: <input type="text" name="namujiAddress" size="50" value="${memberInfo.namujiAddress }"/>
                    </p>
                </td>

                <td><input type="button" value="수정하기" onClick="fnModifyMemberInfo('address')"/></td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="clear">

        <br>
        <br>

        <table align=center>
            <tr>
                <td>
                    <input type="hidden" name="command" value="modifyMyInfo"/>
                    <input name="btnCancelMember" type="button" value="수정 취소">
                </td>
            </tr>
        </table>

    </div>

    <input type="hidden" name="hTel1" value="${memberInfo.tel1}"/>
    <input type="hidden" name="hHp1" value="${memberInfo.hp1}"/>

</form>
</body>
</html>