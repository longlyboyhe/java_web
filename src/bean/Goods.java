package bean;


public class Goods {
    private String id;  //商品编号
    private String name;//商品名称
    private String type;//商品类型
    private String useWay;//商品用途
    private float price;//商品价格
    private String pic; //商品图片

    public Goods(String id, String name, String type, String useWay, float price, String pic) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.useWay = useWay;
        this.price = price;
        this.pic = pic;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setUseWay(String useWay) {
        this.useWay = useWay;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }

    public String getUseWay() {
        return useWay;
    }

    public float getPrice() {
        return price;
    }

    public String getPic() {
        return pic;
    }

    @Override
    public String toString() {
        return "Goods{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", type='" + type + '\'' +
                ", useWay='" + useWay + '\'' +
                ", price=" + price +
                ", pic='" + pic + '\'' +
                '}';
    }
}
