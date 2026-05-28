-- OEMS (Online Examination Management System)
-- MySQL schema for APEKI TUMBA (foundation)
--
-- Import in phpMyAdmin:
-- 1) Create database (example: oems)
-- 2) Select database
-- 3) Import this SQL file

SET sql_mode = 'STRICT_ALL_TABLES';
SET time_zone = '+00:00';

-- Exams
CREATE TABLE IF NOT EXISTS exams (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT NULL,
  scheduled_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Questions
CREATE TABLE IF NOT EXISTS questions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  exam_id INT NOT NULL,
  prompt TEXT NOT NULL,
  question_type ENUM('single_choice','multiple_choice','text') NOT NULL DEFAULT 'single_choice',
  options_json JSON NULL,
  correct_answer_json JSON NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_questions_exam
    FOREIGN KEY (exam_id) REFERENCES exams(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exam attempts / submissions
CREATE TABLE IF NOT EXISTS exam_attempts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  exam_id INT NOT NULL,
  student_name VARCHAR(255) NOT NULL,
  answers_json JSON NULL,
  score INT NULL,
  started_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  submitted_at TIMESTAMP NULL,
  CONSTRAINT fk_attempts_exam
    FOREIGN KEY (exam_id) REFERENCES exams(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Helpful indexes
CREATE INDEX IF NOT EXISTS idx_questions_exam_id ON questions(exam_id);
CREATE INDEX IF NOT EXISTS idx_attempts_exam_id ON exam_attempts(exam_id);

