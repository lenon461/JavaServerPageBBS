package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.User;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "11209qwe";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM CUSTOMUSER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword))
					return 1; // �α��μ���
				else
					return 0; // �α��ν���

			}
			return -1; // ���̵� ����
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // ������ ���̽� ����
	}

	public int join(User user) {
		String SQL = "INSERT INTO CUSTOMUSER VALUES (?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, user.getUserNum());
			pstmt.setString(2, user.getUserID());
			pstmt.setString(3, user.getUserPassword());
			pstmt.setString(4, user.getUserName());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public User getUser(String userID) {
		String SQL = "SELECT * FROM CUSTOMUSER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setUserNum(rs.getInt(1));
				user.setUserID(rs.getString(2));
				user.setUserPassword(rs.getString(3));
				user.setUserName(rs.getString(4));
				
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(String UserID, String UserPassword, String UserName) {
		String SQL = "UPDATE CUSTOMUSER SET USERPASSWORD = ? ,USERNAME = ? WHERE USERID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, UserPassword);
			pstmt.setString(2, UserName);
			pstmt.setString(3, UserID);
			return pstmt.executeUpdate(); //
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// �����ͺ��̽� ����

	}
}
