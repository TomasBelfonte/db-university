1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT `students`.`surname` AS `Cognome_Studente`,
		`students`.`name` AS `Nome_Studente`,
        `degrees`.`name` AS `Corso_di Laurea`
FROM `degrees`
INNER JOIN `students`
	ON `students`.`degree_id`=`degrees`.`id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia"
ORDER BY `Cognome_Studente`;

2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT `departments`.`id`,`departments`.`name`,`degrees`.`level`,`degrees`.`name`
FROM `departments`
INNER JOIN `degrees`
	ON `degrees`.`department_id` = `departments`.`id`
WHERE `degrees`.`level` = "magistrale"
	AND `departments`.`name`= "Dipartimento di Neuroscienze";

3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT `courses`.`id`,
		`courses`.`description`,
        `courses`.`period`,
        `course_teacher`.`teacher_id`,
        `teachers`.`name`,
        `teachers`.`surname` 
FROM `courses`
INNER JOIN `course_teacher`
	ON `course_teacher`.`course_id` = `courses`.`degree_id`
INNER JOIN `teachers`
	ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `teachers`.`surname` = "Amato"
	AND `teachers`.`name` = "Fulvio";

4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT `students`.`surname` , 
		`students`.`name`,
        `degrees`.`name`,
        `departments`.`name`
FROM `students`
INNER JOIN `courses`
	ON `courses`.`degree_id` = `students`.`degree_id`
INNER JOIN `degrees`
	ON `degrees`.`department_id` = `courses`.`degree_id`
INNER JOIN `departments`
	ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname` ASC;

5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `degrees`.`name` AS `Corso_di_Laurea`,
        `courses`.`name` AS `Insegnamento`,
        `teachers`.`surname` AS `Cognome_Docente`,
        `teachers`.`name` AS `Nome_Docente` 
FROM `courses`
INNER JOIN `course_teacher`
	ON `course_teacher`.`course_id` = `courses`.`degree_id`
INNER JOIN `degrees`
	ON `degrees`.`department_id` = `course_teacher`.`course_id`
INNER JOIN `teachers`
	ON `teachers`.`id` = `course_teacher`.`teacher_id`
ORDER BY `degrees`.`name`;

6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT `departments`.`name` AS `Nome_Dipartimeto`,
		`degrees`.`department_id`,
        `degrees`.`name` AS `Insegnamento`,
        `teachers`.`surname` AS `Cognome_Docente`,
        `teachers`.`name` AS `Nome_Docente`
FROM `degrees`
INNER JOIN `course_teacher`
	ON `course_teacher`.`course_id` = `degrees`.`department_id`
INNER JOIN `teachers`
	ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `departments`
	ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = "Dipartimento di Matematica";


# Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica
SELECT DISTINCT 
	`teachers`.`name`, 
	`teachers`.`surname`,
	`teachers`.`phone`,
    `teachers`.`email`, 
    `teachers`.`office_address`,
	`teachers`.`office_number`
FROM `teachers`
JOIN `course_teacher`
	ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
	ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
	ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments`
	ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Matematica'
ORDER BY `teachers`.`surname`, `teachers`.`name`;


7. BONUS: Selezionare per ogni studente quanti tentativi di esame ha sostenuto per superare ciascuno dei suoi esami

    

	# BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
# superare ciascuno dei suoi esami
SELECT `students`.`id` AS `studente`,
`courses`.`id` AS `corso`,
COUNT(`exams`.`id`),
MAX(`exam_student`.`vote`) as `voto_migliore`
FROM `students`
JOIN `exam_student`
	ON `students`.`id` = `exam_student`.`student_id`
JOIN `exams`
	ON `exam_student`.`exam_id` = `exams`.`id`
JOIN `courses`
	ON `exams`.`course_id` = `courses`.`id`
GROUP BY `students`.`id`, `courses`.`id`
HAVING `voto_migliore` >= 18;
