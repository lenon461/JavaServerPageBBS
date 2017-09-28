package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.board;

public class boardDAO {

	private Connection conn;
	private ResultSet rs;

	public boardDAO() {
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

	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";// 데이터베이스 오류
	}

	public int getNext() {
		String SQL = "SELECT boardNum FROM customboard ORDER BY boardNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;// 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류
	}
	public int write(String boardTitle, String userID, String boardContent) {
		String SQL = "INSERT INTO CUSTOMBOARD VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();// 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류
		
	}

	public ArrayList<board> getlist(int pageNumber) {
		String SQL = "SELECT * FROM customboard WHERE boardNum < ? AND boardAvailable = 1 ORDER BY boardNum DESC LIMIT 10";
		ArrayList<board> list = new ArrayList<board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				board bbs = new board();
				bbs.setBoardNum(rs.getInt(1));
				bbs.setBoardTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBoardDate(rs.getString(4));
				bbs.setBoardContent(rs.getString(5));
				bbs.setBoardAvailable(rs.getInt(6));

				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM customboard WHERE boardNum < ? AND boardAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public board getBoard(int boardNum) {
		String SQL = "SELECT * FROM CUSTOMBOARD WHERE boardNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				board bbs = new board();
				bbs.setBoardNum(rs.getInt(1));
				bbs.setBoardTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBoardDate(rs.getString(4));
				bbs.setBoardContent(rs.getString(5));
				bbs.setBoardAvailable(rs.getInt(6));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int update(int boardNum, String boardTitle, String boardContent) {
		String SQL = "UPDATE CUSTOMBOARD SET boardTitle = ? ,boardContent = ? WHERE boardNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardNum);
			return pstmt.executeUpdate();// 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류

	}
	public int delete(int boardNum) {
		String SQL = "UPDATE CUSTOMBOARD SET boardAvailable = 0 WHERE boardNum = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardNum);
			return pstmt.executeUpdate();// 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;// 데이터베이스 오류

	}
}
