package com.epam.non_working_option;

/**
 * В таблице стоит Auto Increment ID.
 * Добавляем студента, получаем его по id.
 */
public class App {

    public static void main(String[] args) {
        Repository repository = new Repository();
        repository.addNewStudent("Misha", "Zax");
        System.out.println(repository.getStudentById(5).get());
    }
}
