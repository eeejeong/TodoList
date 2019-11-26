package com.todolist.web.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todolist.web.dto.Todolist;
import com.todolist.web.service.TodoListService;

@Controller
public class HomeController {
	
	@Autowired
	private TodoListService service;
	
	// 홈페이지 화면 매핑 주소입니다.
	@RequestMapping("/")
	public String home(Model model) {
		List<Todolist> todoList = service.getTodoListItems();
		List<Todolist> doneList = service.getDoneListItems();
		model.addAttribute("todoList", todoList);
		model.addAttribute("doneList", doneList);
		return "home";
	}
	
	// 할 일 [추가] 버튼을 눌렀을 때 매핑 주소입니다.
	@RequestMapping("/addItem")
	public String addItem(Todolist item) {
		// 매개값으로 전달된 item을 table에 삽입합니다.
		service.addItem(item);
		return "redirect:/";
	}
	
	// 할 일 [삭제] 버튼을 눌렀을 때 매핑 주소입니다.
	@RequestMapping("/deleteItem")
	public void addItem(int no, HttpServletResponse response) throws Exception{
		// 매개값으로 전달된 no에 해당하는 할 일을 삭제합니다.
		service.deleteItem(no);
		
		// ajax의 요청이 처리되면 응답으로 json 타입 객체를 전송합니다.
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", true);
		pw.print(jsonObject.toString());
		pw.flush();
		pw.close();
	}
	
	// [완료] 혹은 [미완료] 버튼을 눌렀을 때 매핑 주소입니다.
	@RequestMapping("/changeStatus")
	public void changeStatus(int no, String status, HttpServletResponse response) throws Exception{
		// 매개값으로 전달된 no에 해당하는 할 일의 status를 변경합니다.
		// [완료] - status: 'Y'
		// [미완료] - status: 'N'
		service.changeStatus(no, status);
		
		// ajax의 요청이 처리되면 응답으로 json 타입 객체를 전송합니다.
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter pw = response.getWriter();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("result", true);
		pw.print(jsonObject.toString());
		pw.flush();
		pw.close();
	}

}
