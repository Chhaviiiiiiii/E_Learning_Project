package com.cdgi.daoimpl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.cdgi.dao.QuizDao;
import com.cdgi.pojo.Quiz;
import com.cdgi.repository.QuizRepository;

@Repository
@Transactional
public class QuizDaoImpl implements QuizDao {

	@Autowired
	private QuizRepository quizRepository;
	
   

    @Override
    public boolean addQuiz(Quiz q) {
    	try {
			Optional<Quiz>op = quizRepository.findById(q.getId());
			if(op.isPresent())
			{
				return false;
			}
			else
			{
			quizRepository.save(q);
			return true;
			}	
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return false;
		}
    }

    
    @Override
    public boolean updateQuiz(Quiz q) {
 	try {
			Optional<Quiz>op = quizRepository.findById(q.getId());
			if(op.isPresent())
			{
			quizRepository.save(q);
			return true;
			}
			else
				return false;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
    }

    
    
    @Override
    public boolean deleteQuiz(int id) {
        try {
            // ✅ Parameter wala id use karo
            Optional<Quiz> op = quizRepository.findById(id);
            if (op.isPresent()) {
                quizRepository.deleteById(id);
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
      
    @Override
    public List<Quiz> getAllQuiz() {
    	try {
			List<Quiz>lst =(List<Quiz>) quizRepository.findAll();
			return lst;	
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    @Override
    public Quiz getQuizById(int id) {
        try {
            Optional<Quiz> op = quizRepository.findById(id);
            if(op.isPresent()) return op.get();
            else return null;
        } catch(Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}