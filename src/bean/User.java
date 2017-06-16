package bean;


public class User {
    public static final int ADMIN_USER = 1;
    public static final int NORMAL_USER = 0;
    private int id; //用户id
    private String name;
    private String nickName;
    private String pwd;
    private String phoneNum;
    private int userType;

    public User(String name, String nickName, String pwd, String phoneNum, int userType) {
        this.name = name;
        this.nickName = nickName;
        this.pwd = pwd;
        this.phoneNum = phoneNum;
        this.userType = userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }

    public int getUserType() {
        return userType;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getNickName() {
        return nickName;
    }

    public String getPwd() {
        return pwd;
    }

    public String getPhoneNum() {
        return phoneNum;
    }
}
