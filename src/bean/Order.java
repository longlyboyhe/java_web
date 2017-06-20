package bean;

//订单表
public class Order {
    private int orderId;
    private int serialNumber;
    private int orderUserId;
    private String address;
    private String orderDate;
    private String orderTime;

    public Order(int orderId, int serialNumber, int orderUserId, String address) {
        this.orderId = orderId;
        this.serialNumber = serialNumber;
        this.orderUserId = orderUserId;
        this.address = address;
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

    public void setOrderTime(String orderTime) {
        this.orderTime = orderTime;
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

    public String getOrderTime() {
        return orderTime;
    }
}
