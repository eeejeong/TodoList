package com.todolist.web.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.todolist.web.dto.Todolist;

@Component
public class TodoListDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	// 할 일 추가
	public void insertItem(Todolist item) {
		sqlSessionTemplate.insert("todoList.insertItem", item);		
	}

	// 할 일 목록 불러오기 
	public List<Todolist> selectTodoListItems() {
		List<Todolist> todoList = sqlSessionTemplate.selectList("todoList.selectTodoItems");
		return todoList;
	}
	
	// 완료한 일 목록 불러오기
	public List<Todolist> selectDoneListItems() {
		List<Todolist> doneList = sqlSessionTemplate.selectList("todoList.selectDoneItems");
		return doneList;
	}

	// 할 일 삭제
	public void deleteItem(int no) {
		sqlSessionTemplate.delete("todoList.deleteItem", no);
		
	}

	// 할 일 상태 수정
	public void updateStatus(int no, String status) {
		Map<String, Object> map = new HashMap<>();
		map.put("no", no);
		map.put("status", status);
		sqlSessionTemplate.update("todoList.updateStatus", map);	
	}

	
}
