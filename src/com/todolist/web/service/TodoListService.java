package com.todolist.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todolist.web.dao.TodoListDao;
import com.todolist.web.dto.Todolist;

@Service
public class TodoListService {
	
	@Autowired
	private TodoListDao dao;
	
	// 할 일 목록 조회
	public List<Todolist> getTodoListItems() {
		List <Todolist> todoList = dao.selectTodoListItems();
		return todoList;
	}
	
	// 완료한 일 목록 조회
	public List<Todolist> getDoneListItems() {
		List <Todolist> doneList = dao.selectDoneListItems();
		return doneList;
	}

	// 할 일 추가
	public void addItem(Todolist item) {
		dao.insertItem(item);
	}

	// 할 일 제거
	public void deleteItem(int no) {
		dao.deleteItem(no);		
	}

	// 할 일 상태 변경
	public void changeStatus(int no, String status) {
		dao.updateStatus(no, status);
	}


}
