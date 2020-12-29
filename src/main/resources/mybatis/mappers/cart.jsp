<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="mapper.cart">

    <!-- 리절트 맵 정의 -->
    <resultMap id="cartResult" type="CartVO">
        <result property="cart_id" column="cart_id"/>
        <result property="goods_id" column="goods_title"/>
        <result property="member_id" column="member_id"/>
        <result property="cart_goods_qty" column="cart_goods_qty"/>
        <result property="creDate" column="creDate"/>
    </resultMap>

    <resultMap id="goodsResult" type="GoodsVO">
        <result property="goods_id" column="goods_id"/>
        <result property="goods_title" column="goods_title"/>
        <result property="goods_writer" column="goods_writer"/>
        <result property="goods_price" column="goods_price"/>
        <result property="goods_publisher" column="goods_publisher"/>

        <result property="goods_status" column="goods_status"/>
        <result property="goods_sales_price" column="goods_sales_price"/>
        <result property="goods_published_date" column="goods_published_date"/>
        <result property="goods_total_page" column="goods_total_page"/>
        <result property="goods_isbn" column="goods_isbn"/>
        <result property="goods_delivery_price" column="goods_delivery_price"/>
        <result property="goods_delivery_date" column="goods_delivery_date"/>

        <result property="goods_fileName" column="fileName"/>
        <result property="goods_sort" column="goods_sort"/>
        <result property="goods_writer_intro" column="goods_writer_intro"/>
        <result property="goods_contents_order" column="goods_contents_order"/>
        <result property="goods_intro" column="goods_intro"/>
    </resultMap>

    <select id="selectCountInCart" resultType="String" parameterType="cartVO">
        <![CDATA[
        select decode(count(*), 0, 'false', 'true') from t_shopping_cart
        where goods_id=#{goods_id}
        and member_id=#{member_id}
        ]]>
    </select>

    <insert id="insertGoodsInCart" parameterType="cartVO">
        <![CDATA[
        insert into t_shopping_cart(cart_id,
        goods_id,
        member_id)
        values(#{cart_id},
        #{goods_id},
        #{member_id})
        ]]>
    </insert>

</mapper>