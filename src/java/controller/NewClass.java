/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.AirplaneDAO;
import java.util.List;
import model.Airplane;

/**
 *
 * @author A A
 */
public class NewClass {
    public static void main(String[] args) {
        AirplaneDAO airplaneDao = new AirplaneDAO();
        List<Airplane> airplaneList = airplaneDao.list();
        for (Airplane airplane : airplaneList) {
            System.out.println(airplane);
        }
    }
}
