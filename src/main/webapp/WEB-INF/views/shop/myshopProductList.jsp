<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<script>
    $(document).ready(function () {
        console.log('shopId ', tempParam.shopId);
        productListFn();
        $(document).on("click", ".btngropu4", function () {
            var btnValue = $(this).val();
            productListFn(btnValue);
            // alert($(this).val());
        });
        function productListFn(btnValue) {
            $.ajax({
                url: "${pageContext.request.contextPath}/shop/myshopProductList.do?shopId=" + tempParam.shopId,
                type: "GET",
                contentType: "application/json; charset:UTF-8",
                dataType: "json",
                data: {
                    "btnValue": btnValue
                },
                error: function (request, status, error) {
                    console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                },
                success: function (data) {
                    $('#totalDiv').html(data.productListSize + "개");
                    displayList(data);
                }
            });
        };
    });
    function productDetail(productId) {
        location.href = "${pageContext.request.contextPath}/product/productDetail.do?productId=" + productId;
    }
    function displayList(data) {
        $('#product-list *').remove();
        $('#pagebar *').remove();
        var html = "";
        console.log("data: " + data.productList.length);
        if (data.productList.length == 0) {
            html += "<table>";
            html += "<tr>";
            html += "<td>";
            html += "<div style='margin-left: 132px'>등록된 상품이 존재하지 않습니다.</div>";
            html += "</td>";
            html += "</tr>";
            html += "</table>";
        } else {
            for (var i = 0; i < data.productList.length; i++) {
                if (i == 0) {
                    html += "<table class='product-table'>";
                }
                if (i % 5 == 0) {
                    html += "<tr>";
                    console.log(i);
                }
                html += "<td class='product'><div class='product-box' onclick='productDetail(" + data.productList[i].productId + ")'>" + "<img id='productImg' src='${pageContext.request.contextPath}/resources/upload/product/" + data.productImageList[i].productImgRenamed + "'>" + "</div>";
                html += "<div class='pro-title'>" + data.productList[i].productName + "</div>";
                html += "<div class='pro-price'>" + data.productList[i].productPrice + "원</div>";
                html += "</td>";
                if ((i + 1) % 5 == 0) {
                    html += "</tr>";
                }
                if (i == data.productList.length - 1) {
                    html += "</table>";
                }
            }
        }
        $('#product-list').append(html);
    }
</script>
<div class="div-division">
    <div class="left">전체</div>
    <div class="right" id="totalDiv">00개</div>
    <div id='btn_group'>
        <button id='btncurrent' value='cu' onclick='btn_group()' class='btngropu4'>최신 |</button>
        <button id='btnrowprice' value='row' onclick='btn_group()' class='btngropu4'>저가 |</button>
        <button id='btnhighprice' value='hig' onclick='btn_group()' class='btngropu4'>고가 |</button>
    </div>
</div>
<div id="product-list"></div>