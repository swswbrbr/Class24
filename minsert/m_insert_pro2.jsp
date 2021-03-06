<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "kr.or.ksmart.driverdb.DriverDB" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "kr.or.ksmart.dto.Member" %>

<%
	request.setCharacterEncoding("euc-kr");
	Connection conn = null;
	PreparedStatement pstmt = null;
//화면에서 입력자료 받아서 콘솔창에 출력 시작
	String m_id = request.getParameter("id");
	String m_pw = request.getParameter("pw");
	String m_level = request.getParameter("level");
	String m_name = request.getParameter("name");
	String m_email = request.getParameter("email");
	System.out.println(m_id + "<-- m_id /minsert/m_insert_pro.jsp");
	System.out.println(m_pw + "<-- m_pw /minsert/m_insert_pro.jsp");
	System.out.println(m_level + "<-- m_level /minsert/m_insert_pro.jsp");
	System.out.println(m_name + "<-- m_name /minsert/m_insert_pro.jsp");
	System.out.println(m_email + "<-- m_email /minsert/m_insert_pro.jsp");
	
	Member m = new Member();
	m.setM_id(m_id);
	m.setM_pw(m_pw);
	m.setM_level(m_level);
	m.setM_name(m_name);
	m.setM_email(m_email);
	
	
	try{
		DriverDB driverdb = new DriverDB();
		conn = driverdb.driverDBcon();
		System.out.println(conn+" <-- conn");
//03단계 :Query실행을 위한 statement 또는 prepareStatement객체생성 시작
		pstmt = conn.prepareStatement("INSERT INTO tb_member VALUES (?, ?, ?, ?, ?)");
		System.out.println(pstmt +"<-- pstmt1");

//insert into tb_member values('id001','pw001','관리자','홍01','email01');
		pstmt.setString(1, m.getM_id());
		pstmt.setString(2, m.getM_pw());
		pstmt.setString(3, m.getM_level());
		pstmt.setString(4, m.getM_name());
		pstmt.setString(5, m.getM_email());
		System.out.println(pstmt +"<-- pstmt2");
//03단계 :Query실행을 위한 statement 또는 prepareStatement객체생성 끝
//04단계 :Query실행 시작
		int result = pstmt.executeUpdate();
		System.out.println(result +"<-- result");
		response.sendRedirect(request.getContextPath()+ "/mlist/m_list.jsp");
//04단계 :Query실행 끝
//05단계 :Query실행결과 사용 (insert의 경우 생략 가능단계)

	}finally{
		//06단계 :statement 또는 prepareStatement객체 종료(close())
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		//07단계 :Connection 객체 종료(close())
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}

%>