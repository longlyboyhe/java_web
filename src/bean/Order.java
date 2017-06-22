package bean;

import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.HashMap;

//订单表
public class Order {
    private int orderId;
    private int serialNumber;
    private int orderUserId;
    private String address;
    private String phoneNumber;
    private String orderDate;
    private boolean hasOver;    //收否接单
    /**
     * 格式为goodsId1-number1-goodsId2-number2
     * 商品ID-用户购买数量
     */
    private String orderGoodsIds;

    private ArrayList<HashMap<String, Object>> goodsMap;

    public ArrayList<HashMap<String, Object>> getGoodsMap() {
        return goodsMap;
    }

    public void setHasOver(boolean hasOver) {
        this.hasOver = hasOver;
    }

    public boolean isHasOver() {
        return hasOver;
    }

    public Order(int serialNumber, int orderUserId, String address, String phoneNumber, String orderDate, String orderGoodsIds) {
        this.serialNumber = serialNumber;
        this.orderUserId = orderUserId;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.orderDate = orderDate;
        this.orderGoodsIds = orderGoodsIds;
    }

    public Order(int orderId, int orderUserId, int serialNumber, String address, String phoneNumber, String orderDate, String orderGoodsIds, boolean hasOver) {
        this.orderId = orderId;
        this.orderUserId = orderUserId;
        this.serialNumber = serialNumber;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.orderDate = orderDate;
        this.orderGoodsIds = orderGoodsIds;
        this.hasOver = hasOver;
        this.goodsMap = new ArrayList<>();
        String[] datas = orderGoodsIds.split("-");
        for (int i = 0; i < datas.length; i += 2) {
            HashMap<String, Object> map = new HashMap<>(2);
            map.put("goods", Integer.parseInt(datas[i]));
            map.put("number", Integer.parseInt(datas[i + 1]));
            goodsMap.add(map);
        }
    }

    public Order(int serialNumber, int orderUserId, String address, String phoneNumber, String orderDate, ArrayList<HashMap<String, Object>> array) {
        this.serialNumber = serialNumber;
        this.orderUserId = orderUserId;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.orderDate = orderDate;
        StringBuilder builder = new StringBuilder();
        int i = 0;
        for (HashMap<String, Object> map : array) {
            Goods goods = (Goods) map.get("goods");
            int num = (int) map.get("number");
            if (i == array.size() - 1) {
                builder.append(goods.getId()).append("-").append(num);
            } else {
                builder.append(goods.getId()).append("-").append(num).append("-");
            }
            i++;
        }
        this.orderGoodsIds = builder.toString();
    }

    public String getOrderGoodsIds() {
        return orderGoodsIds;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public void setSerialNumber(int serialNumber) {
        this.serialNumber = serialNumber;
    }

    public void setOrderUserId(int orderUserId) {
        this.orderUserId = orderUserId;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }


    public int getOrderId() {
        return orderId;
    }

    public int getSerialNumber() {
        return serialNumber;
    }

    public int getOrderUserId() {
        return orderUserId;
    }

    public String getAddress() {
        return address;
    }

    public String getOrderDate() {
        return orderDate;
    }

    @Override
    public String toString() {
        return new Gson().toJson(this);
    }
}
