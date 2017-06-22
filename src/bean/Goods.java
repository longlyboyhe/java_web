package bean;


public class Goods {
    private int id;  //商品编号
    private String name;//商品名称
    private String type;//商品类型
    private String useWay;//商品用途
    private float price;//商品价格
    private String pic; //商品图片
    private int stock; //库存

    public Goods(int id, String name, String type, String useWay, float price, String pic, int stock) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.useWay = useWay;
        this.price = price;
        this.pic = pic;
        this.stock = stock;
    }


    public Goods(String name, String type, String useWay, float price, String pic, int stock) {
        this.name = name;
        this.type = type;
        this.useWay = useWay;
        this.price = price;
        this.pic = pic;
        this.stock = stock;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public void setId(int id) {
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

    public int getId() {
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
